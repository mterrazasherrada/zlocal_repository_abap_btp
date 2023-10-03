class ZCL_ONLINESHOP_API_OB_H18_REST definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ONLINESHOP_API_OB_H18_REST IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

DATA:
  ls_entity_key    TYPE ZONLINE_SHOPB473EA53CF,
  ls_business_data TYPE ZONLINE_SHOPB473EA53CF,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'Z_ONLINESHOP_API_OB_SCEN_H18'
*                                             comm_system_id = '<Comm System Id>'
                                             service_id     = 'Z_ONLINESHOP_API_OBS_H18_REST' ).
     lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
       EXPORTING
         iv_service_definition_name = 'Z_ONLINESHOPSCM_H18'
         io_http_client             = lo_http_client
         iv_relative_service_root   = '' ).

     ASSERT lo_http_client IS BOUND.



" Set entity key
ls_entity_key = VALUE #(
          order_uuid  = '00000000000000000000000000000000' ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

DATA: LV_RESULT TYPE STRING.
      LV_RESULT = | Order: {  ls_business_data-order_id } OrderItem: {  ls_business_data-ordereditem }|.

  CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection
RESPONSE->SET_TEXT(  |Remote error : {  lx_remote->get_longtext(  ) } | ).

CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception
RESPONSE->SET_TEXT(  |Gateway error : {  lx_gateway->get_longtext(  ) } | ).

CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
" Handle Exception
RESPONSE->SET_TEXT(  |Client error : { lx_web_http_client_error->get_longtext(  ) } | ).
* RAISE SHORTDUMP lx_web_http_client_error.


ENDTRY.
  endmethod.
ENDCLASS.
