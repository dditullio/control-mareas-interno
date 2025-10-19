
USE mx
zap
APPEND FROM m11921 


SELECT 1
USE mx

SELECT 2
USE mx11921

DIMENSION tt(150)


FOR u=1 TO 150
  tt(u)=0
NEXT u

SELECT 1
GO top
DO WHILE .not. EOF()
  IF cod_espec=7218280201
    l=lance
    z=0
    FOR u=1 TO 150
      tt(u)=0
    NEXT u
    rec=RECNO()
    SELECT 2
    GO top
    DO WHILE .not. EOF()
      IF talla_91>0 .and. lance=l .and. cod_espec=7218280201
        FOR t=91 TO 150
          IF t>99
            ta="talla_"+STR(t,3)
          ELSE
            ta="talla_"+STR(t,2)
          ENDIF
          z=1
          tt(t)=&ta
        NEXT t
      endif
      SKIP
    ENDDO
    SELECT 1
    IF .not. EOF()
      GOTO rec
    ENDIF
    IF z=1
      FOR y=91 TO 150            
        IF y>99
          ta="talla_"+STR(y,3)
        ELSE
          ta="talla_"+STR(y,2)
        ENDIF
        replace &ta WITH tt(y)
      NEXT y
    endif 
  endif
  SKIP
ENDDO
CLOSE ALL
  