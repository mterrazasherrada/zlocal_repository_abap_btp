CLASS zcl_shop_api_create_h05 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_shop_api_create_h05 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA:
      ls_business_data TYPE zonline_shopf9e8c4c00b,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_create,
      lo_response      TYPE REF TO /iwbep/if_cp_response_create.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_H05'
*                                             comm_system_id = '<Comm System Id>'
                                                     service_id     = 'Z_SHOP_API_CREATE_OBS_H05_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SCM_H05'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).

        ASSERT lo_http_client IS BOUND.



* Prepare business data
        ls_business_data = VALUE #(
                  order_uuid    = '11112222333344445555666677778888'
                  order_id      = 'OrderId'
                  ordereditem   = 'Ordereditem'
                  deliverydate  = 20170101123000
                  creationdate  = 20170101123000
                  packageid     = 10
                  costcenter    = 'Costcenter'
                  purchasereqn  = 'Purchasereqn' ).

        " Navigate to the resource and create a request for the create operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->create_request_for_create( ).

        " Set the business data for the created entity
        lo_request->set_business_data( ls_business_data ).

        " Execute the request
        lo_response = lo_request->execute( ).

        " Get the after image
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        response->set_text( |Remote Error: { lx_remote->get_longtext( ) }| ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        response->set_text( |Gateway Error: { lx_gateway->get_longtext( ) }| ).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        response->set_text( |HTTP Client Error: { lx_web_http_client_error->get_longtext( ) }| ).
        RAISE SHORTDUMP lx_web_http_client_error.
      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        response->set_text( |Destination Error: { lx_dest->get_longtext( ) }| ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
