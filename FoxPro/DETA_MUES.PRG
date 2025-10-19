SET point to ","

select 1
use m7921

select 2
use l7921

DIMENSION ttm(100,2), ttmm(100,3)

  FOR u=1 TO 70
     ttm(u,1)=0
     ttm(u,2)=0
     ttmm(u,1)=0
     ttmm(u,2)=0
     ttmm(u,3)=0
  NEXT u  



set alternate to deta_mues
set alternate on 

l=0
zqw=0
select 1
go top
do while .not. eof()
  if cod_espec=5139030101
    l=lance
    k=peso_mues
    IF zqw=0
      ? "lance",";","Talla",";","Machos",";","Hembras",";","Macho Mad",";","Hem mad",";","Hem imp"
      zqw=1
    endif  
    FOR T=1 TO 90
      IF T<10
        ta="talla_"+STR(t,1)
      ELSE
        ta="talla_"+STR(t,2)
      ENDIF
      tall=STR(&ta,15)
      tz=substr(tall,1,3)
      tm=substr(tall,4,3)
      th=substr(tall,7,3)
      tt=INT(VAL(tz))

 *     ? "*",";",tall,";",tt
      IF  tt>0 .and. (VAL(tm)>0 .or. VAL(th)>0)
        ttm(tt,1)=ttm(tt,1)+VAL(tm)
        ttm(tt,2)=ttm(tt,2)+VAL(th)
      endif  
      
    NEXT t
    rec=RECNO()
    SELECT 2
    GO top
    DO WHILE .not. EOF()
      IF lance=l
        FOR y=1 TO 70
          IF y<10
            ta="talla_"+STR(y,1)
          ELSE
            ta="talla_"+STR(y,2)
          ENDIF
 
          tall=STR(&ta,9)

          tmm=substr(tall,1,3)
          thm=substr(tall,4,3)
          thi=substr(tall,7,3)
      
          IF y<>0 .and. (VAL(tmm)>0 .or. VAL(thm)>0 .or. VAL(thi)>0)
            ttmm(y,1)=ttmm(y,1)+VAL(tmm)
            ttmm(y,2)=ttmm(y,2)+VAL(thm)
            ttmm(y,3)=ttmm(y,3)+VAL(thi)     
          endif  
        NEXT y
      ENDIF
      SKIP
    Enddo
    SELECT 1
    IF .not. EOF()
      GOTO rec
    ENDIF
  ENDIF
  *? l,";"
  FOR u=1 TO 60
    IF ttm(u,1)<>0 .or. ttm(u,2)<>0 .or. ttmm(u,1)<>0 .or. ttmm(u,2)<>0 .or. ttmm(u,3)<>0
      ? l,";",u,";",ttm(u,1),";",ttm(u,2),";",ttmm(u,1),";",ttmm(u,2),";",ttmm(u,3)
    ENDIF
  NEXT u
  FOR u=1 TO 60
     ttm(u,1)=0
     ttm(u,2)=0
     ttmm(u,1)=0
     ttmm(u,2)=0
     ttmm(u,3)=0
  NEXT u  
  SKIP
Enddo  
      
  
set alternate off
CLOSE all