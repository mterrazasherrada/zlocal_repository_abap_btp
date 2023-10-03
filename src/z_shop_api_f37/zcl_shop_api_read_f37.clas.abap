CLASS zcl_shop_api_read_f37 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_F37 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.


    DATA:
      ls_entity_key    TYPE zonline_shop2623aecae6,
      ls_business_data TYPE zonline_shop2623aecae6,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    DATA: result TYPE string.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_F37'
                                                     service_id     = 'Z_SHOP_API_READ_OBS_F37_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        ASSERT lo_http_client IS BOUND.
        " If you like to use IF_HTTP_CLIENT you must use the following factory: /IWBEP/CL_CP_CLIENT_PROXY_FACT
        "lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
        "  EXPORTING
        "     is_proxy_model_key       = VALUE #( repository_id       = 'SRVD'
        "                                         proxy_model_id      = 'Z_SHOP_API_SCM_F37'
        "                                         proxy_model_version = '0001'
        "                                         )
        "    io_http_client             = lo_http_client
        "    iv_relative_service_root   = '' ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
        EXPORTING
        iv_service_definition_name = 'Z_SHOP_API_SCM_F37'
        io_http_client = lo_http_client
        iv_relative_service_root = ''
        ).



        " Set entity key
        ls_entity_key = VALUE #(
                  order_uuid  = 'DF0B7D5455421EEE89F70CE1CFEB1566' ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        result = | OrderID: { ls_business_data-Order_Id }, Purchase Requisition ID: { ls_business_data-Purchasereqn } |.
        response->set_text( result ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).

        " Handle Exception
      CATCH cx_http_dest_provider_error INTO DATA(lx_destination).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.
  ENDMETHOD.
ENDCLASS.
