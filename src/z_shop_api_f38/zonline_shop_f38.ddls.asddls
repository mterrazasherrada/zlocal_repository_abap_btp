/********** GENERATED on 07/20/2023 at 13:41:19 by CB9980000537**************/
 @OData.entitySet.name: 'online_shop' 
 @OData.entityType.name: 'online_shopType' 
 define root abstract entity ZONLINE_SHOP_F38 { 
 key Order_Uuid : sysuuid_x16 ; 
 @OData.property.valueControl: 'Order_Id_vc' 
 Order_Id : abap.char( 10 ) ; 
 Order_Id_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Deliverydate_vc' 
 Deliverydate : rap_cp_odata_v2_edm_datetime ; 
 Deliverydate_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Creationdate_vc' 
 Creationdate : rap_cp_odata_v2_edm_datetime ; 
 Creationdate_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'PackageId_vc' 
 PackageId : abap.int1 ; 
 PackageId_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'CostCenter_vc' 
 CostCenter : abap.char( 10 ) ; 
 CostCenter_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Purchasereqn_vc' 
 Purchasereqn : abap.char( 256 ) ; 
 Purchasereqn_vc : rap_cp_odata_value_control ; 
 
 } 
