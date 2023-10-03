CLASS zcl_shop_api_create_a06 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_API_CREATE_A06 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.




    DATA:
      ls_business_data TYPE zonline_shop38f2d5ba46,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_create,
      lo_response      TYPE REF TO /iwbep/if_cp_response_create.


    TRY.
        " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = '<Comm Scenario>'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SCM_A06'
            io_http_client             = lo_http_client
            iv_relative_service_root   = 'Z_SHOP_API_CREATE_OBS_A06_REST' ).

*lo_client_proxy = /iwbep/cl_cp_factory_alv5=>create_v2_remote_proxy(
*  EXPORTING
*    is_proxy_model_key       = value #( repository_id       = /iwbep/if_cp_registry_types=>gcs_repository_id-srvd
*                                        proxy_model_id      = 'Z_SHOP_API_SCM_A06'
*                                        proxy_model_version = '0001' )
*    io_http_client             = lo_http_client
*    iv_relative_service_root   = '<service_root>' ).



* Prepare business data
        ls_business_data = VALUE #(
                  order_uuid    = '11112222333344445555666677778888'
                  order_id      = '2'
                  ordereditem   = 'B002'
                  deliverydate  = 20170101123000
                  creationdate  = 20170101123000
                  packageid     = 33
                  costcenter    = ''
                  purchasereqn  = '' ).

        " Navigate to the resource and create a request for the create operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->create_request_for_create( ).

        " Set the business data for the created entity
        lo_request->set_business_data( ls_business_data ).

        " Execute the request
        lo_response = lo_request->execute( ).

        " Get the after image
*lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

      "result
        DATA: result TYPE string.
        result = | OrderID: { ls_business_data-Order_Id },  Ordered Item: { ls_business_data-Ordereditem  } |.
        response->set_text( result ).





      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        response->set_text( | Remote Error: { lx_remote->get_longtext(  ) } | ).
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        response->set_text( | Gateway Error: { lx_gateway->get_longtext(  ) } | ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_destination).
        "handle exception
        response->set_text( | Destination Error: { lx_destination->get_longtext(  ) } | ).
      CATCH cx_web_http_client_error INTO DATA(lx_http).
        "handle exception
        response->set_text( | HTTP Error: { lx_http->get_longtext(  ) } | ).

    ENDTRY.








  ENDMETHOD.
ENDCLASS.
