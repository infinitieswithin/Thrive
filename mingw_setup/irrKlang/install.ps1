param(
    [string]$MINGW_ENV
)

##########
# Bullet #
##########

Write-Output "--- Installing irrKlang ---"

$DIR = Split-Path $MyInvocation.MyCommand.Path

#################
# Include utils #
#################

. (Join-Path "$DIR\.." "utils.ps1")


############################
# Create working directory #
############################

$WORKING_DIR = Join-Path $MINGW_ENV temp\irrKlang

mkdir $WORKING_DIR -force | out-null


###################
# Check for 7-Zip #
###################

$7z = Join-Path $MINGW_ENV "temp\7zip\7za.exe"

if (-Not (Get-Command $7z -errorAction SilentlyContinue))
{
    return $false
}

mkdir -p (Join-Path $MINGW_ENV "irrKlang")

####################
# Download archive #
####################

$REMOTE_DIR="http://www.ambiera.at/downloads"

$ARCHIVE="irrKlang-1.4.0b.zip"

$DESTINATION = Join-Path $WORKING_DIR $ARCHIVE

if (-Not (Test-Path $DESTINATION)) {
    Write-Output "Downloading archive..."
    $CLIENT = New-Object System.Net.WebClient
    $CLIENT.DownloadFile("$REMOTE_DIR/$ARCHIVE", $DESTINATION)
}
else {
    Write-Output "Found archive file, skipping download."
}

##########
# Unpack #
##########

Write-Output "Unpacking archive..."

$ARGUMENTS = "x",
             "-y",
             "-o$WORKING_DIR",
             $DESTINATION
             
& $7z $ARGUMENTS


Copy-Item (Join-Path $WORKING_DIR "irrKlang-1.4.0\include") -destination (Join-Path $MINGW_ENV "install") -Recurse -Force



####################
# Download archive #
####################

$REMOTE_DIR="http://www.ambiera.at/downloads"

$ARCHIVE="irrklang-1.4.0-gcc4.7.zip"

$DESTINATION = Join-Path $WORKING_DIR $ARCHIVE

if (-Not (Test-Path $DESTINATION)) {
    Write-Output "Downloading archive..."
    $CLIENT = New-Object System.Net.WebClient
    $CLIENT.DownloadFile("$REMOTE_DIR/$ARCHIVE", $DESTINATION)
}
else {
    Write-Output "Found archive file, skipping download."
}

##########
# Unpack #
##########

Write-Output "Unpacking archive..."

$ARGUMENTS = "x",
             "-y",
             "-o$WORKING_DIR",
             $DESTINATION
             
& $7z $ARGUMENTS


Copy-Item (Join-Path $WORKING_DIR "irrklang-1.4.0-gcc4.7\lib\Win32-gcc\*") -destination (Join-Path $MINGW_ENV "install\lib") -Force
Copy-Item (Join-Path $WORKING_DIR "irrklang-1.4.0-gcc4.7\bin\win32-gcc-4.7\*.dll") -destination (Join-Path $MINGW_ENV "install\lib") -Force


popd
