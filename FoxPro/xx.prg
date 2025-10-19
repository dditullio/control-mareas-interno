select 1
use especies
select 2
use myam06

set alternate to tx
set alternate on
select myam06
go top
do while .not. eof()
  a=cod_espec
  b=especie
  l=lance
  z=0
  c=recno()
  select especies
  go top
  do while .not. eof()
    if codinidep=a
      d=nomvulcas
      z=1
      exit
    endif
    skip
  enddo
  ? l,"	",b,"	",d
  select myam06
  goto c
  if .not. eof()
    skip
  endif
enddo
set alternate off
close all