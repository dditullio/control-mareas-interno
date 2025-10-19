select 1
use especie1

select 2
use especies

set alternate to difs
set alternate on

select 1
go top
do while .not. eof()
  a=codinidep
  b=nomcient
  rec=recno()
  select 2
  go top
  do while .not. eof()
    if (codinidep=a .and. nomcient<>b)
      ? "Cambia nombre",";",a,";",b,";",codinidep,";",nomcient
    endif
    
    if (codinidep<>a .and. nomcient=b)
       ? "Cambia código",";",a,";",b,";",codinidep,";",nomcient
    endif
    skip
  enddo
  select 1
  if .not. eof()
  goto rec
  endif
  skip
enddo


?
?
?
?

select 2
go top
do while .not. eof()
  a=codinidep
  b=nomcient
  rec=recno()
  select 1
  go top
  do while .not. eof()
    if (codinidep=a .and. nomcient<>b) .or. (codinidep<>a .and. nomcient=b)
       ? a,";",b,";",codinidep,";",nomcient
    endif
    skip
  enddo
  select 2
  if .not. eof()
  goto rec
  endif
  skip
enddo

set alternate off
close all

   
