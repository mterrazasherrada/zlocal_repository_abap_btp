/********** GENERATED on 10/02/2023 at 22:03:34 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__FormatSet' 
 @OData.entityType.name: 'SAP__Format' 
 define root abstract entity ZSAP__FORMATSET { 
 key Id : sysuuid_x16 ; 
 FontSize : abap.int4 ; 
 Orientation : abap.char( 10 ) ; 
 PaperSize : abap.char( 10 ) ; 
 BorderSize : abap.int4 ; 
 MarginSize : abap.int4 ; 
 FontName : abap.char( 255 ) ; 
 
 } 
