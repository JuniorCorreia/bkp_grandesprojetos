@AbapCatalog.sqlViewName: 'ZV_VBAK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cabeçalho da Ordens de Venda'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_SALES_ORDER as select from vbak
 association [1..*] to vbap as _vbap on _vbap.vbeln = vbak.vbeln
 association [1..1] to kna1 as _kna1 on _kna1.kunnr = vbak.kunnr 
{
    key vbeln as Vbeln,
    erdat as Erdat,
    erzet as Erzet,
    ernam as Ernam,
    audat as Audat,
    auart as Auart,
    augru as Augru,
    lifsk as Lifsk,
    faksk as Faksk,
    netwr as Netwr,
    waerk as Waerk,
    vkorg as Vkorg,
    vtweg as Vtweg,
    spart as Spart,
    vkgrp as Vkgrp,
    vkbur as Vkbur,
    kunnr as Kunnr,
    
    _vbap,
    _kna1
} 
