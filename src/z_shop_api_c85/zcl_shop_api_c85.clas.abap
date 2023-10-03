class ZCL_SHOP_API_C85 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SHOP_API_C85 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


DATA:
  ls_entity_key    TYPE ZONLINE_SHOP9BAA8AF91F,
  ls_business_data TYPE ZONLINE_SHOP9BAA8AF91F,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                             comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_C85'
                                             service_id    = 'Z_SHOP_API_READ_OBS_C85_REST'

                                              ).
lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
     ASSERT lo_http_client IS BOUND.
     " If you like to use IF_HTTP_CLIENT you must use the following factory: /IWBEP/CL_CP_CLIENT_PROXY_FACT

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'Z_SHOP_API_SM_C85'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).


" Set entity key
ls_entity_key = VALUE #(
          order_uuid  = 'E7AA1C3D298B1EDDBEC64BB07C259821' ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP')->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

data lv_result type string.
lv_result = |Order ID: { ls_business_data-Order_Id },Ordered Item: { ls_business_data-Ordereditem }. |.
response->set_text( lv_result ).

  CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
" Handle remote Exception
" It contains details about the problems of your http(s) connection

CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
" Handle Exception

CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
" Handle Exception
response->set_text( |HTTP Client Error": { lx_web_http_client_error->get_longtext(  ) } | ).

CATCH cx_http_dest_provider_error INTO DATA(LX_DESTINATION).
response->set_text( |Destination Error": { lx_destination->get_longtext(  ) } | ).


 RAISE SHORTDUMP lx_web_http_client_error.


ENDTRY.

  endmethod.
ENDCLASS.
