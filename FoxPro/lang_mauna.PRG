use clan19
go top
k=0
l=0
set alternate to ceci19
set alternate on
bu=""
do while .not. eof()
  a=marea
  b=lance
  bu=barco
  la=lat_inic
  lo=long_inic
  pr=prof_inic
  fe=fecha
  for t=1 to 25
    if t<10
      es="especie_"+str(t,1)
      ki="kg_"+str(t,1)
    else
      es="especie_"+str(t,2)
      ki="kg_"+str(t,2)  
    endif
    if &es=5139440101
      k=k+&ki
      l=l+1
      kl=&ki
      ? bu,";",a,";",b,";",la,";",lo,";",fe,";",pr,";",kl
      kl=0
    endif    
  next t
  skip
  if bu<>barco
    ? bu,";"
    if k<>0
      ?? l,";",k
      ?
      ?
      k=0
      l=0
    endif  
  endif  
enddo
set alternate off