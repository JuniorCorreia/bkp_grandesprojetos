*&---------------------------------------------------------------------*
*& Report zsd_relatorio_vendas
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_relatorio_vendas.

TABLES: vbak.

INCLUDE zsd_relatorio_vendas_top.
INCLUDE ZSD_relatorio_vendas_s01.
INCLUDE ZSD_relatorio_vendas_c01.


START-OF-SELECTION.

  lcl_main=>execute(  ).
