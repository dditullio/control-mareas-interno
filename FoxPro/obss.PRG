select 1
use fresquer
index on fecha to tt


select 1
go top

set alternate to mm
set alternate on


f=ctod("01/01/2000")
l=0
do while .not. eof()
  a=int(area)
  x=0
  rec=recno()
  go top
  do while .not. eof()
    if int(area)=a .and. fecha<>f
      x=x+1
      f=fecha
    endif
    skip
  enddo
  ? a,";",x
  goto rec
  skip
enddo
set alternate off
close all
    
    
    
  