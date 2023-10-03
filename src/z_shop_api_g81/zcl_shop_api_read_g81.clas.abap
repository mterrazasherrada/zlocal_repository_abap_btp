class ZCL_SHOP_API_READ_G81 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_G81 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

DATA:
  ls_entity_key    TYPE ZONLINE_SHOPA48E5D09C1,
  ls_business_data TYPE ZONLINE_SHOPA48E5D09C1,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_G81'
*                                             comm_system_id = '<Comm System Id>'
                                             service_id     = 'Z_SHOP_API_READ_OBS_G81_REST' ).
lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
       EXPORTING
         iv_service_definition_name = 'Z_SHOP_API_SCM_G81'
         io_http_client             = lo_http_client
         iv_relative_service_root   = '' ).

     ASSERT lo_http_client IS BOUND.



" Set entity key
ls_entity_key = VALUE #(
          order_uuid  = '357DF7EF1A351EEE95DFCCB68F0321A3' ).

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
" Handle remote Exception
" It contains details about the problems of your http(s) connection

CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
response->set_text( |Gateway Error: { lx_gateway->get_longtext(  ) }| ).
" Handle Exception

CATCH cx_http_dest_provider_error INTO DATA(lx_destination).
response->set_text( |Destination Error: { lx_destination->get_longtext(  ) }| ).


CATCH cx_web_http_client_error INTO DATA(lx_http).
response->set_text( |HTTP Client Error: { lx_http->get_longtext(  ) }| ).
" Handle Exception
 RAISE SHORTDUMP lx_http.


ENDTRY.
  endmethod.
ENDCLASS.
