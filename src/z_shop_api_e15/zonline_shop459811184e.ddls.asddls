/********** GENERATED on 02/08/2023 at 16:32:32 by CB9980000025**************/
 @OData.entitySet.name: 'online_shop' 
 @OData.entityType.name: 'online_shopType' 
 define root abstract entity ZONLINE_SHOP459811184E { 
 key Order_Uuid : sysuuid_x16 ; 
 @Odata.property.valueControl: 'Order_Id_vc' 
 Order_Id : abap.char( 10 ) ; 
 Order_Id_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ordereditem_vc' 
 ordereditem : abap.char( 10 ) ; 
 ordereditem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'deliverydate_vc' 
 deliverydate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 deliverydate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'creationdate_vc' 
 creationdate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 creationdate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'packageId_vc' 
 packageId : abap.int1 ; 
 packageId_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CostCenter_vc' 
 CostCenter : abap.char( 10 ) ; 
 CostCenter_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Purchasereqn_vc' 
 Purchasereqn : abap.char( 256 ) ; 
 Purchasereqn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
