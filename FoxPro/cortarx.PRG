CLOSE all
SET DATE french

L=0
CLEAR
DO WHILE .t.
  CLOSE all
  m=SPACE(3)
  eta=SPACE(2)
  a=SPACE(2)
  sn=SPACE(2)

  @ 2,1 SAY "Marea: " get m
  @ 3,1 SAY "año  : " get a
  @ 4,1 say "Etapas: " get eta
  @ 5,1 say "Muestras de descarte? : " get sn
  READ
  mar=VAL(m)
  ate=INT(VAL(TRIM(eta)))
  ano=VAL(a)
  
  IF mar=0 .or. ano=0
    EXIT
  ENDIF
  
  IF (sn<>"s" .and. sn<>"S" .and. sn<>"n" .and. sn<>"N") .or. ate<1 .or. mar=0 .or. ano<20
    LOOP
  endif   

  DIMENSION t(15,2)
  FOR y=1 TO 15
    t(y,1)=CTOD("  /  /  ")
    t(y,2)=CTOD("  /  /  ")
  NEXT y  

  v=1
  x=7
  DO WHILE v<=ate
    des=CTOD("  /  /  ")
    has=CTOD("  /  /  ")
    @ x,1 say "Desde: " get des
    @ x,30 say "Hasta: " get has
    READ
    IF des>=CTOD("01/01/20") .and. has<=CTOD("12/12/25") .and. has>=des
      x=x+1
      t(v,1)=(des)
      t(v,2)=(has)
      v=v+1
    Endif  
  ENDDO
  yn=SPACE(1)
  @ 20,1 say "Confirma datos (S/N)? " get yn 
  READ
  IF yn<>"s" .AND. yn<>"S"
    LOOP
  endif

   
  a1=t(1,1)
  a2=t(1,2)
  b1=t(2,1)
  b2=t(2,2)
  c1=t(3,1)
  c2=t(3,2)      
  d1=t(4,1)
  d2=t(4,2)
  e1=t(5,1)
  e2=t(5,2)
  f1=t(6,1)
  f2=t(6,2) 
  g1=t(7,1)
  g2=t(7,2)
  h1=t(8,1)
  h2=t(8,2)
  i1=t(9,1)
  i2=t(9,2)
  j1=t(10,1)
  j2=t(10,2)
    
  xc=TRIM("c")+TRIM(m)+TRIM(a)
  xm=TRIM("m")+TRIM(m)+TRIM(a)
  xmd=TRIM("md")+TRIM(m)+TRIM(a)
  xp=TRIM("p")+TRIM(m)+TRIM(a)
    
  viajec=TRIM(xc)+".dbf"
  viajem=TRIM(xm)+".dbf"
  viajemd=TRIM(xmd)+".dbf"
  viajep=TRIM(xp)+".dbf"
 
 
  
 IF sn="s" .or. sn="S"
   if file(viajec)<>.t. .OR. file(viajem)<>.t. .OR. file(viajemd)<>.t. .OR. file(viajep)<>.t.
     @ 10,2 say "No existe ese archivo ... verifique"
     for y=1 to 1000000
     endfor
     LOOP
   endif
 endif

 IF sn="n" .or. sn="N"
   if file(viajec)<>.t. .OR. file(viajem)<>.t. .OR. file(viajep)<>.t.
     @ 10,2 say "No existe ese archivo ... verifique"
     for y=1 to 1000000
     endfor
     LOOP
   endif
  endif

  xca=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("a")
  xcb=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("b")
  xcc=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("c")
  xcd=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("d")
  xce=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("e")
  xcf=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("f")
  xcg=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("g")
  xch=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("h")
  xci=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("i")
  xcj=TRIM("c")+TRIM(m)+TRIM(a)+TRIM("j")
  
  xma=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("a")
  xmb=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("b")
  xmc=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("c")
  xmd=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("d")
  xme=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("e")
  xmf=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("f")
  xmg=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("g")
  xmh=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("h")
  xmi=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("i")
  xmj=TRIM("m")+TRIM(m)+TRIM(a)+TRIM("j")
  
  xmda=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("a")
  xmdb=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("b")
  xmdc=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("c")
  xmdd=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("d")
  xmde=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("e")
  xmdf=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("f")
  xmdg=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("g")
  xmdh=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("h")
  xmdi=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("i")
  xmdj=TRIM("md")+TRIM(m)+TRIM(a)+TRIM("j")

  xpa=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("a")
  xpb=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("b")
  xpc=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("c")
  xpd=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("d")
  xpe=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("e")
  xpf=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("f")
  xpg=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("g")
  xph=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("h")
  xpi=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("i")
  xpj=TRIM("p")+TRIM(m)+TRIM(a)+TRIM("j")

  IF ate=2
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1)
      PACK
             close all
    ENDIF
  endif
    CLOSE all

  IF ate=3
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *c
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1)
      PACK
             close all
    ENDIF
  ENDIF
      CLOSE all

  *4
  IF ate=4
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1)
      PACK
             close all
    ENDIF
  endif
    CLOSE all

  *5
   IF ate=5
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1)
      PACK
             close all
    ENDIF
  ENDIF
      CLOSE all
  
  *6
   IF ate=6
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *F
    vec=TRIM(xcf)+".dbf"
    vem=TRIM(xmf)+".dbf"
    vep=TRIM(xpf)+".dbf"
    vemd=TRIM(xmdf)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(f1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(f1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(f1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(f1)
      PACK
             close all
    ENDIF
  Endif
    CLOSE all
    
  *7
   IF ate=7
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
      PACK
             close all
    ENDIF
      CLOSE all
  
    *f
    vec=TRIM(xcf)+".dbf"
    vem=TRIM(xmf)+".dbf"
    vep=TRIM(xpf)+".dbf"
    vemd=TRIM(xmdf)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
      PACK
             close all
    ENDIF
      CLOSE all
  
    *g
    vec=TRIM(xcg)+".dbf"
    vem=TRIM(xmg)+".dbf"
    vep=TRIM(xpg)+".dbf"
    vemd=TRIM(xmdg)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(g1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(g1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(g1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(g1)
      PACK
             close all
    ENDIF
  Endif
    CLOSE all

 *8
   IF ate=8
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      PACK
             close all
    ENDIF
        CLOSE all
    
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *f
    vec=TRIM(xcf)+".dbf"
    vem=TRIM(xmf)+".dbf"
    vep=TRIM(xpf)+".dbf"
    vemd=TRIM(xmdf)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
      PACK
             close all
    ENDIF
      CLOSE all
  
    *g
    vec=TRIM(xcg)+".dbf"
    vem=TRIM(xmg)+".dbf"
    vep=TRIM(xpg)+".dbf"
    vemd=TRIM(xmdg)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *h
    vec=TRIM(xch)+".dbf"
    vem=TRIM(xmh)+".dbf"
    vep=TRIM(xph)+".dbf"
    vemd=TRIM(xmdh)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(h1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(h1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(h1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(h1)
      PACK
             close all
    ENDIF
  Endif

  CLOSE all

 *9
   IF ate=9
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
      PACK
             close all
    ENDIF
    CLOSE all
    
    *f
    vec=TRIM(xcf)+".dbf"
    vem=TRIM(xmf)+".dbf"
    vep=TRIM(xpf)+".dbf"
    vemd=TRIM(xmdf)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
      PACK
             close all
    ENDIF
    CLOSE all
      
    *g
    vec=TRIM(xcg)+".dbf"
    vem=TRIM(xmg)+".dbf"
    vep=TRIM(xpg)+".dbf"
    vemd=TRIM(xmdg)+".dbf"
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
      PACK
             close all
    ENDIF
    CLOSE all
    
    *h
    vec=TRIM(xch)+".dbf"
    vem=TRIM(xmh)+".dbf"
    vep=TRIM(xph)+".dbf"
    vemd=TRIM(xmdh)+".dbf"
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
      PACK
             close all
    ENDIF
  CLOSE all
  
    *i
    vec=TRIM(xci)+".dbf"
    vem=TRIM(xmi)+".dbf"
    vep=TRIM(xpi)+".dbf"
    vemd=TRIM(xmdi)+".dbf"
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(i1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(i1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(i1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(i1)
      PACK
             close all
    ENDIF
  Endif
      CLOSE all
  
  
 *10
   IF ate=10
    *a
    vec=TRIM(xca)+".dbf"
    vem=TRIM(xma)+".dbf"
    vep=TRIM(xpa)+".dbf"
    vemd=TRIM(xmda)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha>(a2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha>(a2)
      PACK
             close all
    ENDIF
    CLOSE all

    *b 
    vec=TRIM(xcb)+".dbf"
    vem=TRIM(xmb)+".dbf"
    vep=TRIM(xpb)+".dbf"
    vemd=TRIM(xmdb)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(b1) .or. fecha>(b2)
      PACK
             close all
    ENDIF
    CLOSE all
        
    *c 
    vec=TRIM(xcc)+".dbf"
    vem=TRIM(xmc)+".dbf"
    vep=TRIM(xpc)+".dbf"
    vemd=TRIM(xmdc)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(c1) .or. fecha>(c2)
      PACK
             close all
    ENDIF
        CLOSE all
        
    *d
    vec=TRIM(xcd)+".dbf"
    vem=TRIM(xmd)+".dbf"
    vep=TRIM(xpd)+".dbf"
    vemd=TRIM(xmdd)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(d1) .or. fecha>(d2)
      pack 
            close all
    ENDIF
        CLOSE all
        
    *e
    vec=TRIM(xce)+".dbf"
    vem=TRIM(xme)+".dbf"
    vep=TRIM(xpe)+".dbf"
    vemd=TRIM(xmde)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(e1) .or. fecha>(e2)
      PACK
             close all
    ENDIF
      CLOSE all
      
    *f
    vec=TRIM(xcf)+".dbf"
    vem=TRIM(xmf)+".dbf"
    vep=TRIM(xpf)+".dbf"
    vemd=TRIM(xmdf)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(f1) .or. fecha>(f2)
      PACK
             close all
    ENDIF
      CLOSE all
  
    *g
    vec=TRIM(xcg)+".dbf"
    vem=TRIM(xmg)+".dbf"
    vep=TRIM(xpg)+".dbf"
    vemd=TRIM(xmdg)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(g1) .or. fecha>(g2)
      PACK
             close all
    ENDIF
    CLOSE all
  
    *h
    vec=TRIM(xch)+".dbf"
    vem=TRIM(xmh)+".dbf"
    vep=TRIM(xph)+".dbf"
    vemd=TRIM(xmdh)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(h1) .or. fecha>(h2)
      PACK
             close all
    ENDIF
    CLOSE all
  *i
    vec=TRIM(xci)+".dbf"
    vem=TRIM(xmi)+".dbf"
    vep=TRIM(xpi)+".dbf"
    vemd=TRIM(xmdi)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(i1) .or. fecha>(i2)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(i1) .or. fecha>(i2)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(i1) .or. fecha>(i2)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(i1) .or. fecha>(i2)
      PACK
             close all
    ENDIF
    CLOSE all
    
    *j
    vec=TRIM(xcj)+".dbf"
    vem=TRIM(xmj)+".dbf"
    vep=TRIM(xpj)+".dbf"
    vemd=TRIM(xmdj)+".dbf"
    
    COPY FILE &viajec TO &vec
    USE &vec
    dELETE ALL FOR fecha<(j1)
    PACK
           close all
    COPY FILE &viajem TO &vem
    USE &vem
    dELETE ALL FOR fecha<(j1)
    PACK
           close all
    COPY FILE &viajep TO &vep
    USE &vep
    dELETE ALL FOR fecha<(j1)
    PACK
           close all
    IF sn="s" .or. sn="S"
      COPY FILE &viajemd TO &vemd
      USE &vemd
      dELETE ALL FOR fecha<(j1)
      PACK
             close all
    ENDIF
  Endif
    CLOSE all  
  
  
  @ 50,1 say "REALIZADO......" 
Enddo


CLOSE all