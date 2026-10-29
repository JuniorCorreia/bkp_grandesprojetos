*&---------------------------------------------------------------------*
*& Include zsd_relatorio_vendas_c01
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS execute.

  PRIVATE SECTION.


ENDCLASS.


CLASS lcl_main IMPLEMENTATION.

  METHOD execute.

    DATA(lo_ordem_venda) = new zcl_ordem_venda(  ).

    lo_ordem_venda->buscar_ordem_venda( i_vbeln =  s_vbeln[] ).

*    DATA(lt_ordem_venda) = lo_ordem_venda->get_ordem_venda( ).
*    cl_demo_output=>display( lt_ordem_venda ).

    lo_ordem_venda->exibir_ordens_venda(  ).




  ENDMETHOD.

ENDCLASS.
