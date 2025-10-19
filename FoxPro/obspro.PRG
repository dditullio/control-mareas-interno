close all
CLEAR
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
  if arch=space(12)
    set color to ("b/w*")
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
enddo
use &arch
X=3
index on especie+producto+categoria  to qq
go top
t=0


zz=arch
zz2=SUBSTR(zz,2,5)
zz3="P"+TRIM(zz2)
SET ALTERNATE TO &zz3
set alternate on

? "Especie",";","Producto",";","Categoría",";","Kilos",";","Factor"
do while .not. eof()
  a=especie
  b=producto
  d=categoria
  f=factor
  k=0
  do while (especie=a .and. producto=b .and. categoria=d) .and. .not. eof() 
    k=k+kilos
    t=t+kilos
    skip
  enddo
  ? a,";",b,";",d,";",k,";",f
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
wait""
clear
set alternate off
close all
set color to  ("b/w*")
