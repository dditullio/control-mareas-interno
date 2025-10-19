SELECT 1
USE c6121

SELECT 2
USE m6121

SELECT 3
USE md6121

SELECT 1
GO top
DO WHILE .not. EOF()
  l=lance
  f=fecha
  a=tarte
  ar=(INT(lat_inic)*100)+(INT(long_inic))
  ar1=lat_inic-INT(lat_inic)
  ar2=long_inic-INT(long_inic)
  IF ar1<0.30
    a1=1
  ELSE
    a1=2
  endif    
  IF ar2<0.30
    a2=1
  ELSE
    a2=2
  endif    
  IF a1=1 .and. a2=2
    t=0.1
  ENDIF
  IF a1=1 .and. a2=1
    t=0.2
  ENDIF  
  IF a1=2 .and. a2=2
    t=0.3
  ENDIF
  IF a1=2 .and. a2=1
    t=0.4
  ENDIF
  are=ar+t
  rec=RECNO()
  SELECT 2
  GO top
  DO WHILE .not. EOF()
    IF lance=l
      ? "M"
      IF fecha<>f .or. tarte<>a .or. area<>are
        ? l,";",cod_espec,";",especie,";",fecha,";",tarte,";",area
        replace fecha WITH f, tarte WITH a, area WITH are
      ENDIF
    ENDIF
    SKIP
  ENDDO
  SELECT 3
  GO top
  DO WHILE .not. EOF()
    IF lance=l
      ? "MD"
      IF fecha<>f .or. tarte<>a .or. area<>are
        ? l,";",cod_espec,";",especie,";",fecha,";",tarte,";",area
        replace fecha WITH f, tarte WITH a, area WITH are
      ENDIF
    ENDIF
    SKIP
  ENDDO   
  SELECT 1
  IF .not. EOF()
    GOTO rec
  endif   
  SKIP
ENDDO
