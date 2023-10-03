class ZCL_MATERIAL_INFORMATION_C85_R definition
  public
  create private .

public section.
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_INFORMATION_C85_R IMPLEMENTATION.


  METHOD get_material_art.
    DATA material TYPE i_product.
    DATA production_date TYPE datn.
    DATA bool_tmp TYPE boole_d.

    production_date = sy-datum.

    SELECT SINGLE FROM i_product FIELDS producttype WHERE product = @matnr INTO CORRESPONDING FIELDS OF @material .
    material_art = material-producttype.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    DATA material_info TYPE REF TO zcl_material_information_C85_R.
    material_info = NEW zcl_material_information_C85_R(  ).
    DATA(material_art) = material_info->get_material_art( 'RM34' ).
    out->write( material_art ).
  ENDMETHOD.
ENDCLASS.
