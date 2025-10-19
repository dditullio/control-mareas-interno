set century on
clear
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - PALANGREROS"
set color to  ("N/w*")
set color to  ("b/w*")
do while .t.
clear
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - PALANGREROS"
set color to  ("b/w*")
  @2,2 say "Controles Varios"
  @3,2 prompt "1- Control de errores"
  @4,2 prompt "2- Controla días pesca, cantidad de muestras y submuestras"
  @5,2 prompt "3- Compara Captura  - Muestras"
  @6,2 prompt "4- Compara Muestras - Submuestras"
  @7,2 prompt "5- Cuenta lances marea"
  @9,2 say "Archivo Captura" 
  @10,2 prompt "6- TOTAL CAPTURA/ESPECIES"
  @11,2 prompt "7- Visualización captura x especie lance x lance"
  @12,2 prompt "8- Reemplazar especie"
  @13,2 prompt "9- Editar lance a lance x especie "
  @14,2 prompt "10- Reemplazar captura en cajones x peso x especie"
  @15,2 prompt "11- Edita lances"
  @17,2 SAY "Archivo producción"
  @18,2 prompt "12- Compara captura con producción x fecha"
  @19,2 prompt "13- Corrige captura - producción "
  @20,2 prompt "14- Reconstruccion de captura a partir produccion c/desc en cero" 
  @21,2 prompt "15- Resumen Producción"
  @2,40 SAY "Archivo muestra & Submuestra"
  @3,40 prompt "16- Detalles de Muestras"  
  @4,40 prompt "17- Detalles de Submuestras"  
  @5,40 prompt "18- Cantidad de ejemplares a submuestrear"
  @6,40 prompt "19- Pasa submuestras de gramos a kilos"
  menu to option
  if lastkey()=27
    clear
    exit
  endif

  do case  
   case option=1
   clear
   do palctrl2

   case option=2
   clear
   do paldias

   case option=3
   clear
   do palcamu
   
   case option=4
   clear
   do palmusu

   case option=5
   clear
   do contlanmar

   case option=6
   clear
   do palcaptu

   case option=7
   clear 
   do palcappro


   case option=8
   clear
   do palreemp


   case option=9
   clear
   do paled1

   case option=10
   clear
   do paled2

   case option=11
   clear
   do paled3

   case option=12
   clear
   do palprod

   case option=13
   clear
   do palprocap

   case option=14
   clear
   do palrec

   case option=15
   clear
   do palproduc

 case option=16
   clear
   do palcontm

 case option=17
   clear
   do palconts

 case option=18
   clear
   do qtysub

 case option=19
   clear
   do pasgrkg

  endcase
enddo
close all
set exclusive on