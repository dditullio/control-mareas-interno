SET POINT TO ","
USE c07721
GO top
SET ALTERNATE TO tabla
SET ALTERNATE on
DO WHILE .not. EOF()
  ? Lance,";",lat_inic,";",long_inic,";",
  a=INT(hora_final)*60+((hora_final-INT(hora_final))*100)
  b=INT(hora_inic)*60+((hora_inic-INT(hora_inic))*100)
  c=a-b
  d=c/60
  FOR t=1 TO 25
    IF t<10
      es="especie_"+STR(t,1)
      kk="kg_"+STR(t,1)
    ELSE
      es="especie_"+STR(t,2)
      kk="kg_"+STR(t,2)
    ENDIF
    IF &es=5139030101
      ti=&kk/d
      ?? &kk,";",ti
    ENDIF
  NEXT t  
  SKIP
ENDDO
SET ALTERNATE off
CLOSE all
      
    