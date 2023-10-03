/********** GENERATED on 07/26/2023 at 11:22:01 by CB9980000560**************/
 @OData.entitySet.name: 'ZC_ONLINE_SHOP_F61' 
 @OData.entityType.name: 'ZC_ONLINE_SHOP_F61Type' 
 define root abstract entity ZZC_ONLINE_SHOP_F61 { 
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
 @Odata.property.valueControl: 'Purchasereqn_vc' 
 Purchasereqn : abap.char( 256 ) ; 
 Purchasereqn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
