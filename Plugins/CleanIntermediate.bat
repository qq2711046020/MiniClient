FOR /d /r . %%d IN (Intermediate) DO @IF EXIST "%%d" rd /s /q  "%%d"
FOR /d /r . %%a IN (Binaries) DO @IF EXIST "%%a" rd /s /q  "%%a"
pause