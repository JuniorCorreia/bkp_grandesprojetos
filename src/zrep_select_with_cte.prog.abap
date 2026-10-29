*&---------------------------------------------------------------------*
*& Report ZREP_SELECT_WITH_CTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_select_with_cte.
""""""""""""""""""""""""""""""""""""" replacing forr all entries """""""""""""""""""""""""""""""""""""""""""""""""""""""

SELECT FROM spfli
     FIELDS carrid,
            connid,
            cityfrom
      WHERE cityfrom = 'FRANKFURT'
 INTO TABLE @DATA(lt_spfli).

SELECT FROM sbook
     FIELDS carrid,
            connid,
            fldate
    FOR ALL ENTRIES IN @lt_spfli
      WHERE carrid EQ @lt_spfli-carrid AND
            connid EQ @lt_spfli-connid AND
            fldate EQ '20220916'
 INTO TABLE @DATA(lt_sbook_1).

cl_demo_output=>write( lt_sbook_1 ).


WITH +flight_from AS ( SELECT FROM spfli
                            FIELDS carrid,connid,cityfrom
                             WHERE cityfrom = 'FRANKFURT' )

SELECT DISTINCT sbook~carrid,
                sbook~connid,
                sbook~fldate
           FROM sbook
     INNER JOIN +flight_from
             ON sbook~carrid = +flight_from~carrid AND
                sbook~connid = +flight_from~connid
          WHERE sbook~fldate EQ '20220916'
     INTO TABLE @DATA(lt_sbook_2).

cl_demo_output=>write( lt_sbook_2 ).

""""""""""""""""""""""""""""""""""""" replacing sub query """""""""""""""""""""""""""""""""""""""""""""""""""""""

SELECT DISTINCT carrid,
                connid,
                fldate
           FROM sbook
          WHERE fldate EQ '20220916' AND
                connid IN ( SELECT connid FROM spfli WHERE cityfrom = 'FRANKFURT' )
     INTO TABLE @DATA(lt_sbook_3).

cl_demo_output=>write( lt_sbook_3 ).


WITH +flight_from AS ( SELECT connid
                         FROM spfli
                        WHERE cityfrom = 'FRANKFURT' )

SELECT DISTINCT sbook~carrid,
                sbook~connid,
                sbook~fldate FROM sbook
     INNER JOIN +flight_from ON sbook~connid = +flight_from~connid
          WHERE sbook~fldate EQ '20220916'
     INTO TABLE @DATA(lt_sbook_4).

cl_demo_output=>write( lt_sbook_4 ).

cl_demo_output=>display( ).
