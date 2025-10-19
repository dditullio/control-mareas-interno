USE p15720
INDEX on especie+producto TO tt
GO top
SET ALTERNATE TO prpr
SET ALTERNATE on
DO WHILE .not. EOF()
  a=especie
  b=producto
  x=0
  DO WHILE especie=a .and. producto=b
    x=x+kilos
    SKIP
  ENDDO
  ? a,";",b,";",x
ENDDO
SET ALTERNATE off
CLOSE all  