*&---------------------------------------------------------------------*
*& Report z_new_open_sql_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_new_open_sql_2.

DATA: lv_name1 TYPE string,
      lv_name2 TYPE string.

lv_name1 = 'Junior'.
lv_name2 = 'CoRReia'.

DATA(lv_string) = |Hoje é dia: { sy-datum DATE = USER }|.


DATA(lv_string2) = |Nome: { to_upper( lv_name1 ) } { to_lower( lv_name2 ) }|.

"DATA(lv_string3) = repeat( val = 'Cocozinho ' occ = 3  ).


cl_demo_output=>write( lv_string2 ).
cl_demo_output=>display( ).
