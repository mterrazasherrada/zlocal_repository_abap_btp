/********** GENERATED on 10/02/2023 at 22:03:36 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__Currencies' 
 @OData.entityType.name: 'SAP__Currency' 
 define root abstract entity ZSAP__CURRENCIES { 
 key CurrencyCode : abap.char( 5 ) ; 
 ISOCode : abap.char( 3 ) ; 
 @OData.property.name: 'Text' 
 Text1 : abap.char( 15 ) ; 
 DecimalPlaces : abap.int1 ; 
 
 } 
