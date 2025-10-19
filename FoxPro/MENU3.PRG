set century on
clear
do while .t.
set color to  ("R/w*")
@ 0,1 say "CONTROL DE CARPETAS - PROYECTO OBSERVADORES - ARRASTREROS"
set color to  ("N/w*")

  @2,35 say "ARRASTREROS"

  @3,2 say "Controles Varios"
  @4,2 prompt "1- Control de errores"
  @5,2 prompt "2- Controla días pesca, cantidad de muestras y submuestras"
  @6,2 prompt "3- Compara Captura  - Muestras"
  @7,2 prompt "4- Compara Muestras - Submuestras"

  @9,2 say "Archivo Captura" 
  @10,2 prompt "5- TOTAL CAPTURA/ESPECIES"
  @11,2 prompt "6- Visualización captura x especie lance x lance"
  @12,2 prompt "7- Suma kgs a captura total"
  @13,2 prompt "8- Reemplazar especie"
  @14,2 prompt "9- Pone 100% descarte x especie"
  @15,2 prompt "10- Editar lance a lance x especie "
  @16,2 prompt "11- Reemplazar captura en cajones x peso x especie"
  @17,2 prompt "12- Edita lances"
  @18,2 prompt "13- Descarte en porcentaje a kilos"    
  @19,2 prompt "14- Edita archivo completo"    
  @20,2 prompt "15- Datos radiales fresqueros"    

  @5,60 SAY "Archivo producción"
  @6,60 prompt "16- Compara captura con producción x fecha"
  @7,60 prompt "17- Corrige captura - producción "
  @8,60 prompt "18- Reconstruccion de captura c/desc en cero prorrateado" 
  @9,60 prompt "19- Reconstruccion de captura c/desc en cero día x día"
  @10,60 prompt "20- Resumen Producción"
  @11,60 prompt "21- Captura -Producción"

  @13,60 SAY "Archivo muestra & Submuestra"
  @14,60 prompt "22- Detalles de Muestras"  
  @15,60 prompt "23- Control & detalles de Submuestras"  
  @16,60 prompt "24- Cantidad de ejemplareas a submuestrear"  
  @17,60 prompt "25- Pasa submuestra en gramos a kilos"  
  @18,60 prompt "26- Arregla fechas"  

  menu to option

  if lastkey()=27
    clear
    exit
  endif

  do case  
    case option=1
    clear
    do control2

    case option=2
    clear
    do diaspesca2
 
    case option=3
    clear
    do captamues
   
    case option=4
    clear
    do mue_sub


    case option=5
    clear
    do captura

    case option=6
    clear 
    do cappro

    case option=7
    clear
    do sumar

    case option=8
    clear
    do reemplaza_especie

    case option=9
    clear
    do descar

    case option=10
    clear
    do editar

    case option=11
    clear
    do editar2

    case option=12
    clear
    do editar3

    case option=13
    clear
    do pordesc

    case option=14
    clear
    do arredit

    case option=15
    clear
    do radial2

    case option=16
    clear
    do prod22

    case option=17
    clear
    do procap

    case option=18
    clear
    do reconst

    case option=19
    clear
    do reconst2

    case option=20
    clear
    do produccion

    case option=21
    clear
    do captpro
    
    case option=22
    clear
    do contm

    case option=23
    clear
    do conts

    case option=24 
    clear
    do musu

    case option=25
    clear
    do pasgrkg

    case option=26
    clear
    do camfch


  endcase
enddo
close all
set exclusive on