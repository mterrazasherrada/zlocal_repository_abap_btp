CLASS zcl_shop_api_read_c37 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_shop_api_read_c37 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA:
      ls_entity_key    TYPE zonline_shopb6a44be040, "<structure_name>,
      ls_business_data TYPE zonline_shopb6a44be040, "<structure_name>,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.



    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_C37'
*                                                     comm_system_id = '<Comm System Id>'
                                                     service_id     = 'Z_SHOP_API_READ_OBS_C37_REST' ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SCM_C37'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).

        ASSERT lo_http_client IS BOUND.



        " Set entity key
        ls_entity_key = VALUE #(
                  order_uuid  = '357DF7EF1A351EEE97B3DB5A8AC601A8' ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        data lv_result TYPE string.
        lv_result = |Order ID: { ls_business_data-Order_Id }, Order Item: { ls_business_data-Ordereditem }.|.
        response->set_text( lv_result ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        response->set_text( |Remote Error: { lx_remote->get_longtext(  ) }| ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        response->set_text( |Gateway Error: { lx_gateway->get_longtext(  ) }| ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_destination).
        response->set_text( |Destination Error: { lx_destination->get_longtext(  ) }| ).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        response->set_text( |HTTP Client Erro: { lx_web_http_client_error->get_longtext(  ) }| ).

        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.

  ENDMETHOD.
ENDCLASS.
