/********** GENERATED on 07/26/2023 at 09:38:25 by CB9980000581**************/
 @OData.entitySet.name: 'ZC_ONLINE_SHOP_F82' 
 @OData.entityType.name: 'ZC_ONLINE_SHOP_F82Type' 
 define root abstract entity ZZC_ONLINE_SHOP_F82 { 
 key Order_Uuid : sysuuid_x16 ; 
 @Odata.property.valueControl: 'Order_Id_vc' 
 Order_Id : abap.char( 10 ) ; 
 Order_Id_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
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
 @Odata.property.valueControl: 'purchasereqn_vc' 
 purchasereqn : abap.char( 256 ) ; 
 purchasereqn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
