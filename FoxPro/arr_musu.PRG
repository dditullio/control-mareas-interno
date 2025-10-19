SELECT 1
USE m16420

SELECT 2
USE s16420

*SELECT 3
*USE md16420

SELECT 4
USE especie1

m=1
SELECT 1
GO top
DO WHILE .not. EOF()
  a=cod_espec
  b=especie
  rec=RECNO()
  SELECT 4
  GO top
  DO WHILE .not. EOF()
    IF codinidep=a
      nom=nomvulcas
      ape=nomcient
    ENDIF
    SKIP
  ENDDO
  SELECT 1
  IF .not. EOF()
    GOTO rec
  endif
  IF TRIM(b)<>TRIM(ape)
    replace especie WITH ape
    m=m+1
  ENDIF
  SKIP
ENDDO

   
s=0   
SELECT 2
GO top
DO WHILE .not. EOF()
  b=especie
  rec=RECNO()
  SELECT 4
  GO top
  DO WHILE .not. EOF()
    IF codinidep=a
      nom=nomvulcas
      ape=nomcient
    ENDIF
    SKIP
  ENDDO
  SELECT 2
  IF .not. EOF()
    GOTO rec
  endif
  IF TRIM(b)<>TRIM(nom)
    replace especie WITH nom
    s=s+1
  ENDIF
  SKIP
ENDDO
? m
? s

CLOSE ALL
