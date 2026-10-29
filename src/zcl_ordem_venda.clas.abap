CLASS zcl_ordem_venda DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_alv,
        vbeln TYPE vbak-vbeln,
        erdat TYPE vbak-erdat,
        ernam TYPE vbak-ernam,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        arktx TYPE vbap-arktx,
        netwr TYPE vbap-netwr,
      END OF ty_alv,
      tt_alv TYPE STANDARD TABLE OF ty_alv.

    TYPES:
      BEGIN OF ty_ordem_venda,
        vbeln TYPE vbak-vbeln,
        erdat TYPE vbak-erdat,
        ernam TYPE vbak-ernam,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        arktx TYPE vbap-arktx,
        netwr TYPE vbap-netwr,
      END OF ty_ordem_venda .
    TYPES:
      tt_ordem_venda TYPE SORTED TABLE OF ty_ordem_venda WITH UNIQUE KEY vbeln posnr .
    TYPES:
      tr_vbeln TYPE RANGE OF vbak-vbeln .


    METHODS constructor .
    METHODS buscar_ordem_venda
      IMPORTING
        !i_vbeln TYPE tr_vbeln .
    METHODS get_ordem_venda
      RETURNING
        VALUE(rt_ordem_venda) TYPE tt_ordem_venda .
    METHODS exibir_ordens_venda .
  PROTECTED SECTION.



  PRIVATE SECTION.

    DATA gt_ordem_venda TYPE tt_ordem_venda .
ENDCLASS.



CLASS ZCL_ORDEM_VENDA IMPLEMENTATION.


  METHOD buscar_ordem_venda.
    SELECT FROM vbak AS ordem
      INNER JOIN vbap AS item
        ON item~vbeln = ordem~vbeln
      FIELDS ordem~vbeln,
             ordem~erdat,
             ordem~ernam,
             item~posnr,
             item~matnr,
             item~arktx,
             item~netwr
      WHERE ordem~vbeln IN @i_vbeln
      INTO TABLE @gt_ordem_venda.

  ENDMETHOD.


  METHOD constructor.
  ENDMETHOD.


  METHOD get_ordem_venda.
    rt_ordem_venda = gt_ordem_venda.
  ENDMETHOD.


  METHOD exibir_ordens_venda.
    DATA: lt_alv TYPE tt_alv.

    lt_alv = VALUE #( FOR ls_ordem_venda IN gt_ordem_venda
                      ( vbeln = ls_ordem_venda-vbeln
                        erdat = ls_ordem_venda-erdat
                        ernam = ls_ordem_venda-ernam
                        posnr = ls_ordem_venda-posnr
                        matnr = ls_ordem_venda-matnr
                        arktx = ls_ordem_venda-arktx
                        netwr = ls_ordem_venda-netwr )
                      ).

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = DATA(lo_alv)
          CHANGING
            t_table      = lt_alv ).

        " Barra de ferramentas padrão (exportar, filtro, ordenar, etc.)
        lo_alv->get_functions( )->set_all( abap_true ).

        " Otimizar largura das colunas e zebra
        DATA(lo_cols) = lo_alv->get_columns( ).
        lo_cols->set_optimize( abap_true ).
        lo_alv->get_display_settings( )->set_striped_pattern( abap_true ).

        " Título do ALV
        lo_alv->get_display_settings( )->set_list_header( 'Lista de Ordens de Venda' ).


        lo_alv->display( ).

      CATCH cx_salv_msg INTO DATA(lx_msg).
        MESSAGE lx_msg TYPE 'E'.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
