close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Reemplaza especie"
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
  @4,2 SAY "           MUESTRA :" GET ARCH2
  @5,2 SAY "        SUBMUESTRA :" GET ARCH3
  @6,2 SAY "        PRODUCCION :" GET ARCH4
  READ
  if arch=space(12)
    set color to  ("b/w*")
    clear
    exit
  endif
  capt=trim(arch)+".dbf"
  capt2=trim(arch2)+".dbf"
  capt3=trim(arch3)+".dbf"  
  capt4=trim(arch4)+".dbf"  
  if file(capt)=.t. .AND. (file(capt2)=.t. .or. capt2=".dbf") .AND. (file(capt3)=.t.  .or. capt3=".dbf") .AND. file(capt4)=.t.
    exit
  endif  
  if file(capt)<>.t. .OR. file(capt2)<>.t. .OR. file(capt3)<>.t. .OR. file(capt4)<>.t.
    @ 8,2 say "No existe ese archivo ... verifique"
    for y=1 to 1000000
    endfor
    clear
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Reemplaza especie"
    @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo
@ 2,117 say arch
select 1
use &arch
select 2
use especie1
if arch2<>space(12)
select 3
use &arch2
endif
if arch3<>space(12)
select 4
use &arch3
endif
select 5
use &arch4
JJ=0
KK=0
do while .t.
  esp1=space(11)
  esp2=space(11)
  @8,2 say "Cambiar especie: "get esp1
  @9,2 say "Por: "get esp2 
  @ 12,2 to 12,129 clear
  @ 12,2 say "Si deja el especio  vacío sale de esta opción"
  read
  if esp1<>space(11) .and. esp2<>space(11)
    es1=val(esp1)
    es2=val(esp2)
  endif
  if esp1=space(11) .OR. ESP2=SPACE(11)
    set color to ("b/w*")
    if uu=1    
      wait"OK-"
    endif  
    clear
    jj=0
    return
  endif
  EESS=0
  SSEE=0
  select especie1
  go top
  do while .not. eof()
    if codinidep=val(esp1)
      nom1=nomvulcas
      nom2=nomcient
      EESS=1
      JJ=1
    endif
    if codinidep=val(esp2)
      nom3=nomvulcas
      nom4=nomcient
      SSEE=1
      KK=1
    endif
    skip
  enddo
  IF EESS=0
    @ 15,2 SAY "NO EXISTE ESPECIE 1"
  ENDIF
  IF SSEE=0
    @ 15,22 SAY "/ NO EXISTE ESPECIE 2"  
  ENDIF  
  IF EESS=1 .AND. SSEE=1
    EESS=0
    SSEE=0
    @ 12,2 say "Cambia "+nom1+"  "+nom2+" por "+nom3+"   "+nom4+"?"  
    sn=space(1)
    @ 13,2 say "S/N" get sn pict"@!" 
    read
    if sn="S" .or. sn="s"
      select &arch
      index on lance to xx
      GO TOP
      DO WHILE .NOT. EOF()
        IF ESPECIE_1=val(esp1)
          REPLACE ESPECIE_1 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_2=val(esp1)
          REPLACE ESPECIE_2 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_3=val(esp1)
          REPLACE ESPECIE_3 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_4=val(esp1)
          REPLACE ESPECIE_4 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_5=val(esp1)
          REPLACE ESPECIE_5 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_6=val(esp1)
          REPLACE ESPECIE_6 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_7=val(esp1)
          REPLACE ESPECIE_7 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_8=val(esp1)
          REPLACE ESPECIE_8 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_9=val(esp1)
          REPLACE ESPECIE_9 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_10=val(esp1)
          REPLACE ESPECIE_10 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_11=val(esp1) 
          REPLACE ESPECIE_11 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_12=val(esp1)
          REPLACE ESPECIE_12 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_13=val(esp1)
          REPLACE ESPECIE_13 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_14=val(esp1)
          REPLACE ESPECIE_14 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_15=val(esp1)
          REPLACE ESPECIE_15 WITH val(esp2)
          uu=1
        ENDIF
       IF ESPECIE_16=val(esp1)
          REPLACE ESPECIE_16 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_17=val(esp1)
          REPLACE ESPECIE_17 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_18=val(esp1)
          REPLACE ESPECIE_18 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_19=val(esp1)
          REPLACE ESPECIE_19 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_20=val(esp1)
          REPLACE ESPECIE_20 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_21=val(esp1)
          REPLACE ESPECIE_21 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_22=val(esp1)
          REPLACE ESPECIE_22 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_23=val(esp1)
          REPLACE ESPECIE_23 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_24=val(esp1)
          REPLACE ESPECIE_24 WITH val(esp2)
          uu=1
        ENDIF
        IF ESPECIE_25=val(esp1)
          REPLACE ESPECIE_25 WITH val(esp2)
          uu=1
        ENDIF
        SKIP
      ENDDO
    endif
  ENDIF  
  @ 3,2 TO 14,129 clear
enddo
IF JJ<>0
  if arch2<>space(12)
  SELECT &ARCH2
  GO TOP
  DO WHILE .NOT. EOF()
    IF COD_espec=(es1)
      REPLACE ESPECIE WITH NOM4, cod_espec with (es2)
    ENDIF
    SKIP
  ENDDO 
  endif
  if arch3<>space(12)
  SELECT &ARCH3
  GO TOP
  DO WHILE .NOT. EOF()
    IF ESPECIE=NOM1
      REPLACE ESPECIE WITH NOM3  
    ENDIF
    IF ESPECIE=NOM2
      REPLACE ESPECIE WITH NOM4
    ENDIF
    SKIP
  ENDDO 
  endif
  SELECT &ARCH4
  GO TOP
  DO WHILE .NOT. EOF()
    IF ESPECIE=NOM1
      REPLACE ESPECIE WITH NOM3  
    ENDIF
    SKIP
  ENDDO 
ENDIF  
IF uu=1
  WAIT"OK-"
ENDIF
clear
close all
set color to  ("b/w*")
clear
