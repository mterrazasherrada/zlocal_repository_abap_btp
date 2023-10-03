/********** GENERATED on 10/02/2023 at 22:03:35 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__SignatureSet' 
 @OData.entityType.name: 'SAP__Signature' 
 define root abstract entity ZSAP__SIGNATURESET { 
 key Id : sysuuid_x16 ; 
 DoSign : abap_boolean ; 
 Reason : abap.char( 256 ) ; 
 
 } 
