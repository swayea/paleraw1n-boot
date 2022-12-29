@echo off

setlocal

:check_folder
if exist "deps" (
goto :rename
)

if exist "libs" (
goto :rename
)

if exist ".deps" (
goto :check_files
)

if exist ".libs" (
goto :check_files
)

:rename
ren deps .deps
goto check_folder
ren libs .libs
goto check_folder

goto check_files

:check_files

if exist "libimobiledevice-glue-1.0.dll" (
  echo libimobiledevice-glue-1.0.dll found.
) else (
  echo libimobiledevice-glue-1.0.dll not found.
  goto end
)

if exist "libirecovery-1.0.dll" (
  echo libirecovery-1.0.dll found.
) else (
  echo libirecovery-1.0.dll not found.
  goto end
)

if exist "libplist-2.0.dll" (
  echo libplist-2.0.dll found.
) else (
  echo libplist-2.0.dll not found.
  goto end
)

if exist "libreadline8.dll" (
  echo libreadline8.dll found.
) else (
  echo libreadline8.dll not found.
  goto end
)

if exist "libtermcap-0.dll" (
  echo libtermcap-0.dll found.
) else (
  echo libtermcap-0.dll not found.
  goto end
)

goto dualboot

:dualboot
echo write 1 if you are booting to dualboot. if not write 2
set /p answer=

if "%answer%"=="1" goto :dual_realboot
if "%answer%"=="2" goto :ask_device


echo Invalid choice. Please try again
goto dualboot

:ask_device
echo Which device do you want to boot?
echo 1. iPhone9,x
echo 2. iPhone10,x
echo 3. A9
set /p device=

if "%device%"=="1" goto check_files_9
if "%device%"=="2" goto check_files_10
if "%device%"=="3" goto check_files_A9

echo Invalid choice. Please try again.
goto ask_device

:check_files_9

if exist "ibot.img4" (
  echo ibot.img4 found.
) else (
  echo ibot.img4 not found.
  goto end
)

if exist "payload_t8010.bin" (
  echo payload_t8010.bin found.
) else (
  echo payload_t8010.bin not found.
  goto end
)

:check_files_10

if exist "ibot.img4" (
  echo ibot.img4 found.
) else (
  echo ibot.img4 not found.
  goto end
)

if exist "payload_t8015.bin" (
  echo payload_t8015.bin found.
) else (
  echo payload_t8015.bin not found.
  goto end
)

:check_files_A9

if exist "ibot.img4" (
  echo ibot.img4 found.
) else (
  echo ibot.img4 not found.
  goto end 
)

if exist "iBSS.img4" (
  echo iBSS.img4 found.
) else (
  echo iBSS.img4 not found.
  goto end 
)

goto ask_ready

:ask_ready
echo Be sure you are in pwned DFU and have correct drivers installed. Write 'ok' if it is.
set /p ready=

if /i "%ready%"=="ok" goto run_commands
echo Invalid response. Please try again.
goto ask_ready

:run_commands
if "%device%"=="1" goto run_commands_9
if "%device%"=="2" goto run_commands_10
if "%device%"=="3" goto run_commands_A9
echo Invalid choice. Please try again.
goto ask_device

:run_commands_9
echo Running commands for iPhone9,x...
irecovery.exe -f ibot.img4
timeout /t 3 /nobreak >nul
irecovery.exe -c "dorwx"
timeout /t 2 /nobreak >nul
irecovery.exe -f payload_t8010.bin
timeout /t 3 /nobreak >nul
irecovery.exe -c "go"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go xargs serial=3 -v"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go xfb"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go boot disk0s1s8"
goto end

:run_commands_10
echo Running commands for iPhone10,x...
irecovery.exe -f ibot.img4
timeout /t 3 /nobreak >nul
irecovery.exe -c "dorwx"
timeout /t 2 /nobreak >nul
irecovery.exe -f payload_t8015.bin
timeout /t 3 /nobreak >nul
irecovery.exe -c "go"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go xargs serial=3 -v"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go xfb"
timeout /t 1 /nobreak >nul
irecovery.exe -c "go boot disk0s1s8"
goto end

:run_commands_A9
echo Running commands for A9...
irecovery.exe -f ibot.img4
timeout /t 1 /nobreak >nul
irecovery.exe -f iBSS.img4
timeout /t 4 /nobreak >nul
irecovery.exe -f ibot.img4
goto end

:dual_realboot
echo Which device do you want to boot?
echo 1. A10_11
echo 2. A9
set /p device=

if "%device%"=="1" goto dualbootA10_11
if "%device%"=="2" goto dualbootA9
echo Invalid choice. Please try again.
goto dual_realboot

:dualbootA10_11
if exist "iBSS.img4" (
  echo iBSS.img4 found.
) else (
  echo iBSS.img4 not found.
  goto end
)

if exist "iBEC.img4" (
  echo iBEC.img4 found.
) else (
  echo iBEC.img4 not found.
  goto end
)

if exist "devicetree.img4" (
  echo devicetree.img4 found.
) else (
  echo devicetree.img4 not found.
  goto end
)

if exist "trustcache.img4" (
  echo trustcache.img4 found.
) else (
  echo trustcache.img4 not found.
  goto end
)

if exist "kernelcache.img4" (
  echo kernelcache.img4 found.
) else (
  echo kernelcache.img4 not found.
  goto end
)

echo Running commands for A10-A11...
irecovery.exe -f iBSS.img4
timeout /t 1 /nobreak >nul
irecovery.exe -f iBEC.img4
timeout /t 3 /nobreak >nul
irecovery.exe -c go
irecovery.exe -f devicetree.img4
timeout /t 1 /nobreak >nul
irecovery.exe -c devicetree
timeout /t 1 /nobreak >nul
irecovery.exe -v -f trustcache.img4
irecovery.exe -c firmware
timeout /t 1 /nobreak >nul
irecovery.exe -f kernelcache.img4
timeout /t 1 /nobreak >nul
irecovery -c bootx

:dualbootA9
if exist "iBSS.img4" (
  echo iBSS.img4 found.
) else (
  echo iBSS.img4 not found.
  goto end
)

if exist "iBEC.img4" (
  echo iBEC.img4 found.
) else (
  echo iBEC.img4 not found.
  goto end
)

if exist "devicetree.img4" (
  echo devicetree.img4 found.
) else (
  echo devicetree.img4 not found.
  goto end
)

if exist "trustcache.img4" (
  echo trustcache.img4 found.
) else (
  echo trustcache.img4 not found.
  goto end
)

if exist "kernelcache.img4" (
  echo kernelcache.img4 found.
) else (
  echo kernelcache.img4 not found.
  goto end
)

echo Running commands for A9...
irecovery.exe -f iBSS.img4
timeout /t 1 /nobreak >nul
irecovery.exe -f iBEC.img4
timeout /t 3 /nobreak >nul
irecovery.exe -f devicetree.img4
timeout /t 1 /nobreak >nul
irecovery.exe -c devicetree
timeout /t 1 /nobreak >nul
irecovery.exe -v -f trustcache.img4
irecovery.exe -c firmware
timeout /t 1 /nobreak >nul
irecovery.exe -f kernelcache.img4
timeout /t 1 /nobreak >nul
irecovery -c bootx


:end
echo Done.

timeout /t 3 /nobreak >nul
