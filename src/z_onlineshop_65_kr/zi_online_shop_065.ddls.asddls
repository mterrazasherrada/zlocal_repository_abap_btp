@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for online shop'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZI_ONLINE_SHOP_065
 as select from zonlineshope_65
 association [1..1] to zshop_as_065 as _Shop on
 $projection.Order_Uuid = _Shop.order_uuid
{
 key order_uuid as Order_Uuid,
 order_id as Order_Id,
 ordereditem as Ordereditem,
 deliverydate as Deliverydate,
 creationdate as Creationdate,
 pkgid as PackageId,
 _Shop.costcenter as CostCenter,
 /*Associations*/
 _Shop
}

