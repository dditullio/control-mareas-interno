USE c13720_2
GO top
x=0
DO WHILE .not. EOF()
  FOR t=1 TO 25
    IF t<10
      es="especie_"+STR(t,1)
    ELSE
      es="especie_"+STR(t,2)
    ENDIF
    ee=&es
    IF ee=3505070100
      replace &es WITH 3507030300
      x=x+1
    ENDIF
    IF ee=3500000001
      replace &es WITH 3509010100
      x=x+1
    ENDIF  
    IF ee=7700010001
      replace &es WITH 7701010201
      x=x+1
    ENDIF
    IF ee=7700010002
      replace &es WITH 7701010101
      x=x+1
    ENDIF
    IF ee=7700010003
      replace &es WITH 7701010101
      x=x+1
    ENDIF
    IF ee=7700010000
      replace &es WITH 7701010000
      x=x+1
    ENDIF
    IF ee=5702150301
      replace &es WITH 5702060301
      x=x+1
    ENDIF
    IF ee=7106010100
      replace &es WITH 7106010101
      x=x+1
    ENDIF
  NEXT t
  SKIP
ENDDO
clear
? x

USE m13720_2
GO top
x=0
DO WHILE .not. EOF()
  ee=cod_espec 
  IF ee=3500000001
    replace cod_espec WITH 3509010100
    x=x+1
  ENDIF  
  IF ee=7700010001
    replace cod_espec WITH 7701010201
    x=x+1
  ENDIF
  IF ee=7700010002
    replace cod_espec WITH 7701010101
    x=x+1
  ENDIF
  IF ee=7700010003
    replace cod_espec WITH 7701010101
    x=x+1
  ENDIF
  IF ee=7700010000
    replace cod_espec WITH 7701010000
    x=x+1
  ENDIF
  IF ee=5702150301
    replace cod_espec WITH 5702060301
    x=x+1
  ENDIF
  IF ee=7106010100
    replace cod_espec WITH 7106010101
    x=x+1
  ENDIF
  SKIP
ENDDO
CLOSE ALL
  