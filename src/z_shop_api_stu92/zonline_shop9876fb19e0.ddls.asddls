/********** GENERATED on 03/21/2023 at 06:15:36 by CB9980000111**************/
 @OData.entitySet.name: 'online_shop' 
 @OData.entityType.name: 'online_shopType' 
 define root abstract entity ZONLINE_SHOP9876FB19E0 { 
 key ORDER_UUID : sysuuid_x16 ; 
 @Odata.property.valueControl: 'ORDER_ID_vc' 
 ORDER_ID : abap.char( 10 ) ; 
 ORDER_ID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ORDEREDITEM_vc' 
 ORDEREDITEM : abap.char( 10 ) ; 
 ORDEREDITEM_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DELIVERYDATE_vc' 
 DELIVERYDATE : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 DELIVERYDATE_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CREATIONDATE_vc' 
 CREATIONDATE : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 CREATIONDATE_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PACKAGEID_vc' 
 PACKAGEID : abap.int1 ; 
 PACKAGEID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'COSTCENTER_vc' 
 COSTCENTER : abap.char( 10 ) ; 
 COSTCENTER_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PURCHASEREQN_vc' 
 PURCHASEREQN : abap.char( 256 ) ; 
 PURCHASEREQN_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
