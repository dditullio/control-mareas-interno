select 1
use c5920
index on fecha to tt

select 2
use p5920

set alternate to negra
set alternate on

select 1
go top
do while .not. eof()
  f=fecha
  l=lance
  ? f,";"
  o=0
  do while fecha=f
    for t=1 to 25
      if t<10
        es="especie_"+str(t,1)
        kg="kg_"+str(t,1)
        de="descar_"+str(t,1)
      else
        es="especie_"+str(t,2)
        kg="kg_"+str(t,2)
        de="descar_"+str(t,2)
      endif
      eess=&es
      kkii=&kg
      ddee=&de 
      if &es=7218280201
        if o=0
          ? l,";"
           o=1
        endif     
        ?? kkii,";",ddee
      endif  
    next t
    skip
  enddo
  rec=recno()
  select 2
  go top
  do while .not. eof()
    if fecha=f .and. especie="Merluza negra"
      if factor<>0
        kk=kilos*factor
        ? ";",";",";",";",kk 
      endif
    endif
    skip
    skip
  enddo
  select 1
*  index on fecha to tt
*  if .not. eof()
    goto rec
*  endif
enddo    
set alternate off
close all