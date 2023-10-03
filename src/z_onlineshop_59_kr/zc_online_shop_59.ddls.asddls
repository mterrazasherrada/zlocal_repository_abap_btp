@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'shop projection'
@Metadata.allowExtensions: true
define root view entity ZC_ONLINE_SHOP_59 as projection on ZI_ONLINE_SHOP_59
{
 key Order_Uuid,
 Order_Id,
 Ordereditem,
 Deliverydate,
 Creationdate,
 PackageId,
 CostCenter,
 _Shop.purchasereqn as Purchasereqn
}
