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
  codi=SPACE(10)
  @3,2 SAY "    ARCHIVO CAPTURA :" GET ARCH
  @4,2 say "Especie             :"get codi
  READ
  CODD=TRIM(CODI)
  LELE=LEN(CODD)
  cod=VAL(codD)
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

SET ALTERNATE TO Varposiciones
SET ALTERNATE on
DIMENSION ki(10,300), de(10,300), d(10)

ta=0
SELECT 1
USE &arch

SELECT 2
USE especie1

FOR c=1 TO 10
  FOR y=1 TO 300
    ki(c,y)=0
    de(c,y)=0
  NEXT y
  d(c)=SPACE(8)
NEXT c
e=0
SELECT 2
GO top
DO WHILE .not. EOF()
  IF LEFT(STR(codinidep,10),LELE)=LEFT(codi,LELE)
    e=e+1
    jj=300
    a=codinidep
    rec=RECNO()
    SELECT 1
    GO top
    DO WHILE .not. EOF()
      FOR t=1 TO 25
        IF t<10
          es="especie_"+STR(t,1)
          kg="kg_"+STR(t,1)
          des="descar_"+STR(t,1)
        ELSE
          es="especie_"+STR(t,2)
          kg="kg_"+STR(t,2)
          des="descar_"+STR(t,2)
        ENDIF
        IF &es=a
          ki(e,lance)=ki(e,lance)+&kg
          de(e,lance)=de(e,lance)+&des
          jj=lance
        ENDIF
      NEXT t
      SKIP
    ENDDO
    SELECT 2
    GOTO rec
    IF ki(e,jj)=0
      e=e-1
    ELSE
      d(e)=(TRIM(nomcient))
    endif  
  ENDIF
  SKIP
ENDDO

FOR U=1 TO 10
  
  ? U,"	",D(U)
  
NEXT U

SELECT 1
GO top
DO WHILE .not. EOF()
  pz=0
  hm=0
  la=lat_inic
  lo=long_inic
  fi=fecha
  hi=hora_inic 
  hf=hora_final
  lacorr=(-1)*(((la-int(la))/0.6)+int(la))
  locorr=(-1)*(((lo-int(lo))/0.6)+int(lo))
  if hf>hi
    hhh=(((int(hi)*60)+((hi-(int(hi)))*100)))
    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
    hm=hm+((yyy-hhh)/60)
  else
    hhh=((1440)-((int(hi)*60)+((hi-(int(hi)))*100)))
    yyy=(((int(hf)*60)+((hf-(int(hf)))*100)))
    hm=hm+((yyy+hhh)/60)
  endif
  hm1=int(hm)
  hm2=int(((hm-int(hm))*100)*60/100)
  hm3=hm1+(hm2/100)
  if ta=0
    ta=1
    ? "                                                                                                           ",1,"				   ",2,"		    	   ",3,"			 ",4,"		           ",5,"			     ",6,"			     ",7,"			     ",8,"			     ",9,"			     ",10
    ? "Buque                   marea lan  fecha           latitud          longitud         horas         (kg)		 (de) 	 	(kg)		(de) 	   (kg)	          (de)	         (kg)		(de)	  (kg)		(de) 	      (kg)		(de) 	(kg)		(de) 	(kg)		(de)	 (kg)		(de)	 (kg)		(de)"
  ENDIF
    ? barco,marea,lance,fecha,lacorr,locorr,hm3,"  "
    IF ki(1,lance)<>0
    ?? ki(1,lance),de(1,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(2,lance)<>0
    ?? ki(2,lance),de(2,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(3,lance)<>0
    ?? ki(3,lance),de(3,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(4,lance)<>0
    ?? ki(4,lance),de(4,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(5,lance)<>0
    ?? ki(5,lance),de(5,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(6,lance)<>0
    ?? ki(6,lance),de(6,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(7,lance)<>0
    ?? ki(7,lance),de(7,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(8,lance)<>0
    ?? ki(8,lance),de(8,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(9,lance)<>0
    ?? ki(9,lance),de(9,lance)
    ELSE
    ?? "                           "
    ENDIF
    IF ki(10,lance)<>0
    ?? ki(10,lance),de(10,lance)
    ELSE
    ?? "                           "
    endif
  SKIP
enddo 
SET ALTERNATE off
CLOSE all