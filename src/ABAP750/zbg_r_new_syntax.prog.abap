*&---------------------------------------------------------------------*
*& Report ZBG_R_NEW_SYNTAX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBG_R_NEW_SYNTAX.

TYPES :BEGIN OF ty_first,
         werks  TYPE werks_d,
         arbpl  TYPE arbpl,
         toplam TYPE menge_d,
         meins  TYPE meins,
         islem  TYPE int8,
       END OF ty_first.

TYPES : tt_first TYPE TABLE OF ty_first WITH EMPTY KEY.
DATA : lt_out TYPE TABLE OF ty_first.

DATA(itab) = VALUE tt_first(
( werks = '2013' arbpl = '07' toplam = '16'   meins = '' )
( werks = '2013' arbpl = '07' toplam = '32'   meins = '' )
( werks = '2015' arbpl = '09' toplam = '07'   meins = '' ) ).

DATA(lt_outs) = VALUE tt_first( FOR GROUPS grp OF <wa> IN itab GROUP BY ( werks = <wa>-werks arbpl = <wa>-arbpl )
                  LET lv_meins = 'ADT'
                      lv_c1 = 2
                      lv_c2 = 5
                  IN (  werks = grp-werks
                        arbpl = grp-arbpl
                        meins = lv_meins
                        toplam = REDUCE #( INIT x TYPE menge_d
                                           FOR wa IN GROUP grp
                                           NEXT x += wa-toplam )
                       islem = lv_c1 * lv_c2  ) ).

cl_demo_output=>display( lt_outs ).
