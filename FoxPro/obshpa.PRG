close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Especies días y horas"
*@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
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
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Especies días y horas"
 *   @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo

SET ALTERNATE TO Paldiashoras
SET ALTERNATE on

@ 2,117 say arch
@ 3,1 clear to 3,100
select 1
use &arch
INDEX on fecha_vi TO tt

SELECT 2
USE especie1
tot=0
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
    IF fecha_vi<>fg
      ft=ft+1
    ENDIF
    fg=fecha_vi  
    FOR t=1 TO 10
      IF t<10
        es="especie_"+STR(t,1)
        ki="kg_"+STR(t,1)
        pz="pieza_"+STR(t,1)
      ELSE
        es="especie_"+STR(t,2)
        ki="kg_"+STR(t,2)
        pz="pieza_"+STR(t,2)
      ENDIF
      IF &es=a
        kg=kg+&ki
        pie=pie+&pz
        anz=anz+anz_ntotal
        la=la+1
        x=1
      ENDIF
      IF x=1
        IF fecha_vi<>ff
          f=f+1
        ENDIF
        ff=fecha_vi
        fi=fecha_fi
        hi=hora_ini_f
        hf=hora_ini_v
        IF ff=fi
          hhh=(((INT(hi)*60)+((hi-(INT(hi)))*100)))
          yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
          hm=hm+((yyy-hhh)/60)
        ELSE
          dd=ff-fi
          hhh=(1440*dd)-((INT(hi)*60)+((hi-(INT(hi)))*100))
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
    
    anztot=1000*kg/anz
    anztot2=1000*pie/anz
    IF ta=0
      ? "                                                                                                                                      Captura       Piezas"
      ? "Especie	                            Kilos         Piezas        Lances        Días      Horas        mls anz.     mls anz"
      ta=1
    ENDIF
    ? left(b,28),kg,pie,la,f,STR(hm3,10,2),"  ",STR(anztot,8,2),"  ",STR(anztot2,6,1)
    tot=tot+kg
  ENDIF
  SELECT 2
  IF .not. EOF()
    GOTO rec  
    skip
  ENDIF
ENDDO
?
? "                                 ",tot,"            ",lanc,"	",ft
?
?
?
?
? "Resúmen por área"
?

SELECT 1
USE &arch
INDEX ON(INT(lat_inic_v)*100+INT(long_in_v)) to tt

tot=0
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
  are=INT(lat_inic_v)*100+INT(long_in_v)
  IF are<minn
    minn=are
  ENDIF
  IF are>maxx
    maxx=are
  endif  
  DO WHILE (INT(lat_inic_v)*100+INT(long_in_v))=are
    lanc=lanc+1
    fg=fecha_vi  
    FOR t=1 TO 10
      IF t<10
        es="especie_"+STR(t,1)
        ki="kg_"+STR(t,1)
        pz="pieza_"+STR(t,1)
      ELSE
        es="especie_"+STR(t,2)
        ki="kg_"+STR(t,2)
        pz="pieza_"+STR(t,2)
      ENDIF
      kg=kg+&ki
      pie=pie+&pz
      x=1
    NEXT t
    IF fecha_vi<>ff
      f=f+1
    ENDIF
    ff=fecha_vi
    fi=fecha_fi
    hi=hora_ini_f
    hf=hora_ini_v
    IF ff=fi
      hhh=(((INT(hi)*60)+((hi-(INT(hi)))*100)))
      yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
      hm=hm+((yyy-hhh)/60)
    ELSE
      dd=ff-fi
      hhh=(1440*dd)-((INT(hi)*60)+((hi-(INT(hi)))*100))
      yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
      hm=hm+((yyy+hhh)/60)
    ENDIF
    x=0
    anz=anz+anz_ntotal
    la=la+1
    SKIP
  enddo  
  IF la<>0 
    hm1=INT(hm)
    hm2=INT(((hm-INT(hm))*100)*60/100)
    hm3=hm1+(hm2/100)

    anztot=1000*kg/anz
    anztot2=1000*pie/anz
    IF ta=0
      ? "                                                                                                                                      Captura       Piezas"
      ? "Area   	                            Kilos         Piezas        Lances        Días      Horas        mls anz.     mls anz"
      ta=1
    ENDIF
    ? STR(are,28),kg,pie,la,f,STR(hm3,10,2),"  ",STR(anztot,10,2),"  ",STR(anztot2,6,1)
    tot=tot+kg
  ENDIF  
enddo
?
? "				",tot,"			 ",lanc,"	"
?
?
?
? "Resúmenes x especie x área"

m=minn
DO WHILE m<=maxx
  fc=CTOD("  /  /  ")
  la=0
  fn=0
  ta=0
  w=0
  SELECT 1
  GO top
  DO WHILE .not. EOF()
    IF (INT(lat_inic_v)*100+INT(long_in_v))=m
       w=1
       EXIT
    ENDIF
    SKIP
  ENDDO
  IF w=1  
    w=0
    SELECT 2 
    GO top
    DO WHILE .not. EOF()
      a=nomcient
      b=nomvulcas
      cod=codinidep
      ft=0
      l=0
      hm=0
      kg=0
      pie=0
      anz=0
      fg=CTOD("  /  /  ")
      rec=RECNO()
      SELECT 1
      GO top
      DO WHILE .not. EOF()
        IF (INT(lat_inic_v)*100+INT(long_in_v))=m
          la=la+1
          IF fecha_vi<>fc
            fn=fn+1
          ENDIF
          fc=fecha_vi
          FOR t=1 TO 10
            IF t<10
             es="especie_"+STR(t,1)
              ki="kg_"+STR(t,1)
              pz="pieza_"+STR(t,1)
            ELSE
              es="especie_"+STR(t,2)
              ki="kg_"+STR(t,2)
              pz="pieza_"+STR(t,2)
            ENDIF
            IF &es=cod
              kg=kg+&ki
              pie=pie+&pz
              x=1
           ENDIF  
          NEXT t
          IF x=1
            l=l+1
            IF fecha_vi<>fg
              ft=ft+1
            ENDIF
            fg=fecha_vi 
            ff=fecha_vi
            fi=fecha_fi
            hi=hora_ini_f
            hf=hora_ini_v
            IF ff=fi
              hhh=(((INT(hi)*60)+((hi-(INT(hi)))*100)))
              yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
              hm=hm+((yyy-hhh)/60)
            ELSE
              dd=ff-fi
              hhh=(1440*dd)-((INT(hi)*60)+((hi-(INT(hi)))*100))
              yyy=(((INT(hf)*60)+((hf-(INT(hf)))*100)))
              hm=hm+((yyy+hhh)/60)
            ENDIF
            x=0
            anz=anz+anz_ntotal
          ENDIF
        ENDIF
        SKIP
      ENDDO
      IF l<>0 
        hm1=INT(hm)
        hm2=INT(((hm-INT(hm))*100)*60/100)
        hm3=hm1+(hm2/100)
        anztot=1000*kg/anz
        anztot2=1000*pie/anz
        IF ta=0
          ? "Area: ",m
          ? "                                                                                                                                      Captura       Piezas"
          ? "Especie	                            Kilos         Piezas        Lances        Días      Horas        mls anz.     mls anz"
          ta=1
        ENDIF
        ? LEFT(a,28),kg,pie,l,ft,STR(hm3,10,2),"  ",STR(anztot,10,2),"  ",STR(anztot2,6,1)
        tot=tot+kg
      ENDIF  
      SELECT 2
*    IF .not. EOF()
        GOTO rec
        SKIP
*    endif  
    enddo      
    IF l<>0
      ?
      ? "				",tot,"			 ",la,"	",fn
      l=0
    ENDIF
  endif  
  m=m+1  
enddo
SET ALTERNATE off
CLOSE all 
