
DO WHILE .t.
  SET DECIMALS TO 2
 
  SET point TO "."
  
  @ 0,0 SAY " " FONT 'Times New Roman',12 
  set point to ","
  set separator to "."
  close all
  CLEAR
  irse=0
  set color to  ("R/w*")
  @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - DISTRIBUCIÓN DE TALLAS"
  *@ 1,1 to 15,130
  set color to  ("B/w*")
  set safety off
  set exclusive off
  #INCLUDE 'FILEIO.CH'
  do while .t.
    ARCH=SPACE(12)
    ESP=SPACE(10)
    @3,2 SAY "   ARCHIVO MUESTRA :" GET ARCH
    @4,2 SAY "   ESPECIE         :" GET ESP
    READ
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
      @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - DISTRIBUCIÓN DE TALLAS"
   *    @ 1,1 to 15,130
      set color to  ("b/w*")    
      loop
    endif
  enddo

  IF irse=1
    EXIT
  ENDIF
 


  IF irse=0
    espe=INT(VAL(esp))
    zz=arch
    zz3="D"+TRIM(zz)

    zzzz=zz3

    edad=0

    IF espe=5139030101
      edad=0
      oo="L"
    ENDIF
   
    IF espe=7210040101
      edad=35
      pp="%<"+STR(edad,2)
      oo="MH"
    ENDIF

    IF espe=7210040201
      edad=59
      pp="%<"+STR(edad,2)
      oo="MC"
    ENDIF

    IF espe=7226030101
      edad=70
      pp="%<"+STR(edad,2)
      oo="A"  
    ENDIF

    IF espe=7218280201
      edad=82
      pp="%<"+STR(edad,2)
      oo="MN"  
    ENDIF

    IF espe=7210030201
      edad=32
      pp="%<"+STR(edad,2)
      oo="P"  
    ENDIF

    IF espe=7210040103
      edad=61
      pp="%<"+STR(edad,2)
      oo="MA"  
    ENDIF

    IF espe=7218390102
      edad=29
      pp="%<"+STR(edad,2)
      oo="S"  
    ENDIF

    IF espe=7204020101
      edad=93
      pp="%<"+STR(edad,2)
      oo="S"  
    ENDIF

    namo=oo+(TRIM(zzzz))
    nam=TRIM(namo)
    ? nam
    wait""  
    SET ALTERNATE TO &nam

    SET ALTERNATE on

    DIMENSION ma(300), he(300), ind(300), tot(300)
 

    FOR y=1 TO 300
      ma(y)=0
      he(y)=0
      ind(y)=0
      tot(y)=0
    NEXT y  

    @ 2,117 say arch
    @ 3,1 clear to 3,100
    qm=0
    qh=0
    qi=0
    qt=0
    sm=0
    sh=0
    si=0
    st=0
    pm=0
    ph=0
    pn=0
    po=0

    edma=0
    edhe=0
    edin=0
    edto=0
 
    mi=1000
    mx=0



    
    
    use &arch
    INDEX on cod_espec TO tt
    GO top
    DO WHILE .not. EOF()
      IF cod_espec=espe
        FOR t=91 TO 150
          IF t>90 .and. t<100
            tall="talla_"+STR(t,2)
          ENDIF
          IF t>99
            tall="talla_"+STR(t,3)
          ENDIF
     
     
          x=&tall
          xx=STR(x,15)
          IF x<>0
            xx2=INT(VAL(Substr(xx,1,3)))
            xxma=INT(VAL(Substr(xx,4,3)))
            xxhe=INT(VAL(Substr(xx,7,3)))
            xxin=INT(VAL(Substr(xx,10,3)))
            xxto=INT(VAL(Substr(xx,13,3)))
      
            IF xx2<mi
              mi=xx2
            ENDIF
            IF xx2>mx
              mx=xx2
            ENDIF  
        
            ma(xx2)=ma(xx2)+xxma
            he(xx2)=he(xx2)+xxhe
            ind(xx2)=ind(xx2)+xxin
            tot(xx2)=tot(xx2)+xxto
      
            IF xx2<edad
              edma=edma+xxma
              edhe=edhe+xxhe
              edin=edin+xxin
              edto=edto+xxto
            endif
          endif
        NEXT t
      ENDIF
      SKIP
    enddo    

    USE especie1
    GO top
    DO WHILE .not. EOF()
      IF codinidep=espe
        nc=nomcient
        nv=nomvulcas
        EXIT
      ENDIF
      SKIP
    ENDDO
    clear
 
    ? "MUESTRAS AGRUPADAS DE UNA ESPECIE"
    ? espe,";",nc,";",nv
    ? 
    ? "Talla",";","MACHOS",";","HEMBRAS",";","INDET",";","TOTAL"
    FOR y=mi TO mx
      IF ma(y)<>0 .or. he(y)<>0 .or. ind(y)<>0
        totl=ma(y)+he(y)+ind(y)
      ELSE
        totl=tot(y)
      endif
      ?  y,";",ma(y),";",he(y),";",ind(y),";",tot(y)
 
      sm=sm+ma(y)
      sh=sh+he(y)
      si=si+ind(y)
      st=st+tot(y)
      pm=pm+(y*ma(y))
      ph=ph+(y*he(y))
      pn=pn+(y*ind(y))
      po=po+(y*tot(y))
    NEXT y  
 
    IF sm>0
      bm=pm/(sm-1)
    else
      bm=0
    ENDIF
    IF sh>0
      bh=ph/(sh-1)
    else
      bh=0
    ENDIF
 
    IF si>0
      bi=pn/(si-1)
    else
      bi=0
    ENDIF
 
    IF st>0
      bt=po/(st-1)
    else
      bt=0
    ENDIF
 
    *  porcentaje x sexo sobre total ejemplares
    IF st>0
      porm=(sm/st)*100
    ELSE
      porm=0
    ENDIF
    IF st>0
      porh=(sh/st)*100
    ELSE
      porh=0
    ENDIF
    IF st>0
      pori=(si/st)*100
    ELSE
      pori=0
    ENDIF
    IF st>0
      port=(st/st)*100
    ELSE
      port=0
    endif
    
   * media (n-ñ)
    IF sm>0
      varm=pm/sm
    ELSE
      varm=0
    ENDIF
    IF sh>0
      varh=ph/sh
    ELSE
      varh=0
    ENDIF
    IF si>0
      vari=pn/si
    ELSE
      vari=0
    ENDIF
    IF st>0
      varo=po/st
    ELSE
      varo=0
    endif
  
    FOR y=mi TO mx
      qm=qm+(((y-varm)*(y-varm))*ma(y))
      qh=qh+(((y-varh)*(y-varh))*he(y))
      qi=qi+(((y-vari)*(y-vari))*ind(y))
      qt=qt+(((y-varo)*(y-varo))*tot(y))
    NEXT y  

   * Desviacion st
    IF sm>1
      zm=SQRT(qm/(sm-1))
    ELSE
      zm=0
    ENDIF
    IF sh>1
      zh=SQRT(qh/(sh-1))
    ELSE
      zh=0
    ENDIF
    IF si>1
      zi=SQRT(qi/(si-1))
    ELSE
      zi=0
    ENDIF
    IF st>1
      zt=SQRT(qt/(st-1))
    ELSE
      zt=0
    endif

    * Coef V
    IF qm>0
      um=(zm/bm)*100
    ELSE
      um=0
    endif

    IF qh>0
      uh=(zh/bh)*100
    ELSE
      uh=0
    endif

    IF qi>0
      ui=(zi/bi)*100
    ELSE
      ui=0
    endif


    IF qt>0
      ut=(zt/bt)*100
    ELSE
      ut=0
    endif

    IF bm>0
      gm=pm*bm
    else
      gm=0
    ENDIF
    IF bh>0
      gh=ph*bh
    else
      gh=0
    ENDIF
    IF bi>0
      gi=pn*bi
    else
      gi=0
    ENDIF
    IF bt>0
      gt=po*bt
    else
      gt=0
    ENDIF 

    IF um>0
      ppm=(edma/sm)*100
    ELSE
      ppm=0.00
    ENDIF
 
    IF uh>0
      pph=(edhe/sh)*100
    ELSE
      pph=0.00
    ENDIF

    IF ui>0
      ppi=(edin/si)*100
    ELSE
      ppi=0.00
    ENDIF

    IF ut>0
      ppt=(edto/st)*100
    ELSE
      ppt=0.00
    endif

    IF edad<>0
      ?
      ? "",";","Media",";","Desv.St.",";","Porcent.",";","Coef.V.",";","Suma N",";","Suma X",";","Suma X2",";",pp
      ? "Machos",";",STR(varm,6,2),";",STR(zm,7,2),";",STR(porm,7,2),";",STR(um,7,2),";",sm,";",pm,";",STR(gm,12),";",STR(ppm,6,2)
      ? "Hembras",";",STR(varh,6,2),";",STR(zh,7,2),";",STR(porh,7,2),";",STR(uh,7,2),";",sh,";",ph,";",STR(gh,12),";",STR(pph,6,2)
      ? "Indet.",";",STR(vari,6,2),";",STR(zi,7,2),";",STR(pori,7,2),";",STR(ui,7,2),";",si,";",pn,";",STR(gi,12),";",STR(ppi,6,2)
      ? "Total",";",STR(varo,6,2),";",STR(zt,7,2),";",STR(port,7,2),";",STR(ut,7,2),";",st,";",po,";",STR(gt,12),";",STR(ppt,6,2)
    ENDIF

    IF edad=0
      ?
      ? "",";","Media",";","Desv.St.",";","Porcent.",";","Coef.V.",";","Suma N",";","Suma X",";","Suma X2"
      ? "Machos",";",STR(varm,6,2),";",STR(zm,7,2),";",STR(porm,7,2),";",STR(um,7,2),";",sm,";",pm,";",STR(gm,12)
      ? "Hembras",";",STR(varh,6,2),";",STR(zh,7,2),";",STR(porh,7,2),";",STR(uh,7,2),";",sh,";",ph,";",STR(gh,12)
      ? "Indet.",";",STR(vari,6,2),";",STR(zi,7,2),";",STR(pori,7,2),";",STR(ui,7,2),";",si,";",pn,";",STR(gi,12)
      ? "Total",";",STR(varo,6,2),";",STR(zt,7,2),";",STR(port,7,2),";",STR(ut,7,2),";",st,";",po,";",STR(gt,12)
    ENDIF
 
    SET ALTERNATE off
    CLOSE all
  ENDIF
ENDDO


