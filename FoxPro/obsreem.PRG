CLOSE all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Reemplaza especies"
@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  espv=SPACE(12)
  espn=SPACE(12)
  @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
  @4,2 SAY "   Especie vieja   :" GET espv
  @5,2 SAY "   Especie nueva   :" GET espn
  READ
  esvi=INT(VAL(espv))
  esnu=INT(VAL(espn))
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
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Reemplaza especies"
    @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo


clear

select 1
use &arch

SELECT 2
USE especie1

SELECT 3
USE especievie

nc="a"
nn="b"

SELECT 3
GO top
DO WHILE .not. EOF()
  IF codinidep=esvi
    nc=nomcient
  ENDIF
  SKIP
ENDDO

SELECT 2
GO top
DO WHILE .not. EOF()
  IF codinidep=esnu
    nn=nomcient
  ENDIF
  SKIP
ENDDO



IF nc<>"a" .and. nn<>"b"
  ? "Reemplazar ",esvi,"    ",nc,"   POR    ",esnu,"     ",nn
  esp1=SPACE(1)
  @4,2 say "Reemplaza? <S/N> "get esp1
  read
  if esp1="s" .or. esp1="S"
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
        IF &es=esvi
          replace &es WITH esnu
        endif
      NEXT t
      SKIP
    ENDDO
  ELSE
    ? "NO SE CAMBIO NADA"
  endif
ELSE
  ? "Algunas de las especies no aparece en la base - VERIFICAR!!!!"
ENDIF
wait" FIN"
CLOSE ALL