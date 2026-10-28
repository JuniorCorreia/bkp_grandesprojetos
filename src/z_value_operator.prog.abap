*&---------------------------------------------------------------------*
*& Report z_value_operator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_value_operator.

TYPES: BEGIN OF ty_cliente,
         codigo TYPE string,
         nome   TYPE string,
       END OF ty_cliente,
       ty_t_clientes TYPE TABLE OF ty_cliente WITH EMPTY KEY.

"Atribuindo valores a uma estrutura
DATA(stl_cliente) = VALUE ty_cliente( codigo = '1' nome = 'Antonio' ).

WRITE: /001 |Código: {  stl_cliente-codigo }|,
        030 |Nome: { stl_cliente-nome }|.

WRITE: / ''.
WRITE: / '-------------------------------------------------------------'.
WRITE: / ''.

"Atribuindo valores a uma tabela.
DATA(lt_clientes) = VALUE ty_t_clientes( ( codigo = '1' nome = 'Antonio' )
                                         ( codigo = '2' nome = 'Paula' )
                                         ( codigo = '3' nome = 'Maria' )
                                         ( codigo = '4' nome = 'Nicolau' ) ).

LOOP AT lt_clientes ASSIGNING FIELD-SYMBOL(<cliente>).
  WRITE: /001 |Código: {  <cliente>-codigo }|,
          030 |Nome: { <cliente>-nome }|.
ENDLOOP.


* Como criar uma range preenchida utilizando a nova sintaxe

DATA: tr_kunnr TYPE RANGE OF kunnr.
DATA: tr_kunnr2 TYPE RANGE OF kunnr.
DATA: tr_kunnr3 TYPE RANGE OF kunnr.


tr_kunnr = VALUE #( sign = 'I' option = 'EQ' ( low = 1 )
                                             ( low = 2 )
                                             ( low = 3 )
                                             ( low = 4 ) ).

"O comando BASE serve para preservar os dados existente, pois ao dar o comando value ele cria uma tabela nova
tr_kunnr = VALUE #( BASE tr_kunnr
                    sign = 'I' option = 'EQ' ( low = 5 )
                                             ( low = 6 )
                                             ( low = 7 )
                                             ( low = 8 ) ).

tr_kunnr2 = VALUE #( BASE tr_kunnr
                     sign = 'I' option = 'EQ' ( low = 9 )
                                              ( low = 10 )
                                              ( low = 11 )
                                              ( low = 12 ) ).

"O comando lines of ao final do comando value serve para adicionar linhas a tabela conforme a tabela referencia que vc informar.
"Ele insere depois que inserir os do comando.

tr_kunnr3 = VALUE #( sign = 'I' option = 'EQ' ( low = 13 )
                                              ( low = 14 )
                                              ( low = 15 )
                                              ( low = 16 )
                     ( LINES OF tr_kunnr2 ) ).


**********************************************************************

SELECT FROM kna1
 FIELDS kunnr,
        name1
 WHERE land1 = 'BR'
 INTO TABLE @DATA(lt_kna1)
 UP TO 15 ROWS.

DATA: tr_kunnr4 TYPE RANGE OF kunnr.


"Ele vai fazer um "loop" na lt_kna1 e para cada registro vai alimentar a tr_kunnr4
tr_kunnr4 = VALUE #( FOR for_kunnr IN lt_kna1
                        ( sign = 'I'
                          option = 'EQ'
                          low    = for_kunnr-kunnr ) ).


lt_clientes = VALUE #( FOR for_lt_kna1 IN lt_kna1
                       ( codigo = for_lt_kna1-kunnr
                         nome   = for_lt_kna1-name1 )  ).

WRITE: /001 'Comando For'.

LOOP AT lt_clientes ASSIGNING <cliente>.
  WRITE: /001 |Código: {  <cliente>-codigo }|,
          030 |Nome: { <cliente>-nome }|.
ENDLOOP.

BREAK-POINT.
