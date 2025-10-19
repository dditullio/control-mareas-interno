set separator to "."
set point to ","
use c8120
go top
set alternate to 81_20
set alternate on

do while .not. eof()
  ? lance,";",lat_inic,";",long_inic,";"
  a1=hora_inic
  a2=hora_final
  a1m=(int(a1)*60)+((a1-int(a1))*100)
  a2m=(int(a2)*60)+((a2-int(a2))*100)
  mi=(a2m-a1m)/60
  for t=1 to 25
    if t<10
      es="especie_"+str(t,1)
      ki="kg_"+str(t,1)
    else
      es="especie_"+str(t,2)    
      ki="kg_"+str(t,2)
    endif 
    if &es=5139030101
      cpue=&ki/mi
      ?? &ki,";",cpue
    endif
  next t
  skip
enddo
set alternate off
close all
    