close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Posiciones"
*@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  codi=SPACE(12)
  @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
  @4,2 say "   Especie         :" get codi
  READ
  cod=VAL(codi)
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
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Posiciones"
     *   @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo

SET ALTERNATE TO Palposiciones
SET ALTERNATE on

ta=0
USE &arch
GO top
DO WHILE .not. EOF()
  ki=0
  pz=0
  hm=0
  la=lat_inic_f
  lo=long_in_f
  fi=fecha_fi
  ff=fecha_vi
  hi=hora_ini_f 
  hf=hora_ini_v
  lacorr=(-1)*(((la-int(la))/0.6)+int(la))
  locorr=(-1)*(((lo-int(lo))/0.6)+int(lo))
  if especie_1=cod
    ki=ki+kg_1
    pz=pz+pieza_1
  endif
  if especie_2=cod
    ki=ki+kg_2
    pz=pz+pieza_2
  endif
  if especie_3=cod
    ki=ki+kg_3
    pz=pz+pieza_3
  endif
  if especie_4=cod
    ki=ki+kg_4
    pz=pz+pieza_4
  endif
  if especie_5=cod
    ki=ki+kg_5
    pz=pz+pieza_5
  endif
  if especie_6=cod
    ki=ki+kg_6
    pz=pz+pieza_6
  endif
  if especie_7=cod
    ki=ki+kg_7
    pz=pz+pieza_7
  endif
  if especie_8=cod
    ki=ki+kg_8
    pz=pz+pieza_8
  endif
  if especie_9=cod
    ki=ki+kg_9
    pz=pz+pieza_9
  endif
  if especie_10=cod
    ki=ki+kg_10
    pz=pz+pieza_10
  endif
  if ff=fi
    hhh=(((int(hi)*60)+((hi-(int(hi)))*100)))
    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
    hm=hm+((yyy-hhh)/60)
  else
    dd=ff-fi
    hhh=((1440*dd)-((int(hi)*60)+((hi-(int(hi)))*100)))
    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
    hm=hm+((yyy+hhh)/60)
  endif
  hm1=int(hm)
  hm2=int(((hm-int(hm))*100)*60/100)
  hm3=hm1+(hm2/100)
  anztot=1000*ki/anz_ntotal
  anztot2=1000*pz/anz_ntotal
  if ta=0
    ta=1
    ? "                                                                                                 Captura/  Piezas/"
    ? "Buque               marea lan  fecha           latitud          longitud       (kilos)    Piezas mls. anz. mls. anz.    anz.      horas"
  ENDIF
    ? barco,marea,lance,fecha_fi,lacorr,locorr,ki,pz,STR(anztot,8,2),STR(anztot2,8,2),"    ",STR(anz_ntotal,8),"    ",hm3,"	",anz_ntotal
  SKIP
enddo 
SET ALTERNATE off
CLOSE all