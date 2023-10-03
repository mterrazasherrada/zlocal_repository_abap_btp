/********** GENERATED on 10/02/2023 at 22:03:37 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__UnitsOfMeasure' 
 @OData.entityType.name: 'SAP__UnitOfMeasure' 
 define root abstract entity ZSAP__UNITSOFMEASURE { 
 key UnitCode : abap.char( 3 ) ; 
 ISOCode : abap.char( 3 ) ; 
 ExternalCode : abap.char( 3 ) ; 
 @OData.property.name: 'Text' 
 Text1 : abap.char( 30 ) ; 
 @Odata.property.valueControl: 'DecimalPlaces_vc' 
 DecimalPlaces : abap.int2 ; 
 DecimalPlaces_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
