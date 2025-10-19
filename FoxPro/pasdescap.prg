close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Pasa descarte a captura"
@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  ARCH2=SPACE(12)
  ARCH3=SPACE(12)
  ARCH4=SPACE(12)
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
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Pasar descarte a captura  "
    @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo
USE &arch
*//COPY TO Cdescart.dbf
@ 2,117 say arch
*//USE descarte
GO top
DO WHILE .not. EOF()
  replace kg_1 WITH descar_1
  replace kg_2 WITH descar_2
  replace kg_3 WITH descar_3
  replace kg_4 WITH descar_4
  replace kg_5 WITH descar_5
  replace kg_6 WITH descar_6
  replace kg_7 WITH descar_7
  replace kg_8 WITH descar_8
  replace kg_9 WITH descar_9
  replace kg_10 WITH descar_10
  replace kg_11 WITH descar_11
  replace kg_12 WITH descar_12
  replace kg_13 WITH descar_13
  replace kg_14 WITH descar_14
  replace kg_15 WITH descar_15
  replace kg_16 WITH descar_16
  replace kg_17 WITH descar_17
  replace kg_18 WITH descar_18
  replace kg_19 WITH descar_19
  replace kg_20 WITH descar_20
  replace kg_21 WITH descar_21
  replace kg_22 WITH descar_22
  replace kg_23 WITH descar_23
  replace kg_24 WITH descar_24
  replace kg_25 WITH descar_25
  SKIP
ENDDO

CLOSE ALL
