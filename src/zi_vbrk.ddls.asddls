@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dados de Cabeçalho da Doc de Faturamento'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_VBRK
  as select from vbrk
{
  vbrk.vbeln,
  vbrk.fkart,

  @Semantics.amount.currencyCode : 'un_preco'
  vbrk.netwr,

  @Semantics.amount.currencyCode : 'un_preco'
  vbrk.mwsbk,

  vbrk.waerk as un_preco
}
