/********** GENERATED on 05/24/2023 at 19:12:56 by CB9980000251**************/
 @OData.entitySet.name: 'online_shop' 
 @OData.entityType.name: 'online_shopType' 
 define root abstract entity ZONLINE_SHOP35B1AA19F9 { 
 key Order_Uuid : sysuuid_x16 ; 
 @Odata.property.valueControl: 'Order_Id_vc' 
 Order_Id : abap.char( 10 ) ; 
 Order_Id_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Ordereditem_vc' 
 Ordereditem : abap.char( 10 ) ; 
 Ordereditem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Deliverydate_vc' 
 Deliverydate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 Deliverydate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Creationdate_vc' 
 Creationdate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 Creationdate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PackageId_vc' 
 PackageId : abap.int1 ; 
 PackageId_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CostCenter_vc' 
 CostCenter : abap.char( 10 ) ; 
 CostCenter_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Purchasereqn_vc' 
 Purchasereqn : abap.char( 256 ) ; 
 Purchasereqn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
