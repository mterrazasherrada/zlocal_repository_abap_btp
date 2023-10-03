CLASS zcl_shop_api_read_b43 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SHOP_API_READ_B43 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA:
      ls_entity_key    TYPE zonline_shop03295ab56a,
      ls_business_data TYPE zonline_shop03295ab56a,
      lt_business_data TYPE TABLE OF zonline_shop03295ab56a,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst,
      result           TYPE string.



    TRY.
        " Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                     comm_scenario  = 'Z_SHOP_SCENARIO_OUTBOUND_B43'
                                                     service_id     = 'Z_SHOP_API_READ_OBS_B43_REST' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZSHOP_API_SCM_B43'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '' ).

        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ONLINE_SHOP' )->create_request_for_read( ).

        lo_request->set_top( 50 )->set_skip( 0 ).

        lo_response = lo_request->execute( ).

        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

        IF lt_business_data IS NOT INITIAL.
          ls_business_data = lt_business_data[  1 ].
          result = | OrderID: { ls_business_data-Order_Id },  Ordered Item: { ls_business_data-Ordereditem  } |.
          response->set_text( result ).
        ELSE.
          response->set_text( 'No Data Found' ).
        ENDIF.


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
