CLASS zcl_shop_api_read_G29 DEFINITION
PUBLIC
CREATE PUBLIC .
PUBLIC SECTION.
INTERFACES if_http_service_extension .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS zcl_shop_api_read_G29 IMPLEMENTATION.
METHOD if_http_service_extension~handle_request.
DATA:
ls_entity_key TYPE zonline_shop,
ls_business_data TYPE zonline_shop,
lo_http_client TYPE REF TO if_web_http_client,
lo_resource TYPE REF TO /iwbep/if_cp_resource_entity,
lo_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy,
lo_request TYPE REF TO /iwbep/if_cp_request_read,
lo_response TYPE REF TO /iwbep/if_cp_response_read.
TRY.
" Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
comm_scenario = 'Z_SHOP_SCENARIO_OUTBOUND_G29'
* comm_system_id = '<Comm System Id>'
service_id = 'Z_SHOP_API_READ_OBS_G29_REST' ).
lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
EXPORTING
iv_service_definition_name = 'Z_SHOP_API_SCM_G29'
io_http_client = lo_http_client
iv_relative_service_root = '' ).
" Set entity key
ls_entity_key = VALUE #(
order_uuid = '374927A349381EDE90EC3680612E51C9' )."
" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).
" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
DATA: result TYPE string.
result = | OrderID: { ls_business_data-Order_Id }, Purchase Requisition ID: { ls_business_data-Purchasereqn } |.
response->set_text( result ).
CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection
response->set_text( | Remote Error: { lx_remote->get_longtext( ) } | ).
CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception
response->set_text( | Gateway Error: { lx_gateway->get_longtext( ) } | ).
CATCH cx_http_dest_provider_error INTO DATA(lx_destination).
"handle exception
response->set_text( | Destination Error: { lx_destination->get_longtext( ) } | ).
CATCH cx_web_http_client_error INTO DATA(lx_http).
"handle exception
response->set_text( | HTTP Error: { lx_http->get_longtext( ) } | ).
ENDTRY.
ENDMETHOD.
ENDCLASS.
