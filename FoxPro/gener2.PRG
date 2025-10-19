
nr=0

DIMENSION CA(500,3)
FOR Y=1 TO 500
  FOR U=1 TO 3
    CA(Y,U)=0
  ENDFOR
ENDFOR

*espe=7226030101
*nc="Genypterus blacodes"
*nv="Abadejo"
espe=7218280201
nc="Dissostichus eleginoides"
nv="Merluza negra"

USE m exclusive
ZAP

close all

select 1
use s1521

select 2
use m
*index on palnromue to tt

select 4
use submm exclusive
zap


*select 2
*go top
*do while .not. eof()
*  nr=palnromue
*  skip
*enddo

select 1
go top
pes=0
do while .not. eof()
  zx=0
  if especie=nc .or. especie=nv
    b=barco
    l=lance
    f=fecha
    m=marea
    ar=area
    lt=0
    pes=0
    ls=largo_tot
    li=largo_tot
    do while lance=l .and. (especie=nc .or. especie=nv)
      if largo_tot>ls
        ls=largo_tot
      endif
      if largo_tot<li
        li=largo_tot
      endif    
      if largo_tot<>0
        lt=largo_tot
        ar=area
        pes=pes+(peso_tot/1000)
        se=sexo
        if se=1
          a=ca(largo_tot,1)+1
          Ca(largo_tot,1)=a
        endif
        if se=2
          a2=ca(largo_tot,2)+1
          Ca(largo_tot,2)=a2
        endif
        if se=3
          a3=ca(largo_tot,3)+1
          Ca(largo_tot,3)=a3
        endif
      endif
      skip
    enddo 
    
 *   set alternate to resum
 *   set alternate on
    FOR Y=1 TO 500
      FOR U=1 TO 3
        if CA(Y,U)<>0
       *   ? Y,"	",u,"	",ca(y,u)
        endif
      ENDFOR
    ENDFOR
  *  set alternate off

     
    rec=recno()
    select 2
    append blank
    nr=nr+1
    replace lance with l, cod_espec with espe, especie with nc, prim_talla with li, ult_talla with ls 
    replace peso_mues with pes, barco with b, marea with m, fecha with f, area with ar, intervalo WITH 1, fact_pond WITH 1
    pes=0
    v=1
    if ls<>0
    for z=li to ls
      for x=1 to 90
        if x<10
         ta="talla_"+str(x,1)
        endif
        if x>=10 .and. x<100
          ta="talla_"+str(x,2)
        endif
        if x>=100
          ta="talla_"+str(x,3)
        endif
        if &ta=0 .and. z<>0
          vv=ca(z,1)
          pp=ca(z,2)
          inin=ca(z,3)
          tt=vv+pp+inin
          IF VV<10
            RV="00"+STR(vv,1)
          ENDIF
          IF VV>9 .AND. VV<100
            RV="0"+STR(VV,2)
          ENDIF
          IF VV>99
            RV=STR(VV,3)
          ENDIF
          IF VV=0
            RV="000"
          ENDIF
          IF pp<10
            Rp="00"+STR(pp,1)
          ENDIF
          IF pp>9 .AND. pp<100
            Rp="0"+STR(pp,2)
          ENDIF
          IF pp>99
            Rp=STR(pp,3)
          ENDIF
          IF pp=0
            Rp="000"
          ENDIF
          IF inin<10
            Ri="00"+STR(inin,1)
          ENDIF
          IF inin>9 .AND. inin<100
            Ri="0"+STR(inin,2)
          ENDIF
          IF inin>99
            Ri=STR(inin,3)
          ENDIF
          IF inin=0
            Ri="000"
          ENDIF
          IF tt<10
            Rt="00"+STR(tt,1)
          ENDIF
          IF tt>9 .AND. tt<100
            Rt="0"+STR(tt,2)
          ENDIF
          IF tt>99
            Rt=STR(tt,3)
          ENDIF
          IF tt=0
            Rt="000"
          ENDIF
          R1=STR(z,3)+RV
          R2=R1+RP
          R3=R2+RI 
          R4=R3+rt 
          replace &ta with int(VAL(R4))
          x=180
        endif
      next x
    next z
    select 4
    FOR Y=1 TO 500
      if CA(Y,1)<>0 .or. ca(y,2)<>0 .or. ca(y,3)<>0
        append blank
        replace lance with l,largo with y, ma with ca(y,1), he with ca(y,2), ind with ca(y,3)
      endif  
    ENDFOR  
    FOR Y=1 TO 500
      FOR U=1 TO 3
        CA(Y,U)=0
      ENDFOR
    ENDFOR
    zx=1
    endif
    select 1
    if .not. eof()
      goto rec
    endif
  endif
  if zx=0 .and. .not. eof()
    skip  
  endif  
enddo

close all
set color to  ("b/w*")
clear