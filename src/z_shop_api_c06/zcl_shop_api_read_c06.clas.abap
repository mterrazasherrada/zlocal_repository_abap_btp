class ZCL_SHOP_API_READ_C06 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_C06 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

DATA:
  ls_entity_key    TYPE ZONLINE_SHOPE33CDBED30,
  ls_business_data TYPE ZONLINE_SHOPE33CDBED30,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



  TRY.
     " Create http client
     DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_C06'
*                                             comm_system_id = '<Comm System Id>'
                                             service_id     = 'Z_SHOP_API_READ_OBS_C06_REST' ).
     lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     ASSERT lo_http_client IS BOUND.
     " If you like to use IF_HTTP_CLIENT you must use the following factory: /IWBEP/CL_CP_CLIENT_PROXY_FACT
*     lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
*       EXPORTING
*          is_proxy_model_key       = VALUE #( repository_id       = 'SRVD'
*                                              proxy_model_id      = 'Z_SHOP_API_SCM_C04'
*                                              proxy_model_version = '0001' )
*         io_http_client             = lo_http_client
*         iv_relative_service_root   = '<service_root>' ).

       lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
         EXPORTING
         iv_service_definition_name = 'Z_SHOP_API_SCM_C06'
         io_http_client = lo_http_client
         iv_relative_service_root = '' ).

" Set entity key
     ls_entity_key = VALUE #(
          order_uuid  = 'E7AA1C3D298B1EDE81F6C2D0BCB08531' ).

" Navigate to the resource
      lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
      lo_response = lo_resource->create_request_for_read( )->execute( ).
      lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

   DATA: result TYPE string.
      result = | OrderID: { ls_business_data-Order_Id }, Ordered Item: {
                                                          ls_business_data-Ordereditem } |.
      response->set_text( result ).

  CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection
     response->set_text( | Remote error: { lx_remote->get_longtext( ) } | ).
  CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception
     response->set_text( | Gateway error: { lx_gateway->get_longtext( ) } | ).
  CATCH cx_web_http_client_error INTO DATA(lx_http_error).
" Handle Exception
   response->set_text( | HTTP error: { lx_http_error->get_longtext( ) } | ).
 "RAISE SHORTDUMP lx_web_http_client_error.
    CATCH CX_HTTP_DEST_PROVIDER_ERROR INTO DATA(lx_http_dest).
      response->set_text( | HTTP error: { lx_http_dest->get_longtext( ) } | ).
  ENDTRY.
  endmethod.
ENDCLASS.
