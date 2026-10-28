*&---------------------------------------------------------------------*
*& Report ZREP_CORRESPONDING_OPERATOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_corresponding_operator.

TYPES: BEGIN OF ty_TAB1,
         comp1 TYPE i,
         comp2 TYPE string,
       END OF ty_TAB1.

TYPES: BEGIN OF ty_TAB2,
         comp1 TYPE i,
         comp2 TYPE string,
         comp3 TYPE char5,
       END OF ty_TAB2.
TYPES: tty_tab2 TYPE TABLE OF ty_tab2 WITH EMPTY KEY.

DATA: ls_TAB1 TYPE ty_TAB1,
      lt_TAB1 TYPE TABLE OF ty_TAB1,
      ls_TAB2 TYPE ty_TAB2,
      lt_TAB2 TYPE TABLE OF ty_TAB2.


ls_TAB1 = VALUE #( comp1 = 1 comp2 = 'name1' ).

lt_TAB1 = VALUE #( ( comp1 = 1 comp2 = 'name1' )
                   ( comp1 = 2 comp2 = 'name2' )
                   ( comp1 = 3 comp2 = 'name3' ) ).

ls_TAB2 = VALUE #( comp1 = 4 comp2 = 'name4' comp3 = 'addr4' ).

lt_TAB2 = VALUE #( ( comp1 = 4 comp2 = 'name4' comp3 = 'addr4' )
                   ( comp1 = 5 comp2 = 'name5' comp3 = 'addr5' )
                   ( comp1 = 6 comp2 = 'name6' comp3 = 'addr6' ) ).



WRITE:/ '*************************** ls_TAB1  **********************************************'.
WRITE:/ '      comp1', 'comp2'.
WRITE:/ ls_TAB1-comp1, ls_TAB1-comp2.

SKIP 1.
WRITE:/ '*************************** ls_TAB2  ***********************************************'.
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '************* MOVE-CORRESPONDING ls_TAB1 to ls_TAB2 ********************************'.
MOVE-CORRESPONDING ls_TAB1 TO ls_TAB2.
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '************* ls_TAB2 = corresponding #( base ( ls_TAB2 ) ls_TAB1 ) ****************'.
ls_TAB2 = CORRESPONDING #( BASE ( ls_TAB2 ) ls_TAB1 ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '************* ls_TAB2 = corresponding #( ls_TAB1 ) *********************************'.
ls_TAB2 = CORRESPONDING #( ls_TAB1 ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '** data(ls_TAB3) = CORRESPONDING ty_tab2( VALUE ty_tab2( comp1 = 7 comp2 = ''name7'' comp3 = ''addr7'' ) )**'.
DATA(ls_TAB3) = CORRESPONDING ty_tab2( VALUE ty_tab2( comp1 = 7 comp2 = 'name7' comp3 = 'addr7') ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB3-comp1, ls_TAB3-comp2, ls_TAB3-comp3.

SKIP 1.
WRITE:/ '********** ls_TAB2 = corresponding #( ls_TAB1 MAPPING comp3 = comp2 ) **************'.
ls_TAB2 = CORRESPONDING #( ls_TAB1 MAPPING comp3 = comp2 ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '********** ls_TAB2 = corresponding #( ls_TAB1 EXCEPT comp1 ) ***********************'.
ls_TAB2 = CORRESPONDING #( ls_TAB1 EXCEPT comp1 ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.

SKIP 1.
WRITE:/ '*************************** Internal table *****************************************'.
SKIP 1.
WRITE:/ '*************************** lt_TAB1 *****************************************'.
SKIP 1.
WRITE:/ '      comp1', 'comp2'.
LOOP AT lt_TAB1 INTO ls_TAB1.
  WRITE:/ ls_TAB1-comp1, ls_TAB1-comp2.
ENDLOOP.
SKIP 1.
WRITE:/ '*************************** lt_TAB2 *****************************************'.
SKIP 1.
WRITE:/ '      comp1', 'comp2', 'comp3'.
LOOP AT lt_TAB2 INTO ls_TAB2.
  WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.
ENDLOOP.

SKIP 1.
WRITE:/ '******* lt_TAB2 = corresponding #( APPENDING ( lt_TAB2 ) lt_TAB1 ) ********************'.
SKIP 1.
"lt_TAB2 = CORRESPONDING #( appending ( lt_TAB2 ) lt_TAB1 ).
WRITE:/ '      comp1', 'comp2', 'comp3'.
LOOP AT lt_TAB2 INTO ls_TAB2.
  WRITE:/ ls_TAB2-comp1, ls_TAB2-comp2, ls_TAB2-comp3.
ENDLOOP.
