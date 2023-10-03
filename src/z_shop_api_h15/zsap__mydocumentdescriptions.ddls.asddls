/********** GENERATED on 10/02/2023 at 22:03:54 by CB9980000754**************/
 @OData.entitySet.name: 'SAP__MyDocumentDescriptions' 
 @OData.entityType.name: 'SAP__DocumentDescription' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZSAP__MYDOCUMENTDESCRIPTIONS { 
 key Id : sysuuid_x16 ; 
 CreatedBy : abap.char( 12 ) ; 
 CreatedAt : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 FileName : abap.char( 256 ) ; 
 Title : abap.char( 256 ) ; 
 
 @OData.property.name: 'CoverPage' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _CoverPage : association [0..*] to ZSAP__COVERPAGESET on 1 = 1; 
 @OData.property.name: 'Format' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _Format : association [1] to ZSAP__FORMATSET on 1 = 1; 
 @OData.property.name: 'PDFStandard' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _PDFStandard : association [1] to ZSAP__PDFSTANDARDSET on 1 = 1; 
 @OData.property.name: 'Signature' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _Signature : association [1] to ZSAP__SIGNATURESET on 1 = 1; 
 @OData.property.name: 'TableColumns' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _TableColumns : association [0..*] to ZSAP__TABLECOLUMNSSET on 1 = 1; 
 } 
