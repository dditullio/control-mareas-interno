DO WHILE .t.
@ 0,0 SAY " " FONT 'Times New Roman',12 
set point to ","
close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Posiciones"
*@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
irse=0
do while .t.
  ARCH=SPACE(12)
  codi=SPACE(12)
  @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
  *@4,2 say "   Especie         :" get codi
  READ
  cod=VAL(codi)
  if arch="            "
    set color to  ("b/w*")
    CLEAR
    irse=1
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


IF irse=1
  EXIT
endif

IF irse=0
zz=arch
zz2=SUBSTR(zz,2,6)
zz3="C"+TRIM(zz2)
SET ALTERNATE TO &zz3



SET ALTERNATE TO &zz3
SET ALTERNATE on



ta=0
USE &arch
GO top
DO WHILE .not. EOF()
  ki=0
  pz=0
  hm=0
  la=lat_inic
  lo=long_inic
  fi=fecha
  hi=hora_inic 
  hf=hora_final
  lacorr=(-1)*(((la-int(la))/0.6)+int(la))
  locorr=(-1)*(((lo-int(lo))/0.6)+int(lo))
*  if especie_1=cod
*    ki=ki+kg_1
*    pz=pz+descar_1
*  endif
*  if especie_2=cod
*    ki=ki+kg_2
*    pz=pz+descar_2
*  endif
*  if especie_3=cod
*    ki=ki+kg_3
*    pz=pz+descar_3
*  endif
*  if especie_4=cod
*    ki=ki+kg_4
*    pz=pz+descar_4
*  endif
*  if especie_5=cod
*    ki=ki+kg_5
*    pz=pz+descar_5
*  endif
*  if especie_6=cod
*    ki=ki+kg_6
*    pz=pz+descar_6
*  endif
*  if especie_7=cod
*    ki=ki+kg_7
*    pz=pz+descar_7
*  endif
*  if especie_8=cod
*    ki=ki+kg_8
*    pz=pz+descar_8
*  endif
*  if especie_9=cod
*    ki=ki+kg_9
*    pz=pz+descar_9
*  endif
*  if especie_10=cod
*    ki=ki+kg_10
*    pz=pz+descar_10
*  endif
*  if especie_11=cod
*    ki=ki+kg_11
*    pz=pz+descar_11
*  endif
*  if especie_12=cod
*    ki=ki+kg_12
*    pz=pz+descar_12
*  endif
*  if especie_13=cod
*    ki=ki+kg_13
 *   pz=pz+descar_13
 * endif
  *if especie_14=cod
   * ki=ki+kg_14
    *pz=pz+descar_14
*  endif
*  if* especie_15=cod
*    ki=ki+kg_15
*    pz=pz+descar_15
*  endif
*  if especie_16=cod
*    ki=ki+kg_16
*    pz=pz+descar_16
*  endif
*  if especie_17=cod
*    ki=ki+kg_17
*    pz=pz+descar_17
*  endif
*  if especie_18=cod
*    ki=ki+kg_18
*    pz=pz+descar_18
*  endif
*  if especie_19=cod
*    ki=ki+kg_19
*    pz=pz+descar_19
*  endif
*  if especie_20=cod
*    ki=ki+kg_20
*    pz=pz+descar_20
*  endif
*  if especie_21=cod
*    ki=ki+kg_21
*    pz=pz+descar_21
*  endif
*  if especie_22=cod
*    ki=ki+kg_22
*    pz=pz+descar_22
*  endif
*  if especie_23=cod
*    ki=ki+kg_23
*    pz=pz+descar_23
*  endif
*  if especie_24=cod
*    ki=ki+kg_24
*    pz=pz+descar_24
*  endif
*  if especie_25=cod
*    ki=ki+kg_25
*    pz=pz+descar_25
*  endif
*
*  if hf>hi
*    hhh=(((int(hi)*60)+((hi-(int(hi)))*100)))
*    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
*    hm=hm+((yyy-hhh)/60)
*  else
    hhh=((1440)-((int(hi)*60)+((hi-(int(hi)))*100)))
    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
    hm=hm+((yyy+hhh)/60)
*  endif
*  hm1=int(hm)
*  hm2=int(((hm-int(hm))*100)*60/100)
*  hm3=hm1+(hm2/100)
  if ta=0
    ta=1
    ? "Buque",";","marea",";","lan",";","fecha",";","latitud",";","longitud"
  ENDIF
    ? barco,";",marea,";",lance,";",fecha,";",lacorr,";",locorr,";","X"
    *,";",ki,";",pz,";",hm3
  SKIP
enddo 
SET ALTERNATE off
CLOSE all
ENDIF
enddo