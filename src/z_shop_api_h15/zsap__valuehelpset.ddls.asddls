/********** GENERATED on 10/02/2023 at 22:03:35 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__ValueHelpSet' 
 @OData.entityType.name: 'SAP__ValueHelp' 
 define root abstract entity ZSAP__VALUEHELPSET { 
 key VALUEHELP : abap.string( 0 ) ; 
 FIELD_VALUE : abap.char( 10 ) ; 
 @Odata.property.valueControl: 'DESCRIPTION_vc' 
 DESCRIPTION : abap.string( 0 ) ; 
 DESCRIPTION_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
