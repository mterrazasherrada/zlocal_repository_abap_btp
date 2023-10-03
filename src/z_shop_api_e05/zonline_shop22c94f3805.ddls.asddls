/********** GENERATED on 02/10/2023 at 10:14:40 by CB9980000015**************/
 @OData.entitySet.name: 'online_shop' 
 @OData.entityType.name: 'online_shopType' 
 define root abstract entity ZONLINE_SHOP22C94F3805 { 
 key order_uuid : sysuuid_x16 ; 
 @Odata.property.valueControl: 'order_id_vc' 
 order_id : abap.char( 10 ) ; 
 order_id_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ordereditem_vc' 
 ordereditem : abap.char( 10 ) ; 
 ordereditem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'deliverydate_vc' 
 deliverydate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 deliverydate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'creationdate_vc' 
 creationdate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 creationdate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'packageid_vc' 
 packageid : abap.int1 ; 
 packageid_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'costcenter_vc' 
 costcenter : abap.char( 10 ) ; 
 costcenter_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'purchasereqn_vc' 
 purchasereqn : abap.char( 256 ) ; 
 purchasereqn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
