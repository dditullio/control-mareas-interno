close all
use DATOSLG
GO TOP
DO WHILE .NOT. EOF()
  IF CODIGO=7226030101
    A1=AM
    B1=BM
    A2=AH
    B2=BH
    A3=A
    B3=B
  ENDIF  
  SKIP
ENDDO  
PM=0
Z=3

use s1620
INDEX ON ESPECIE TO TT
GO TOP
CLEAR

DO WHILE .NOT. EOF()
  
    if sexo=1 
      pm=A1*(largo_tot**b1)
    endif
    if sexo=2 
      pm=A2*(largo_tot**b2)
    endif
    if sexo=3 
      pm=A3*(largo_tot**b3)
    endif

 

 
    REPLACE PESO_tot WITH (PM*1000)
 
  pm=0
  SKIP
ENDDO
clear
CLOSE ALL
set color to  ("b/w*")
clear