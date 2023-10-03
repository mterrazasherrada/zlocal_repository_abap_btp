CLASS zcl_bp_hand13535_read DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BP_HAND13535_READ IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

DATA:
  ls_entity_key    TYPE ZZC_HAND13535_API,
  ls_business_data TYPE ZZC_HAND13535_API,
  lo_http_client   TYPE REF TO if_web_http_client,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     TRY.
     " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = '<Comm Scenario>'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

     lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
       EXPORTING
         iv_service_definition_name = 'Z_HAND13535_BTP_MODEL'
         io_http_client             = lo_http_client
         iv_relative_service_root   = '' ).

*lo_client_proxy = /iwbep/cl_cp_factory_alv5=>create_v2_remote_proxy(
*  EXPORTING
*    is_proxy_model_key       = value #( repository_id       = /iwbep/if_cp_registry_types=>gcs_repository_id-srvd
*                                        proxy_model_id      = 'Z_HAND13535_BTP_MODEL'
*                                        proxy_model_version = '0001' )
*    io_http_client             = lo_http_client
*    iv_relative_service_root   = '<service_root>' ).



" Set entity key
    ls_entity_key = VALUE #(
              id  = 20  ).

    " Navigate to the resource
    lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_HAND13535_API' )->navigate_with_key( ls_entity_key ).

    " Execute the request and retrieve the business data
    lo_response = lo_resource->create_request_for_read( )->execute( ).
    lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
    " Handle remote Exception
    " It contains details about the problems of your http(s) connection

    CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
    " Handle Exception

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
