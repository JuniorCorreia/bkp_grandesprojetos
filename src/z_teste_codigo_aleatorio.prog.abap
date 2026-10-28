*&---------------------------------------------------------------------*
*& Report z_teste_codigo_aleatorio
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_teste_codigo_aleatorio.


TYPES:
  BEGIN OF ENUM planet STRUCTURE p,
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,
  END OF ENUM planet STRUCTURE p.

DATA planet type planet.

planet = p-earth.

cl_demo_output=>write( planet ).

cl_demo_output=>write( p ).

cl_demo_output=>display( ).
