CLASS zcl_shop_api_read_b47 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_B47 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.


    DATA:
      ls_entity_key    TYPE zonline_shop804277937d,
      ls_business_data TYPE zonline_shop804277937d,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.



    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_B47'
*                                             comm_system_id = '<Comm System Id>'
                                                     service_id     = 'Z_SCHOP_API_READ_OBS_B47_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SCM_B47'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).

*lo_client_proxy = /iwbep/cl_cp_factory_alv5=>create_v2_remote_proxy(
*  EXPORTING
*    is_proxy_model_key       = value #( repository_id       = /iwbep/if_cp_registry_types=>gcs_repository_id-srvd
*                                        proxy_model_id      = 'Z_SHOP_API_SCM_B47'
*                                        proxy_model_version = '0001' )
*    io_http_client             = lo_http_client
*    iv_relative_service_root   = '<service_root>' ).



        " Set entity key
        ls_entity_key = VALUE #(
*                  order_uuid  = '7FE7C763A98E1EDD94F4F742082E41F9' ).
                  order_uuid  = 'DD5F294E1FD01EEDBA9D2F6C5DDEB999' ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        DATA lv_result TYPE string.
        lv_result = |Order ID: { ls_business_data-Order_Id }, Ordered Item: { ls_business_data-Ordereditem }.|.
        response->set_text( lv_result ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        response->set_text( |Remote Error: { lx_remote->get_longtext(  ) }| ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        response->set_text( |Remote Error: { lx_remote->get_longtext(  ) }| ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_destination).
        response->set_text( |Remote Error: { lx_remote->get_longtext(  ) }| ).

      CATCH cx_web_http_client_error INTO DATA(lx_http).
        response->set_text( |Remote Error: { lx_remote->get_longtext(  ) }| ).


    ENDTRY.

  ENDMETHOD.
ENDCLASS.
