SELECT 1
USE bu

SELECT 2
USE ob

SELECT 1
CLEAR
bq=SPACE(30)
oo=SPACE(6)
@1,1 say "Ingrese buque : " get bq
@2,1 say "Ingrese obs   : " get oo
READ
IF bq=" "
  EXIT
endif
GO top
DO WHILE .not. EOF()
  IF UPPER(TRIM(buque))==UPPER(TRIM(bq))
    ? buque,";",buquecod,";",eslora,";",pothp,";",flota
  ENDIF
  SKIP
ENDDO
SELECT 2
GO top
DO WHILE .not. EOF()
  IF UPPER(LEFT(obser,6))==UPPER(oo)
    ? obsnro,";",obser,";",obsnom
  ENDIF
  SKIP
ENDDO
WAIT""
CLOSE ALL
