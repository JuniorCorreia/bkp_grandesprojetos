*&---------------------------------------------------------------------*
*& Report z_exerc_reduce_claude1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_exerc_reduce_claude1.


SELECT FROM mard
FIELDS matnr,
       werks,
       lgort,
       labst
WHERE labst > 0
INTO TABLE @DATA(lt_mard).

TYPES: BEGIN OF ty_total,
         werks TYPE mard-werks,
         total TYPE mard-labst,
       END OF ty_total,
       ty_t_total TYPE STANDARD TABLE OF ty_total WITH EMPTY KEY.

DATA(lt_total) = VALUE ty_t_total( FOR GROUPS grp
                                           OF for_mard
                                           IN lt_mard
                                      GROUP BY for_mard-werks
                                    ( werks = grp
                                      total = REDUCE labst( INIT t = 0
                                                            FOR m IN GROUP grp
                                                            NEXT t = t + m-labst )  )  ) .

cl_demo_output=>display( lt_total ).
