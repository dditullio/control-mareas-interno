
CLOSE all
SET DATE french

*c
COPY FILE c7121.dbf TO c7121a.dbf
COPY FILE c7121.dbf TO c7121b.dbf




*m
COPY FILE m7121.dbf TO m7121a.dbf
COPY FILE m7121.dbf TO m7121b.dbf





*md
*COPY FILE md7121.dbf TO md7121a.dbf
*COPY FILE md7121.dbf TO md7121b.dbf


*p
COPY FILE p7121.dbf TO p7121a.dbf
COPY FILE p7121.dbf TO p7121b.dbf






***c
uSE c7121a
dELETE ALL FOR fecha>CTOD("05/06/21")
pACK

uSE c7121bc
dELETE ALL FOR fecha<CTOD("17/06/21")
pACK



****m

uSE m7121a
dELETE ALL FOR fecha>CTOD("05/06/21")
pACK

USE m7121b
dELETE ALL FOR fecha<CTOD("17/06/21")
pACK



*****md




***p

uSE p7121a
dELETE ALL FOR fecha>CTOD("05/06/21")
pACK

USE p7121b
dELETE ALL FOR fecha<CTOD("17/06/21")
pACK





CLOSE all