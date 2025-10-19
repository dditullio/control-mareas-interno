echo off
if "==%1" goto Helpinst
for %%f in (A:,a:,B:,b:,C:,c:,D:,d:,E:,e:,F:,f:,G:,g:,H:,h:,Y:,y:) do if %1.==%%f. goto START
for %%f in (I:,i:,J:,j:,K:,k:,L:,l:,M:,m:,N:,n:,O:,o:,P:,p:,Z:,z:) do if %1.==%%f. goto START
for %%f in (Q:,q:,R:,r:,S:,s:,T:,t:,U:,u:,V:,v:,W:,w:,X:,x:) do if %1.==%%f. goto START
goto BADDRIVE
:START
if %2.==ACCESS. goto ACCESS
if %2.==access. goto ACCESS
if %1.==A:. goto BADDRIVE
if %1.==a:. goto BADDRIVE
if "==%2" goto DBASE
if %2.==DBA. goto DBA
if %2.==dba. goto DBA
goto Helpinst
:DBASE
if exist access.com rename access.com dbase.com
if exist %1dbase.com goto ErrExist
type install.hlp
pause
installH p=a t=%1
if not exist %1dbase.com goto ErrDbase
copy dbase.ld1 %1
copy config.db %1
copy dbase.msg %1
copy dbaseinl.ovl %1
if not exist %1config.sys copy config.sys %1
:Chkdsk
echo Insert dBASE III PLUS SYSTEM DISK #2 into drive A.
pause
if not exist a:dbase.ovl goto Chkdsk
copy dbase.ovl  %1
copy assist.hlp %1
copy help.dbs %1
if not exist %1dbase.ovl goto ErrDbase
if not exist %1dbase.ld1 goto ErrDbase
if not exist %1dbase.msg goto ErrDbase
if not exist %1dbaseinl.ovl goto ErrDbase
echo dBASE III PLUS has been successfully installed.
goto End
:DBA
if exist %1DBA.EXE goto ERREXT
type install.hlp
pause
:Ad1
echo Insert dBASE ADMINISTRATOR DISK #1 into drive A
pause
if not exist a:dba.ld1 goto Ad1
copy dba.exe %1
copy dba.ld1 %1
copy help.dbs %1
copy assist.hlp %1
copy protect.exe %1
:Ad2
echo Insert dBASE ADMINISTRATOR DISK #2 into drive A
pause
if not exist a:dba.ovl goto Ad2
copy dba.ovl %1
copy dbase.msg %1
%1
a:installM
a:
echo dBASE ADMINISTRATOR has been successfully installed
goto End
:ACCESS
if %1.==a:. goto Floppy
if %1.==A:. goto Floppy
type install.hlp
pause
echo Installing ACCESS .....
echo off
if exist %1ACCESS.COM goto Already
if exist %1DBASE.COM goto ErrExist
installH p=a t=%1
%1
if not exist dbase.com goto ErrAccess
rename DBASE.COM ACCESS.COM
a:
echo ACCESS has been successfully installed
goto End
:Floppy
if exist %2.COM goto Already
rename DBASE.COM ACCESS.COM
if not exist access.com goto ErrAccess
echo ACCESS has been successfully installed
goto End
:Helpinst
echo Enter "INSTALL <drive:>" to install dBASE III PLUS.
echo Enter "INSTALL <drive:> DBA" to install DBA.
echo Enter "INSTALL <drive:> ACCESS" to install ACCESS.
echo Install is aborted.
goto End
:ErrExist
echo dBASE III PLUS already exists in the destination drive.
goto ErrUnst
:Already
echo ACCESS already exists in destination drive.
goto ErrUnst
:ERREXT
echo dBASE ADMINISTRATOR already exists in the destination drive.
goto ErrUnst
:ErrUnst
echo Please uninstall your old version first.
echo Install is aborted.
goto End
:ErrAccess
echo 
echo ACCESS is not installed.  Install is aborted.
goto End
:BADDRIVE
echo Invalid drive letter specified.  Install is aborted.
goto Helpinst
:ErrDbase
echo 
echo dBASE III PLUS is not installed.  Install is aborted.
:End
