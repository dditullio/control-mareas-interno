
CLOSE all
SET DATE french

*c
COPY FILE c7921.dbf TO c7921a.dbf
COPY FILE c7921.dbf TO c7921b.dbf
COPY FILE c7921.dbf TO c7921c.dbf



*m
COPY FILE m7921.dbf TO m7921a.dbf
COPY FILE m7921.dbf TO m7921b.dbf
COPY FILE m7921.dbf TO m7921c.dbf




*md
*COPY FILE md7921.dbf TO md7921a.dbf
*COPY FILE md7921.dbf TO md7921b.dbf
*COPY FILE md7921.dbf TO md7921c.dbf

*p
COPY FILE p7921.dbf TO p7921a.dbf
COPY FILE p7921.dbf TO p7921b.dbf
COPY FILE p7921.dbf TO p7921c.dbf





***c
uSE c7921a
dELETE ALL FOR fecha>CTOD("12/06/21")
pACK

USE c7921b
DELETE ALL FOR fecha<CTOD("13/06/21") .or.fecha>CTOD("24/06/21")
PACK

uSE c7921c
dELETE ALL FOR fecha<CTOD("25/06/21")
pACK



****m

uSE m7921a
dELETE ALL FOR fecha>CTOD("12/06/21")
pACK

USE m7921b
DELETE ALL FOR fecha<CTOD("13/06/21") .or.fecha>CTOD("24/06/21")
PACK

USE m7921c
dELETE ALL FOR fecha<CTOD("25/06/21")
pACK



*****md




***p

uSE p7921a
dELETE ALL FOR fecha>CTOD("12/06/21")
pACK

USE p7921b
DELETE ALL FOR fecha<CTOD("13/06/21") .or.fecha>CTOD("24/06/21")
PACK

USE p7921c
dELETE ALL FOR fecha<CTOD("25/06/21")
pACK





CLOSE all