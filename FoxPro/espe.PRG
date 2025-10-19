SELECT 1
USE esp

SELECT 2
USE especie1

SET ALTERNATE TO dif_esp
SET ALTERNATE on

SELECT 1
GO top
DO WHILE .not. EOF()
  a=codi
  b=cient
  c=vulg
  x=0
  q=0
  rec=RECNO()
  SELECT 2
  GO top
  DO WHILE .not. EOF()
    IF codinidep>7000000000 .and. codinidep<7300000000
    IF codinidep==a .and. TRIM(nomcient)<>TRIM(b)
      ? "////N ",";",a,";",b,";",c,";","////V ",";",codinidep,";",nomcient,";",nomvulcas
      x=1
    ENDIF
    IF codinidep==a .and. TRIM(nomcient)==TRIM(b)
      x=1
      q=1
    ENDIF
    endif
    SKIP
  ENDDO
  IF x=0
    ? "N ",";",a,";",b,";",c
  endif
  SELECT 1
  IF .not. EOF()
    GOTO rec
  ENDIF
  IF q=1
    replace z WITH 1
  endif  
  SKIP
ENDDO
SET ALTERNATE off
CLOSE all 
