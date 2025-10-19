DO WHILE .t.
  @ 0,0 SAY " " FONT 'Times New Roman',12 
  set point to ","
  set separator to "."
  close all
  CLEAR
  irse=0
  set color to  ("R/w*")
  @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Especies días y horas"
  set color to  ("B/w*")
  set safety off
  set exclusive off
  #INCLUDE 'FILEIO.CH'
  do while .t.
    ARCH=SPACE(12)
    @3,2 SAY "   ARCHIVO CAPTURA :" GET ARCH
    READ
    if arch="            "
      set color to  ("b/w*")
      CLEAR
      irse=1
      EXIT
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
      @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Especies días y horas"
      set color to  ("b/w*")    
      loop
    endif
  enddo
  
  IF irse=1
    EXIT
  ENDIF

  zz=arch
  zz2=SUBSTR(zz,2,6)
  zz3="B"+TRIM(zz2)
  SET ALTERNATE TO &zz3
  SET ALTERNATE on

  @ 2,117 say arch
  @ 3,1 clear to 3,100
  select 1
  use &arch
  INDEX on fecha TO tt

  SELECT 2
  USE especie1
  tot=0
  totd=0
  ta=0
  SELECT 2
  GO top
  DO WHILE .not. EOF()
    a=codinidep
    b=nomcient
    rec=RECNO()
    ff=CTOD("  /  /  ")
    pie=0
    ft=0
    kg=0
    f=0
    hm=0
    x=0
    la=0
    lanc=0
    anz=0
    fg=CTOD("  /  /  ")  
    SELECT 1
    GO top
    DO WHILE .not. EOF()
      lanc=lanc+1
      IF fecha<>fg
        ft=ft+1
      ENDIF
      fg=fecha  
      FOR t=1 TO 25
        IF t<10
          es="especie_"+STR(t,1)
          ki="kg_"+STR(t,1)
          pz="descar_"+STR(t,1)
        ELSE
          es="especie_"+STR(t,2)
          ki="kg_"+STR(t,2)
          pz="descar_"+STR(t,2)
        ENDIF
        IF &es==a
          kg=kg+&ki
          pie=pie+&pz
          la=la+1
          x=1
        ENDIF
        IF x=1
          IF fecha<>ff
            f=f+1
          ENDIF
          ff=fecha
          hi=hora_inic
          hf=hora_final
          IF hf>hi
            hhh=(((INT(hi)*60)+((hi-(INT(hi)))*100)))
            yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
            hm=hm+((yyy-hhh)/60)
          ELSE
            hhh=(1440)-((INT(hi)*60)+((hi-(INT(hi)))*100))
            yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
            hm=hm+((yyy+hhh)/60)
          ENDIF
        ENDIF
        x=0
      NEXT t
      SKIP
    ENDDO
    IF la<>0 
      hm1=INT(hm)
      hm2=INT(((hm-INT(hm))*100)*60/100)
      hm3=hm1+(hm2/100)
      IF ta=0
        ? trim("Especie"),";",trim("Kilos"),";",trim("Descarte"),";",trim("Desc.%"),";",trim("Lances"),";",trim("Dias"),";",trim("Horas")
        ta=1
      ENDIF
      descart=pie/kg*100
      ? b,";",kg,";",pie,";",STR(descart,6,2),";",la,";",f,";",STR(hm3,10,2)
      tot=tot+kg
      totd=totd+pie
    ENDIF
    SELECT 2
    IF .not. EOF()
      GOTO rec  
      skip
    ENDIF
  ENDDO
  ddee=totd/tot*100
  ?
  ? "",";",tot,";",totd,";",ddee,";",lanc,";",ft
  ?
  ?
  ?
  ?
  ? "Datos de captura y esfuerzo por area"
  ?
  SELECT 1
  USE &arch
  INDEX ON (INT(lat_inic)*100+INT(long_inic)) to tt
  tot=0
  totd=0
  ta=0
  lanc=0
  fg=CTOD("  /  /  ")
  ft=0
  minn=9999
  maxx=0
  SELECT 1
  GO top
  DO WHILE .not. EOF()
    ff=CTOD("  /  /  ")
    pie=0
    kg=0
    f=0
    hm=0
    x=0
    la=0
    anz=0
    are=INT(lat_inic)*100+INT(long_inic)
    IF are<minn
      minn=are
    ENDIF
    IF are>maxx
      maxx=are
    endif  
    DO WHILE (INT(lat_inic)*100+INT(long_inic))=are
      lanc=lanc+1
      fg=fecha  
      FOR t=1 TO 25
        IF t<10
          es="especie_"+STR(t,1)
          ki="kg_"+STR(t,1)
          pz="descar_"+STR(t,1)
        ELSE
          es="especie_"+STR(t,2)
          ki="kg_"+STR(t,2)
          pz="descar_"+STR(t,2)
        ENDIF
        kg=kg+&ki
        pie=pie+&pz
        x=1
      NEXT t
      IF fecha<>ff
        f=f+1
      ENDIF
      ff=fecha
      hi=hora_inic
      hf=hora_final
      IF hf>hi
        hhh=(((INT(hi)*60)+((hi-(INT(hi)))*100)))
        yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
        hm=hm+((yyy-hhh)/60)
      ELSE
        hhh=(1440)-((INT(hi)*60)+((hi-(INT(hi)))*100))
        yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
        hm=hm+((yyy+hhh)/60)
      ENDIF
      x=0
      la=la+1
      SKIP
    enddo  
    IF la<>0 
      hm1=INT(hm)
      hm2=INT(((hm-INT(hm))*100)*60/100)
      hm3=hm1+(hm2/100)
      IF ta=0
        ? "Area",";","Kilos",";","Descarte",";","Desc%",";","Lances",";","Días",";","Horas"
        ta=1
      ENDIF
      descart=pie/kg*100
      ? are,";",kg,";",pie,";",STR(descart,6,2),";",la,";",f,";",STR(hm3,10,2)
      tot=tot+kg
      totd=totd+pie
    ENDIF  
  ENDDO
  ddee=totd/tot*100
  ?
  ? "				",tot,totd,ddee,lanc,"	"

  SET ALTERNATE off
  CLOSE all 
enddo