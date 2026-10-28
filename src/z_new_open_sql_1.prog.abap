*&---------------------------------------------------------------------*
*& Report z_new_open_sql_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_new_open_sql_1.

TABLES: sflight.

SELECT-OPTIONS: s_carrid FOR sflight-carrid.

SELECT FROM sflight
    FIELDS carrid,
           connid,
           fldate,
           price,
           currency,
           planetype,
           seatsmax,
           seatsocc,
           seatsmax - seatsocc AS seatsopen,

           CASE WHEN ( seatsmax - seatsocc ) > 0 THEN 'Assentos Livres'
                WHEN ( seatsmax - seatsocc ) < 0 THEN 'Overbooking'
                WHEN ( seatsmax - seatsocc ) = 0 THEN 'Assentos totalmente ocupados'
                END AS Ocupacao,

           paymentsum,
           seatsmax_b,
           seatsocc_b,
           CAST( ' ' AS SSTRING ) AS ocupacao_b,
           seatsmax_f,
           seatsocc_f

    WHERE carrid IN @s_carrid
    INTO TABLE @DATA(lt_sflight).

DATA: lt_voos    LIKE TABLE OF lt_sflight.
DATA: tr_carrid  TYPE RANGE OF sflight-carrid.

"Assim ele agrupa por CARRID e não vai duplicar linhas
tr_carrid = VALUE #( FOR GROUPS grp
                             OF ls_sflight
                             IN lt_sflight
                       GROUP BY ls_sflight-carrid
                     sign = 'I'
                     option = 'EQ'
                     ( low = grp ) ).

TYPES: BEGIN OF ty_spfli_fae,
         carrid TYPE spfli-carrid,
         connid TYPE spfli-connid,
       END OF ty_spfli_fae,
       tt_spfli_fae TYPE SORTED TABLE OF ty_spfli_fae WITH UNIQUE KEY carrid connid.

DATA: lt_spfli_fae TYPE tt_spfli_fae.

lt_spfli_fae = VALUE #( FOR GROUPS grp2
                                OF ls_flight
                                IN lt_sflight
                           GROUP BY ( carrid = ls_flight-carrid
                                      connid = ls_flight-connid )
                         ( carrid = grp2-carrid
                           connid = grp2-connid )  ).

TYPES: BEGIN OF ty_spfli.
         INCLUDE STRUCTURE spfli.
TYPES:   destino TYPE string,
       END OF ty_spfli,
       tt_spfli TYPE SORTED TABLE OF ty_spfli WITH UNIQUE KEY carrid connid.

DATA: lt_spfli TYPE tt_spfli.


SELECT FROM spfli
FIELDS mandt,
       carrid,
       connid,
       countryfr,
       cityfrom,
       airpfrom,
       countryto,
       cityto,
       airpto,
       fltime,
       deptime,
       arrtime,
       distance,
       distid,
       fltype,
       period
FOR ALL ENTRIES IN @lt_spfli_fae
WHERE carrid = @lt_spfli_fae-carrid
  AND connid = @lt_spfli_fae-connid
  INTO TABLE @lt_spfli.


LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<spfli>).
  <spfli>-destino = COND #( WHEN <spfli>-countryfr <> <spfli>-countryto then 'Internacional'
                            ELSE 'Nacional' ).

ENDLOOP.


cl_demo_output=>write( lt_spfli ).
cl_demo_output=>display( ).
