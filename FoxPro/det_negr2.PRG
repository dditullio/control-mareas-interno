set date to french
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
      ? fecha,";",lance,";",kkii,";",ddee
    endif  
  next t
  skip
enddo
select 2
go top
do while .not. eof()
  if especie="Merluza negra" 
    if factor<>0
        kk=kilos*factor
        ? fecha,";",kk 
    endif
  endif
  skip
enddo
set alternate off
close all