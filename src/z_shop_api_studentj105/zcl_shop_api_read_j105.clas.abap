class ZCL_SHOP_API_READ_J105 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_J105 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

DATA:
  ls_entity_key    TYPE ZONLINE_SHOPC60DBCA97C,
  ls_business_data TYPE ZONLINE_SHOPC60DBCA97C,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'Z_SHOP_API_STUDENTJ105'
*                                             comm_system_id = '<Comm System Id>'
                                             service_id     = 'Z_SHOP_API_READ_OBS_J105_REST' ).
lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     ASSERT lo_http_client IS BOUND.
     " If you like to use IF_HTTP_CLIENT you must use the following factory: /IWBEP/CL_CP_CLIENT_PROXY_FACT
     lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
       EXPORTING
          is_proxy_model_key       = VALUE #( repository_id       = 'SRVD'
                                              proxy_model_id      = 'Z_SHOP_API_SCM_J105'
                                              proxy_model_version = '0001' )
         io_http_client             = lo_http_client
         iv_relative_service_root   = '' ).


" Set entity key
ls_entity_key = VALUE #(
          order_uuid  = 'DF0B7D5455421EDE87FDAB67BD615345' ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

DATA: result type string.
result = | OrderID: { ls_business_data-Order_Id },Purchase Requisition ID: { ls_business_data-Purchasereqn } |.response->set_text( result ).


*  CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
*" Handle remote Exception
*" It contains details about the problems of your http(s) connection
*
*CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
*" Handle Exception
*
*CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
*" Handle Exception
* RAISE SHORTDUMP lx_web_http_client_error.

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
  endmethod.
ENDCLASS.
