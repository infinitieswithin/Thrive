param(
    [string]$MINGW_ENV
)

$DIR = Split-Path $MyInvocation.MyCommand.Path

$REMOTE_FILE="http://downloads.sourceforge.net/sevenzip/7za920.zip"

#################
# Include utils #
#################

. (Join-Path "$DIR\.." "utils.ps1")


############################
# Create working directory #
############################

$WORKING_DIR = Join-Path $MINGW_ENV "temp\7zip"

mkdir $WORKING_DIR -force


####################
# Download archive #
####################

$DESTINATION = Join-Path $WORKING_DIR 7za.zip

if (-Not (Test-Path $DESTINATION)) {
    $CLIENT = New-Object System.Net.WebClient
    $CLIENT.DownloadFile($REMOTE_FILE, $DESTINATION)
}

##########
# Unpack #
##########

Unzip $DESTINATION $WORKING_DIR

exit 0