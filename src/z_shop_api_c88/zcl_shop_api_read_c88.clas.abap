CLASS zcl_shop_api_read_c88 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_C88 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA:
      ls_business_data TYPE zonline_shop56022d9c66,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_create,
      lo_response      TYPE REF TO /iwbep/if_cp_response_create.


    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_C88'
                                                     service_id     = 'Z_SHOP_API_READ_OBS_C88_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        ASSERT lo_http_client IS BOUND.

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SCM_C88'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).


* Prepare business data
        ls_business_data = VALUE #(
                  order_uuid    = 'E7AA1C3D298B1EEE85EF4DD9B99EDF24'
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
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        DATA(lv_result) = |Order ID: {  ls_business_data-Order_Id }, Ordered Item: {  ls_business_data-Ordereditem }|.
        response->set_text( lv_result ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        response->set_text( |Error: { lx_remote->get_longtext( ) }| ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        response->set_text( |Error: { lx_gateway->get_longtext( ) }| ).

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        response->set_text( |Error: { lx_web_http_client_error->get_longtext( ) }| ).

      catch cx_http_dest_provider_error INTO DATA(lx_dest).
        response->set_text( |Error: { lx_dest->get_longtext( ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
