close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Controla especies de base vieja y nueva"
@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
  READ
  if arch=space(12)
    set color to  ("b/w*")
    clear
    exit
  endif
  capt=trim(arch)+".dbf"
  if file(capt)=.t. 
    exit
  endif  
  if file(capt)<>.t.
    @ 8,2 say "No existe ese archivo ... verifique"
    for y=1 to 1000000
    endfor
    clear
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Controla especies de base vieja y nueva"
    @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo
@ 2,117 say arch
clear
select 1
use &arch

SELECT 2
USE especie1

SELECT 3
USE especievie

SET ALTERNATE TO especie
SET ALTERNATE on

tt=0

SELECT 1
GO top
DO WHILE .not. EOF()
  l=lance
  FOR t=1 TO 25
    IF t<10
      es="especie_"+STR(t,1)
      ki="kg_"+STR(t,1)
    ELSE
      es="especie_"+STR(t,2)
      ki="kg_"+STR(t,2)
    ENDIF
    kl=&ki
    ee=&es
    IF ee<>0
      rec=RECNO()
      SELECT 2
      GO top
      x=0
      DO WHILE .not. EOF()
        IF codinidep=ee
          x=1
        ENDIF
        SKIP
      ENDDO
      IF x=0
        SELECT 3
        GO top
        y=0
        DO WHILE .not. EOF()
          IF codinidep=ee
            nc=nomcient
            y=1
          ENDIF
          SKIP
        ENDDO
        IF y=0
          ? "La especie: ",ee," NO pertenece a ninguna base"
        else          
          ? "Lance: ",l,"     Especie: ",ee," ",nc,"      Kilos: ",kl   
          tt=tt+kl
        endif  
      ENDIF
      SELECT 1
      GOTO rec
    endif  
  NEXT t
  SKIP
ENDDO
SET ALTERNATE off
?
? tt
wait" FIN"
CLOSE ALL
