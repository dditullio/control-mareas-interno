close all
CLEAR
set color to  ("R/w*")
@ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Control Maduros"
@ 1,1 to 15,130
set color to  ("B/w*")
set safety off
set exclusive off
#INCLUDE 'FILEIO.CH'
do while .t.
  ARCH=SPACE(12)
  ARCH2=SPACE(12)
  @3,2 SAY "   ARCHIVO MUESTRA :" GET ARCH
  @4,2 SAY "           MADUROS :" GET ARCH2
  READ
  if arch=space(12)
    set color to  ("b/w*")
    clear
    exit
  endif
  capt=trim(arch)+".dbf"
  capt2=trim(arch2)+".dbf"
  if file(capt)=.t. .AND. (file(capt2)=.t. .or. capt2=".dbf") 
    exit
  endif  
  if file(capt)<>.t. .OR. file(capt2)<>.t. 
    @ 8,2 say "No existe ese archivo ... verifique"
    for y=1 to 1000000
    endfor
    clear
    set color to  ("R/w*")
    @ 0,2 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - Control Maduros"
    @ 1,1 to 15,130
    set color to  ("b/w*")    
    loop
  endif
enddo
@ 2,117 say arch
select 2
use &arch
select 1
use &arch2



SET ALTERNATE to mue_mad
SET ALTERNATE on

dimension gal(90,2), gol(70,3)

FOR py=1 TO 90
  gal(py,1)=0
  gal(py,2)=0
NEXT py
FOR py=1 TO 70
  gol(py,1)=0
  gol(py,2)=0
  gol(py,3)=0
NEXT py

x=0
SELECT 2
GO top
DO WHILE .not. EOF()
  a=marea
  b=lance
  IF cod_espec=5139030101
    FOR t=1 TO 90
      IF t<10
        tu="talla_"+STR(t,1)
      ELSE
        tu="talla_"+STR(t,2)
      ENDIF
      IF &tu<>0
        s=1
        tuuu=str(&tu,15)
        tulla=substr(tuuu,1,3)
        ttuu=val(tulla)
        tumac=substr(tuuu,4,3)
        tuhem=substr(tuuu,7,3)
        tuind=substr(tuuu,10,3)
        gal(ttuu,1)=val(tumac)
        gal(ttuu,2)=val(tuhem)
*        ? b,";",a,";",ttuu,";",tulla,";",gal(ttuu,1),";",gal(ttuu,2)        
      endif 
    NEXT t
    rec=RECNO()
    SELECT 1
    GO top
    DO WHILE .not. EOF()
      IF marea=a .and. lance=b
        FOR t=1 TO 70
          if t<10
            ta="talla_"+str(t,1)
          else
            ta="talla_"+str(t,2)
          endif
          if &ta<>0

            if &ta<1000
              tthi=str(&ta,3)
              gol(t,3)=val(tthi)
            endif
            if &ta>=1000 .and. &ta<1000000
              ttm1=str(&ta,6)
              tthm=substr(ttm1,1,3)
              tthi=substr(ttm1,4,3)
              gol(t,2)=val(tthm)
              gol(t,3)=val(tthi)
            endif
            if &ta>=1000000
              ttm1=str(&ta,9)
              ttmm=substr(ttm1,1,3)
              tthm=substr(ttm1,4,3)
              tthi=substr(ttm1,7,3)
              gol(t,1)=val(ttmm)
              gol(t,2)=val(tthm)
              gol(t,3)=val(tthi)
            endif
*            ? b,";",a,";",t,";",&ta,";",gol(t,1),";",gol(t,2),";",gol(t,3)
          endif     
        NEXT t
      endif 
      SKIP
    ENDDO
    FOR y=1 TO 70
*      IF (gal(y,1)<gol(y,1)) .or. (gal(y,2)<gol(y,2)) .and. (gal(y,1)<>0 .and. gol(y,1)<>0)
        IF x=0
          ? "Marea",";","Lance",";","Talla",";","Mue Machos",";","Mue Hembra",";","L Mac Mad",";","L Hemb Mad",";","L Hemb Imp"
          x=1
        endif
        ? a,";",b,";",y,";",gal(y,1),";",gal(y,2),";",gol(y,1),";",gol(y,2),";",gol(y,3)
*      ENDIF
    NEXT y
    FOR py=1 TO 90
      gal(py,1)=0
      gal(py,2)=0
    NEXT py
    FOR py=1 TO 70
      gol(py,1)=0
      gol(py,2)=0
      gol(py,3)=0
    NEXT py
    SELECT 2
    IF .not. EOF()
      GOTO rec
    ENDIF
  endif  
  skip
ENDDO

SET ALTERNATE off
close all
*
*SET ALTERNATE to mad
*SET ALTERNATE on
*
*FOR py=1 TO 90
*  gal(py,1)=0
*  gal(py,2)=0
*NEXT py
*FOR py=1 TO 70
*  gol(py,1)=0
*  gol(py,2)=0
*  gol(py,3)=0
*NEXT py
*
*x=0
*SELECT 2
*GO top
*DO WHILE .not. EOF()
*  a=marea
*  b=lance
*  IF cod_espec=5139030101
*    FOR t=1 TO 90
*      IF t<10
*        tu="talla_"+STR(t,1)
*      ELSE
*        tu="talla_"+STR(t,2)
*      ENDIF
*      IF &tu<>0
*        s=1
*        tulla=INT(&tu/1000000000000)
*        tumac=INT(((&tu/100000000000)-INT(&tu/100000000000))*100)
*        tuhem=INT(((&tu/100000000)-INT(&tu/100000000))*100)
*        tuind=INT(((&tu/100000)-INT(&tu/100000))*100)
**        ? a,";",b,";",tulla
*        gal(tulla,1)=tumac
*        gal(tulla,2)=tuhem
*      endif 
*    NEXT t
*    rec=RECNO()
*    SELECT 1
*    GO top
*    DO WHILE .not. EOF()
*      IF marea=a .and. lance=b
*        FOR t=1 TO 70
*          if t<10
*            ta="talla_"+str(t,1)
*          else
*            ta="talla_"+str(t,2)
*          endif
*          if &ta<>0
*            ttmm1=(&ta/1000000)
*            ttmm=int(&ta/1000000)
*            n1=(ttmm1-ttmm)*1000
*            tthm=int(n1)
*            tthi1=(n1-tthm)*1000
*            tthi=int((tthi1))
*            gol(t,1)=ttmm
*            gol(t,2)=tthm
*            gol(t,3)=tthi
*          endif     
*        NEXT t
*      endif 
*      SKIP
*    ENDDO
*    FOR y=1 TO 70
*        IF x=0
*          ? "Marea",";","Lance",";","Talla",";","Mue Machos",";","Mue Hembra",";","L Mac Mad",";","L Hemb Mad",";","L Hemb Imp"
*          x=1
*        endif
*        if gal(y,1)<>0 .or. gal(y,2)<>0 .or. gol(y,1)<>0 .or. gol(y,2)<>0 .or.  gol(y,3)<>0 
*        ? a,";",b,";",y,";",gal(y,1),";",gal(y,2),";",gol(y,1),";",gol(y,2),";",gol(y,3)
*        endif
*    NEXT y
*    FOR py=1 TO 90
*      gal(py,1)=0
*      gal(py,2)=0
*    NEXT py
*    FOR py=1 TO 70
*      gol(py,1)=0
*      gol(py,2)=0
*      gol(py,3)=0
*    NEXT py
*    SELECT 2
*    IF .not. EOF()
*      GOTO rec
*    ENDIF
*  endif  
*  skip
*ENDDO

*SET ALTERNATE off
*CLOSE all