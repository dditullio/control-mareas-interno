x=0
y=0
z=0
@ 0,0 SAY " " FONT 'Courier New',9 
set point to ","
set separator to "."
close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Errores"
*@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  arch2=space(12)
  arch3=space(12)
  arch4=space(12)
  arch5=space(12)
  @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
  @4,2 SAY "           MUESTRA :" GET ARCH2
  @5,2 SAY "        SUBMUESTRA :" GET ARCH3
  @6,2 SAY "        PRODUCCION :" GET ARCH4
  @7,2 SAY "          DESCARTE :" GET ARCH5
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
  capt5=trim(arch5)+".dbf"
  if file(capt3)=.t.
    x=1
  else
    x=0  
  endif
  
  if file(capt4)=.t.
    y=1
  else
    y=0  
  endif
  
  if file(capt5)=.t.
    z=1
  else
    z=0  
  endif
  
  if file(capt)<>.t. .OR. file(capt)<>.t. 
    @ 8,2 say "No existe ese archivo ... verifique"
    for y=1 to 1000000
    endfor
    clear
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Errores"
    set color to  ("b/w*")    
    loop
  else
    exit  
  endif
enddo

clear
SET ALTERNATE TO errores
SET ALTERNATE on


@ 3,1 clear to 3,100

select 1
use &arch

select 2
use &arch2

if x=1
  select 3
  use &arch3
endif

if y=1
  select 4
  use &arch4
endif

if z=1
  select 5
  use &arch5
endif

select 6
use especie1


? "Captura"

select 1
go top
do while .not. eof()
  for t=1 to 25
    if t<10
      es="especie_"+str(t,1)
      kg="kg_"+str(t,1)
      de="descar_"+str(t,1)
    else
      es="especie_"+str(t,2)
      kg="kg_"+str(t,2)
      de="descar_"+str(t,2)
    endif
    if &es<2900000000 .and. &es<>0
      ? "Numeros sueltos",";",lance,";",t
    endif
    if &kg<&de
      ? "Kilos menor a descarte",";",lance,";",t
    endif
    if &es>=7700000000 .and. &es<9999999999
      ? "Mamiferos",";",lance,";",t,";",&kg
    endif
    K=kg_1+kg_2+kg_3+kg_4+kg_5+kg_6+kg_7+kg_8+kg_9+kg_10+kg_11+kg_12+kg_13+kg_14+kg_15+kg_16+kg_17+kg_18+kg_19+kg_20+kg_21+kg_22+kg_23+kg_24+kg_25
    D=descar_1+descar_2+descar_3+descar_4+descar_5+descar_6+descar_7+descar_8+descar_9+descar_10+descar_11+descar_12+descar_13+descar_14+descar_15+descar_16+descar_17+descar_18+descar_19+descar_20+descar_21+descar_22+descar_23+descar_24+descar_25
    if capt_total<>K 
      ? "suma kilos distinta a capt_total",";",lance,";",t
    endif
    if descarte<>D 
      ? "suma descarte distinto a descarte",";",lance,";",t
    endif
  next t
  skip
enddo

? "Muestra"

select 2
go top
do while .not. eof()
  ed=cod_espec
  pe=peso_mues
  l=lance
  rec=recno()
  select 1
  go top
  f=0
  o=0
  do while .not. eof()
    if lance=l
      for t=1 to 25
        if t<10
          es="especie_"+str(t,1)
          kg="kg_"+str(t,1)
          de="descar_"+str(t,1)
        else
          es="especie_"+str(t,2)
          kg="kg_"+str(t,2)
          de="descar_"+str(t,3)
        endif
        if &es=ed
          f=1
          o=1
        endif
        if o=1 .and. pe>&kg
          ? "Kilos menor a descarte",";",lance,";",t
        endif
        o=0
      next t
      if f=0
        ? "No aparece la especie",";",l,";",ed
      endif      
    endif  
    skip
  enddo
  select 2
  if .not. eof()
    goto rec
  endif
  for t=1 to 90
    if t<10
      ta="talla_"+str(t,1)
    else
      ta="talla_"+str(t,2)
    endif
    if &ta<4000000000000 .and. &ta<>0
      ? "Ejemplares demasiados pequeños",";",lance,";",t,";",ed,";",&ta
    endif
    sub=str(&ta,15)
    if val(substr(sub,13,3))>60
      ? "Muchos ejemplares",";",lance,";",t,";",ed,";",sub
    endif
  next t   
  skip
enddo




if z=1
  ? "Muestras de descarte"
  select 5
  go top
  do while .not. eof()
    ed=cod_espec
    pe=peso_mues
    l=lance
    rec=recno()
    select 1
    go top
    f=0
    o=0
    do while .not. eof()
      if lance=l
        for t=1 to 25
          if t<10
            es="especie_"+str(t,1)
            kg="kg_"+str(t,1)
            de="descar_"+str(t,1)
          else
            es="especie_"+str(t,2)
            kg="kg_"+str(t,2)
            de="descar_"+str(t,3)
          endif
          if &es=ed
            f=1
            o=1
          endif
          if o=1 .and. pe>&kg
            ? "Kilos menor a descarte",";",lance,";",t
          endif
          o=0
        next t
        if f=0
          ? "No aparece la especie",";",l,";",ed
        endif      
      endif  
      skip
    enddo
    select 5
    goto rec
    for t=1 to 90
      if t<10
        ta="talla_"+str(t,1)
      else
        ta="talla_"+str(t,2)
      endif
      if &ta<4000000000000 .and. &ta<>0
        ? "Ejemplares demasiados pequeños",";",lance,";",t,";",ed,";",&ta
      endif
      sub=str(&ta,15)
      if val(substr(sub,13,3))>40
        ? "Muchos ejemplares",";",lance,";",t,";",ed,";",sub
      endif
    next t   
    skip
  enddo
endif


if x=1
  ? "Submuestras"
  select 3
  go top
  do while .not. eof()
    ed=especie
    ? "2_fsdffds"
    la=lance
    rec=recno()
    select 6
    go top
    do while .not. eof()
      if ed=nomcient .or. ed=nomvulcas
        co=codinidep
        exit
      endif
      skip
    enddo
    select 1
    go top
    f=0
    do while .not. eof()
      if lance=la
        for t=1 to 25
          if t<10
            es="especie_"+str(t,1)
            kg="kg_"+str(t,1)
            de="descar_"+str(t,1)
          else
            es="especie_"+str(t,2)
            kg="kg_"+str(t,2)
            de="descar_"+str(t,3)
          endif
          if &es=ed
            f=1
          endif
        next t
        if f=0
          ? "No aparece la especie",";",l,";",ed
        endif      
      endif
      skip
    enddo
    select 3
    goto rec
    skip
  enddo
endif

if y=1
  ? "Produccion"
  select 4
  go top
  do while .not. eof()
    ed=especie
    rec=recno()
    select 6
    go top
    do while .not. eof()
      if ed=nomcient .or. ed=nomvulcas
        co=codinidep
        exit
      endif
      skip
    enddo
    select 1
    go top
    f=0
    do while .not. eof()
      if lance=la
        for t=1 to 25
          if t<10
            es="especie_"+str(t,1)
            kg="kg_"+str(t,1)
            de="descar_"+str(t,1)
          else
            es="especie_"+str(t,2)
            kg="kg_"+str(t,2)
            de="descar_"+str(t,3)
          endif
          if &es=ed
            f=1
          endif
        next t
        if f=0
          ? "No aparece la especie",";",l,";",ed
        endif      
      endif
      skip
    enddo
    select 4
    goto rec
    skip
  enddo
endif




set alternate off
close all