close all
clear
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - CAMPARA CAPTURAS/MUESTRAS"
set color to  ("B/w*")
@ 1,1 to 37,130
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
sad=0
do while .t.
  ARCH=SPACE(12)
  cap=space(12)
  @3,2 say "Archivo captura : " get cap 
  @4,2 SAY "Archivo muestra : " GET ARCH
  READ
  if cap=space(12) .or. arch=space(12) 
    set color to ("b/w*")
    clear
    return
  endif
  capt=trim(arch)+".dbf"
  cap1=trim(cap)+".dbf"
  if file(capt)=.t. .and. file(cap1)=.t.
    exit
  endif  
  if file(capt)<>.t. .or. file(cap1)<>.t.
    clear
    @ 5,2 say "No existe ese archivo ... verifique"
    clear
    for y=1 to 1000000
    endfor
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - CAMPARA CAPTURAS/MUESTRAS"
    set color to  ("B/w*")
    @ 1,1 to 37,130
    loop
  endif
enddo
clear
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - CAMPARA CAPTURAS/MUESTRAS"
set color to  ("B/w*")
@ 1,1 to 37,130
SELECT 1
use &ARCH
index on str(cod_espec,10)+str(lance,3) to rr
SELECT 2
USE ESPECIE1
select 3
use &cap
*SELECT 4
*USE JUVENILES
select &arch
go top
x=4
cant=0
@ 3,2 say "LANCE       TALLA MIN   TALLA MAX    PESO MUES    EJEMPLARES                         CAPTURA"
do while .not. eof()
  a=cod_espec
  b=recno()
  select especie1
  go top
  do while .not. eof()
    if codinidep=a
      vul=nomvulcas
      exit
    endif
    skip
  enddo
  @ x,2 say vul
  x=x+1
  select &arch
  goto b
  do while cod_espec=a
    l=lance
    mi=prim_talla
    ul=ult_talla
    pe=peso_mues
    if talla_1<>0
      xx=talla_1/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_2<>0
      xx=talla_2/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_3<>0
      xx=talla_3/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_4<>0
      xx=talla_4/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_5<>0
      xx=talla_5/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_6<>0
      xx=talla_6/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_7<>0
      xx=talla_7/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_8<>0
      xx=talla_8/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_9<>0
      xx=talla_9/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_10<>0
      xx=talla_10/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_11<>0
      xx=talla_11/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_12<>0
      xx=talla_12/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_13<>0
      xx=talla_13/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_14<>0
      xx=talla_14/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_15<>0
      xx=talla_15/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_16<>0
      xx=talla_16/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_17<>0
      xx=talla_17/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_18<>0
      xx=talla_18/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_19<>0
      xx=talla_19/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_20<>0
      xx=talla_20/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_21<>0
      xx=talla_21/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_22<>0
      xx=talla_22/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_23<>0
      xx=talla_23/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_24<>0
      xx=talla_24/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_25<>0
      xx=talla_25/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_26<>0
      xx=talla_26/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_27>0
      xx=talla_27/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_28<>0
      xx=talla_28/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_29<>0
      xx=talla_29/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_30<>0
      xx=talla_30/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_31<>0
      xx=talla_31/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_32<>0
      xx=talla_32/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_33<>0
      xx=talla_33/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_34<>0
      xx=talla_34/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_35<>0
      xx=talla_35/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_36<>0
      xx=talla_36/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_37<>0
      xx=talla_37/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_38<>0
      xx=talla_38/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_39<>0
      xx=talla_39/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_40<>0
      xx=talla_40/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_41<>0
      xx=talla_41/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_42<>0
      xx=talla_42/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_43<>0
      xx=talla_43/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_44<>0
      xx=talla_44/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_45<>0
      xx=talla_45/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_46<>0
      xx=talla_46/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_47<>0
      xx=talla_47/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_48<>0
      xx=talla_48/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_49<>0
      xx=talla_49/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_50<>0
      xx=talla_50/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_51<>0
      xx=talla_51/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_52<>0
      xx=talla_52/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_53<>0
      xx=talla_53/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_54<>0
      xx=talla_54/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_55<>0
      xx=talla_55/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_56<>0
      xx=talla_56/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_57<>0
      xx=talla_57/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_58<>0
      xx=talla_58/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_59<>0
      xx=talla_59/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_60<>0
      xx=talla_60/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_61<>0
      xx=talla_61/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_62<>0
      xx=talla_62/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_63<>0
      xx=talla_63/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_64<>0
      xx=talla_64/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_65<>0
      xx=talla_65/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_66<>0
      xx=talla_66/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_67<>0
      xx=talla_67/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_68<>0
      xx=talla_68/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_69<>0
      xx=talla_69/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_70<>0
      xx=talla_70/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_71<>0
      xx=talla_71/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_72<>0
      xx=talla_72/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_73>0
      xx=talla_73/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_74<>0
      xx=talla_74/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_75<>0
      xx=talla_75/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_76<>0
      xx=talla_76/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_77<>0
      xx=talla_77/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_78<>0
      xx=talla_78/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_79<>0
      xx=talla_79/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_80<>0
      xx=talla_80/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_81<>0
      xx=talla_81/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_82<>0
      xx=talla_82/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_83<>0
      xx=talla_83/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_84<>0
      xx=talla_84/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_85<>0
      xx=talla_85/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_86<>0
      xx=talla_86/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_87<>0
      xx=talla_87/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_88<>0
      xx=talla_88/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_89<>0
      xx=talla_89/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    if talla_90<>0
      xx=talla_90/1000
      c=int(xx)
      yy=xx-c
      rr=yy*1000
      zz=ROUND(rr,0)
      cant=cant+int(zz)
    endif
    skip
    b=recno()
    select &cap
    go top
    do while .not. eof()
      if lance=l
        if especie_1=a
          so=kg_1
          exit
        endif
        if especie_2=a
          so=kg_2
          exit
        endif
        if especie_3=a
          so=kg_3
          exit
        endif
        if especie_4=a
          so=kg_4
          exit
        endif
        if especie_5=a
          so=kg_5
          exit
        endif
        if especie_6=a
          so=kg_6
          exit
        endif
        if especie_7=a
          so=kg_7
          exit
        endif
        if especie_8=a
          so=kg_8
          exit
        endif
        if especie_9=a
          so=kg_9
          exit
        endif
        if especie_10=a
          so=kg_10
          exit
        endif
        if especie_11=a
          so=kg_11
          exit
        endif
        if especie_12=a
          so=kg_12
          exit
        endif
        if especie_13=a
          so=kg_13
          exit
        endif
        if especie_14=a
          so=kg_14
          exit
        endif
        if especie_15=a
          so=kg_15
          exit
        endif
        if especie_16=a
          so=kg_16
          exit
        endif
        if especie_17=a
          so=kg_17
          exit
        endif
        if especie_18=a
          so=kg_18
          exit
        endif
        if especie_19=a
          so=kg_19
          exit
        endif
        if especie_20=a
          so=kg_20
          exit
        endif
      endif
      SKIP
      SO=0
    ENDDO
    SELECT &ARCH
    if .not. eof()
    GOTO B
    endif
    @ x,2 say str(l,3)+"                   "+str(mi,3)+"             "+str(ul,3)+"                           "+str(pe,8,2)+"        "+str(cant,5)+"             "
    sad=sad+cant
    iF sO=0
      @ X,60 SAY "-------------"
    ENDIF
    wait""
    IF sO>0
      @X, 80 SAY STR(sO,9,2)
    endif
    cant=0
    x=x+2
    if x>=35
      wait""
      x=4
      clear
      set color to  ("R/w*")
      @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - CAMPARA CAPTURAS/MUESTRAS"
      set color to  ("B/w*")
      @ 1,1 to 37,130
      @ x,2 say vul
      x=x+1
    endif  
  enddo
enddo
? sad
close all
@ 36,2 SAY ""
wait " FIN"
set color to  ("b/w*")
clear
