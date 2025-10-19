DO WHILE .t.
  @ 0,0 SAY " " FONT 'Times New Roman',12 
SET POINT TO ","
close all
CLEAR
irse=0
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - PRODUCCION"
set color to  ("B/w*")
@ 1,1 to 37,130
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  sn=space(1)
  @3,2 SAY "ARCHIVO PRODUCCION :" GET ARCH
  READ
  if arch="            "
    set color to ("b/w*")
    irse=1
    clear
    return  
  endif
  capt=trim(arch)+".dbf"
  if file(capt)=.t.
    @ 3,2 SAY "                                                      "
    @ 4,2 SAY "                                                      "
    exit
  endif  
  if file(capt)<>.t.
    @ 6,2 say "No existe ese archivo ... verifique"
    clear 
    for y=1 to 1000000
    endfor
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - RECONSTRCCIÓN A PARTIR DE PRODUCCION"
    set color to  ("B/w*")
    @ 1,1 to 37,130
    loop
  endif
ENDDO

IF irse=1
  EXIT
endif

IF irse=0

SELECT 1
USE especie1

SELECT 2
use &arch
index on especie+producto+categoria  to qq

zz=arch
zz2=SUBSTR(zz,2,6)
zz3="P"+TRIM(zz2)
SET ALTERNATE TO &zz3
set alternate on
ON ERROR exit

SELECT 2
X=3
go top
t=0


? "Especie",";","Producto",";","Categoría",";","Kilos",";","Factor"
do while .not. eof()
  ax=0
  a=especie
  rec=RECNO()
  SELECT 1
  GO top
  DO WHILE .not. EOF()
    IF TRIM(nomvulcas)==TRIM(a)
      nc=nomcient
      ax=1
      exit
    ENDIF
    SKIP
  enddo  
  SELECT 2
  GOTO rec
  b=producto
  d=categoria
  f=factor
  k=0
  IF ax=0
    qw=a
  ELSE
    qw=nc
  ENDIF
  do while (especie=a .and. producto=b .and. categoria=d) .and. .not. eof() 
    k=k+kilos
    t=t+kilos
    skip
  enddo
  ? qw,";",b,";",d,";",k,";",f
  x=x+1
enddo
?
?
? "Factor en cero"
GO TOP
DO WHILE .NOT. EOF()
  IF FACTOR=0
    ? especie,";",producto,";",kilos,";",fecha
    x=x+1
  ENDIF
  SKIP
ENDDO  
? "Total Producción",t
clear
set alternate off
close all
set color to  ("b/w*")
ENDIF
enddo