*&---------------------------------------------------------------------*
*& Include zsd_relatorio_vendas_s01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.
SELECTION-SCREEN END OF BLOCK b0.
