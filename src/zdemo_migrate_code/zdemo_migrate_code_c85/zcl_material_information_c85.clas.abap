class ZCL_MATERIAL_INFORMATION_C85 definition
  public
  create private .

public section.
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_INFORMATION_C85 IMPLEMENTATION.


  METHOD get_material_art.
    DATA material TYPE mara.
    DATA production_date TYPE datn.
    DATA bool_tmp TYPE boole_d.

    production_date = sy-datum.

    SELECT SINGLE mtart FROM mara INTO CORRESPONDING FIELDS OF material WHERE matnr = matnr.

    MOVE material-mtart TO material_art.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    DATA material_info TYPE REF TO zcl_material_information_c85.
    material_info = NEW zcl_material_information_c85(  ).
    DATA(material_art) = material_info->get_material_art( 'RM34' ).
    out->write( material_art ).
  ENDMETHOD.
ENDCLASS.
