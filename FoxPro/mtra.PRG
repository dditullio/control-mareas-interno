use m8120
go top

set alternate to mtra8120
set alternate on
esp=5139030101

dimension ma(100), he(100), it(100)

for y=1 to 100
  ma(y)=0
  he(y)=0
  it(y)=0
next y  

do while .not. eof()
  if cod_espec=esp
    a=lance
    for t=1 to 90
      if t<10
        ta="talla_"+str(t,1)
      else
        ta="talla_"+str(t,2)
      Endif
      tal=str(&ta,15)
      tall=substr(tal,1,3)
      talla=val(tall)
      macho=substr(tal,4,3)
      hembra=substr(tal,7,3)
      idet=substr(tal,10,3)
      if val(macho)<>0
        ma(talla)=ma(talla)+val(macho)
      endif
      if val(hembra)<>0
      he(talla)=he(talla)+val(hembra)
      endif
      if val(idet)<>0
      it(talla)=it(talla)+val(idet)
      endif
    next t
  endif
  skip
enddo
for m=1 to 100
  if ma(m)<>0 .or. he(m)<>0 .or. it(m)<>0
    ? m,";",ma(m),";",he(m),";",it(m)
  endif
next m
set alternate off
close all
     