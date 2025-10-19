set date to french
use p8120
f=ctod("01/06/20")
x=1
fe=1
do while fe<73
append blank
fe=fe+1
replace barco with "JOSE AMERICO", marea with 81, fecha with f, especie with "Langostinos"
if x=1
  replace Producto with "ENTERO", categoria with "L1", factor with 1
endif  
if x=2
  replace Producto with "ENTERO", categoria with "L2", factor with 1
endif  
if x=3
  replace Producto with "ENTERO", categoria with "C1", factor with 2
endif  
if x=4
  replace Producto with "ENTERO", categoria with "CR", factor with 2
endif  
x=x+1
if x=5
  f=f+1
  x=1
endif  
enddo
close all
