set alternate to truchos
set alternate on

dimension can(150), nac(150)
for g=1 to 150
  can(g)=0
  nac(g)=0
next g 
z=0 
use mmm
index on prim_talla to tt
go top
do while .not. eof()
  ? recno()
  z=z+1
  a=prim_talla
  b=ult_talla
  c=marea
  d=lance
  valo=0
  cant=0
  e=cod_espec
  for u=1 to 90
    if u<10
      ta="talla_"+str(u,1)
    else
      ta="talla_"+str(u,2)
    Endif
    if &ta<>0
      tt=str(&ta,15)
      talla1=val(substr(tt,1,3))
      valo=val(right(tt,3))
      can(talla1)=valo
      cant=cant+valo
    else
      u=90  
    endif  
  next u  
  rec=recno()
  skip
  x=0
  do while prim_talla=a
    if ult_talla=b
      canti=0
      for u=1 to 90
        if u<10
          ta="talla_"+str(u,1)
        else
          ta="talla_"+str(u,2)
        Endif
        if &ta<>0
          tt1=str(&ta)
          talla2=val(substr(tt1,1,3))        
          vala=val(right(tt1,3))
          nac(talla2)=vala
          canti=canti+vala
        else
          u=90
        endif  
      next u  
      for g=1 to 150
        if can(g)<>nac(g)
          x=1
        endif  
      next g    
      if x=0
        ? c,";",d,";",e,";",marea,";",lance,";",cod_espec
      endif
      x=0
    endif    
    skip
  enddo
  goto rec
  skip
enddo
?
? z
set alternate off
close all