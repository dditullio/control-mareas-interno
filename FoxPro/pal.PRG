set date to french
**use cpalmerluzanegra18
use cpal13
go top

set alternate to p13
set alternate on

do while .not. eof()
  a=marea
  l=lance
  la=lat_inic_f
  lo=long_in_f
  pr=prof_ini_f
  fe=fecha_fi
  if "CACH"$Observac .or. "Cach"$Observac .or. "cach"$Observac .or. "Lob"$Observac .or. "lob"$Observac .or. "LOB"$Observac .or. "ORCA"$Observac .or. "Orca"$Observac .or. "orca"$Observac 
    ? a,";",l,";",la,";",lo,";",pr,";",fe,";",Observac,";","1"
  else
    ? a,";",l,";",la,";",lo,";",pr,";",fe,";","",";","0"
  endif
  skip
enddo
     
set alternate off
close all