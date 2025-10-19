CLOSE all
set century on
*SCROLL
clear
on error do zz
clear
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES "
set color to  ("N/w*")
do while .t.
clear
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES "
set color to  ("N/w*")

  @2,35 say "MAREAS"
  set color to  ("r+/w*")
  @4,25 prompt "1- Cortar bases"
  @5,25 prompt "2- Control Dias horas Arrastrero (arrdiashoras.txt)"
  @6,25 prompt "3- Posiciones con una especie arrastreros (Arrposiciones.txt)"
  @7,25 prompt "4- Resumen produccion (produccion.txt)"
  @8,25 prompt "5- Distribución de tallas"
  @9,25 prompt "6- Distribución de tallas XXXX"
  @10,25 prompt "7- Controla archivo L"  
  @11,25 prompt "8- Largo peso" 
  @12,25 prompt "9- Reemplaza especies"
  @13,25 prompt "10- Resumen muestra/maduros"
  @14,25 prompt "11- BUSCAR CODIGO BARCO/AIP"
  @16,25 prompt "12- Salir"
  
  menu to option
  if lastkey()=27
    exit
  endif

  do case  
   case option=1
   clear
   do cortarx

   case option=2
   clear
   do OBShar
   
   case option=3
   clear
   do OBSposarr


   case option=4
   clear
   do OBSpro2

   case option=5
   clear
   do obsdist
   
   case option=6
   CLEAR
   DO obsdistx
   
   case option=7
   CLEAR
   do ctrL

   case option=8
   clear
   do OBSpm

   case option=9
   clear
   DO OBSreem

   case option=10
   clear
   do ctrLl

   case option=11
   clear
   do BUS_BAR


   case option=12
   CLEAR
   exit


  endcase
enddo


