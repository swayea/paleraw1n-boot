@echo off

setlocal

ren deps .deps
ren libs .libs

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

goto ask_ready

:check_files_9
call :check_files

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

goto ask_ready

:check_files_10
call :check_files

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

goto ask_ready

:check_files_A9
call :check_files

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

if "%device%"=="1" goto run_commands_9
if "%device%"=="2" goto run_commands_10
if "%device%"=="3" goto run_commands_A9
echo Invalid choice. Please try again.
goto ask_device

:ask_ready
echo Be sure you are in pwned DFU and have correct drivers installed. Write 'ok' if it is.
set /p ready=

if /i "%ready%"=="ok" goto run_commands
echo Invalid response. Please try again.
goto ask_ready

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

:end
echo Done.
endlocal
