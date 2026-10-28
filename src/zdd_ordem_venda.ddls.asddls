@AbapCatalog.sqlViewName: 'ZV_ORDEM_VENDA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dados de Ordem de Venda'
@Metadata.ignorePropagatedAnnotations: true
define view ZDD_ORDEM_VENDA
  as select from    vbak
    inner join      kna1 on kna1.kunnr = vbak.kunnr
    inner join      vbap on vbap.vbeln = vbak.vbeln
    inner join      mara on mara.matnr = vbap.matnr
    left outer join makt on  makt.matnr = vbap.matnr
                         and makt.spras = $session.system_language

{
  key vbak.vbeln,
      vbap.posnr,
      vbak.erdat,
      vbak.ernam,
      vbak.auart,
      vbak.kunnr,
      kna1.name1,
      vbap.matnr,
      mara.matkl,
      makt.maktx,

      @Semantics.amount.currencyCode : 'waerk'
      vbap.netwr,
      vbap.waerk,

      @Semantics.quantity.unitOfMeasure: 'meins'
      mara.brgew,

      @Semantics.unitOfMeasure: true
      mara.meins

}
