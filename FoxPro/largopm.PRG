close all
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
CLEAR
ARCH=SPACE(12)
ESPE=SPACE(12)
sn=SPACE(1)
prod=space(1)
set color to  ("w+/b")
@3,0 SAY "ARCHIVO MUESTRA :" GET ARCH
@4,0 SAY "CODIGO ESPECIE  :" GET ESPE
@5,0 say "CON SEXO ? (S/N): " get prod pict"@!"
* VALID PROD$ "SN"
@6,0 say "TODOS O EN CERO?(T/O): " get SN pict"@!" 
*VALID SN$ "TO"
READ
IF ARCH=SPACE(12) .OR. ESPE=SPACE(12)
  CLEAR
  set color to  ("b/w*")
  RETURN
ENDIF
ESP=VAL(ESPE)  
SELECT 1
use &arch
SELECT 2
USE DATOSLG
SELECT DATOSLG
GO TOP
DO WHILE .NOT. EOF()
* esp
  IF CODIGO=esp 
    A1=AM
    B1=BM
    A2=AH
    B2=BH
    A3=A
    B3=B
    ? "COD"
  ENDIF  
  SKIP
ENDDO  
wait
PESOM=0

SELECT 1
GO TOP
DO WHILE .NOT. EOF()
  if COD_ESPEC=ESP
    b=talla_1/1000
    DO WW 
    b=talla_2/1000
    DO WW
    b=talla_3/1000
    DO WW
    b=talla_4/1000
    DO WW
    b=talla_5/1000
    DO WW
    b=talla_6/1000
    DO WW
    b=talla_7/1000
    DO WW
    b=talla_8/1000
    DO WW
    b=talla_9/1000
    DO WW
    b=talla_10/1000
    DO WW
    b=talla_11/1000
    DO WW
    b=talla_12/1000
    DO WW
    b=talla_13/1000
    DO WW
    b=talla_14/1000
    DO WW
    b=talla_15/1000
    DO WW
    b=talla_16/1000
    DO WW
    b=talla_17/1000
    DO WW
    b=talla_18/1000
    DO WW
    b=talla_19/1000
    DO WW
    b=talla_20/1000
    DO WW
    b=talla_21/1000
    DO WW
    b=talla_22/1000
    DO WW
    b=talla_23/1000
    DO WW
    b=talla_24/1000
    DO WW
    b=talla_25/1000
    DO WW
    b=talla_26/1000
    DO WW
    b=talla_27/1000
    DO WW
    b=talla_28/1000
    DO WW
    b=talla_29/1000
    DO WW
    b=talla_30/1000
    DO WW
    b=talla_31/1000
    DO WW
    b=talla_32/1000
    DO WW
    b=talla_33/1000
    DO WW
    b=talla_34/1000
    DO WW
    b=talla_35/1000
    DO WW
    b=talla_36/1000
    DO WW
    b=talla_37/1000
    DO WW
    b=talla_38/1000
    DO WW
    b=talla_39/1000
    DO WW
    b=talla_40/1000
    DO WW
    b=talla_41/1000
    DO WW
    b=talla_42/1000
    DO WW
    b=talla_43/1000
    DO WW
    b=talla_44/1000
    DO WW
    b=talla_45/1000
    DO WW
    b=talla_46/1000
    DO WW
    b=talla_47/1000
    DO WW
    b=talla_48/1000
    DO WW
    b=talla_49/1000
    DO WW
    b=talla_50/1000
    DO WW
    b=talla_51/1000
    DO WW
    b=talla_52/1000
    DO WW
    b=talla_53/1000
    DO WW
    b=talla_54/1000
    DO WW
    b=talla_55/1000
    DO WW
    b=talla_56/1000
    DO WW
    b=talla_57/1000
    DO WW
    b=talla_58/1000
    DO WW
    b=talla_59/1000
    DO WW
    b=talla_60/1000
    DO WW
    b=talla_61/1000
    DO WW
    b=talla_62/1000
    DO WW
    b=talla_63/1000
    DO WW
    b=talla_64/1000
    DO WW
    b=talla_65/1000
    DO WW
    b=talla_66/1000
    DO WW
    b=talla_67/1000
    DO WW
    b=talla_68/1000
    DO WW
    b=talla_69/1000
    DO WW
    b=talla_70/1000
    DO WW
    b=talla_71/1000
    DO WW
    b=talla_72/1000
    DO WW
    b=talla_73/1000
    DO WW
    b=talla_74/1000
    DO WW
    b=talla_75/1000
    DO WW
    b=talla_76/1000
    DO WW
    b=talla_77/1000
    DO WW
    b=talla_78/1000
    DO WW
    b=talla_79/1000
    DO WW
    b=talla_80/1000
    DO WW
    b=talla_81/1000
    DO WW
    b=talla_82/1000
    DO WW
    b=talla_83/1000
    DO WW
    b=talla_84/1000
    DO WW
    b=talla_85/1000
    DO WW
    b=talla_86/1000
    DO WW
    b=talla_87/1000
    DO WW
    b=talla_88/1000
    DO WW
    b=talla_89/1000
    DO WW
    b=talla_90/1000
    DO WW
    IF PESOM<>0
      REPLACE PESO_MUES WITH PESOM
      PESOM=0
    ENDIF  
  endif
  SKIP
ENDDO
clear
CLOSE ALL


PROCEDURE WW
    c=int(b)
    d=b-c
    e=d*1000
    E2=ROUND(E,0)
    tot=int(e2)
  * tot ---> total bichos
    m=c/1000000000000
    m1=int(m)
    m3=m-m1
    m4=m3*1000
    m5=round(m4,0)
    m2=int(m5)
    *?? M2,"   "
  * m2  ---> talla
    ic=C/1000
    id=ic-int(ic)
    ie=id*1000
    iE2=ROUND(iE,0)
    itot=int(ie2)
    *?? ITOT,"   "
  * itot ---> indet 
    Hc=int(ic)/1000
    Hd=Hc-int(Hc)
    He=Hd*1000
    HE2=ROUND(HE,0)
    Htot=int(He2)
    *?? HTOT,"   "
  * ntot ---> hembras
    Mc=int(Hc)/1000
    Md=Mc-int(Mc)
    Me=Md*1000
    ME2=ROUND(ME,0)
    Mtot=int(Me2)
    *?? MTOT,"    "
  * mtot ---> machos 
    if m2=0
      m2=1
    endif  
    if (prod="S" .or. prod="s") .AND. (SN="o" .OR. SN="O")
      IF PESO_MUES=0
    	pm=A1*(m2**b1)*MTOT
    	pH=A2*(m2**B2)*HTOT 
    	PESOM=PESOM+PM+PH
    	PM=0
    	PH=0
      ENDIF	
    endif
    if (prod="N" .or. prod="n") .AND. (SN="o" .OR. SN="O")
      IF PESO_MUES=0
    	p=a3*(m2**b3)*TOT
        PESOM=PESOM+P
        P=0
      ENDIF	
    endif
    if (prod="N" .or. prod="n") .AND. (SN="T" .OR. SN="t")
      IF PESO_MUES<>0
    	p=a3*(m2**b3)*TOT
        PESOM=PESOM+P
        P=0
      ENDIF	
    endif
    if (prod="S" .or. prod="s")  .AND. (SN="T" .OR. SN="t")
  	  pm=A1*(m2**b1)*MTOT
  	  pH=A2*(m2**B2)*HTOT 
      PESOM=PESOM+PM+PH
      PM=0
      PH=0
    ENDIF
    ? "TOT"
    m2=0
    TOT=0
    iTOT=0
    mTOT=0
    hTOT=0
   RETURN
set color to  ("b/w*")
clear