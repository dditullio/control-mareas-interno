set century on
*SCROLL
clear
on error do zz
clear
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES "
set color to  ("N/w*")
do while .t.
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES "
set color to  ("N/w*")

  @3,35 say "MAREAS"
  set color to  ("b/w*")
  @5,25 prompt "1- Arrastrero"
  set color to  ("R/w*")
  @6,25 prompt "2- Palangrero"
  set color to  ("N/w*")
  @8,25 prompt "3- Buscar especie x código"
  @9,25 prompt "4- Buscar especie x nombre"
  @11,25 prompt "5- Largo peso muestra"
  @12,25 prompt "6- Largo peso submuestra"
  @14,25 prompt "7- Salir"
  
  menu to option
  if lastkey()=27
    exit
  endif

  do case  
   case option=1
   clear
   do menu3
   
   case option=2
   clear
   do palmenu


   case option=3
   clear
   do busesp

   case option=4
   clear
   do busesp2

   case option=5
   clear
   do largopm

   case option=6
   clear
   do largops

   case option=7
   clear
   exit


  endcase
enddo


procedure zz
@ 0,0 CLEAR
@12,25 SAY "Error de procesamiento. Estadio no considerado. -aguarde"
for t=1 to 10000000
next t
quit
clear
