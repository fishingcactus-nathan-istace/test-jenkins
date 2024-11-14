
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#


#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Param(
    [Parameter(Mandatory=$true)]
    [string]
    $ArchiveDirectory,
    [Parameter(Mandatory=$true)]
    [string]
    $SourceFolder,
    [Parameter(Mandatory=$true)]
    [string]
    $ZipFileName,
    # [Parameter(Mandatory = $false)]
    # [string]
    # $UnityVersion
    [string]
    $Username,
    [Parameter(Mandatory = $true)]
    [string]
    $Password
)

$ErrorActionPreference = "Stop"

$ZipFilePath = "$SourceFolder\$ZipFileName"

$compress = @{
    Path = $SourceFolder
    CompressionLevel = "Optimal"
    DestinationPath = $ZipFilePath
}

Compress-Archive @compress

Write-Output "Moving $ZipFilePath to $ArchiveDirectory";

if ( $ArchiveDirectory.StartsWith('\\') ) {
    if ( $ArchiveDirectory.EndsWith('\') -or $ArchiveDirectory.EndsWith('/') ) {
        $ArchiveDirectory = $ArchiveDirectory.Substring(0, $ArchiveDirectory.Length - 1);
    }
    # Get the directory path of the current script
    $scriptDirectory = $PSScriptRoot
    # Construct the full path to the script
    $scriptPath = Join-Path -Path $scriptDirectory -ChildPath "Delete-Network-Shares.ps1"
    # Execute the script by calling the script file
    & $scriptPath 
    net use $ArchiveDirectory /u:$Username $Password
    Write-Output "Authenticating user with net use";
}

if ( $? -eq $false ) {
    Write-Error "There was an error connecting to $ArchiveDirectory" -ErrorAction Stop
}


Robocopy $SourceFolder $ArchiveDirectory $ZipFileName

if ( $LASTEXITCODE -ne 1 -and $LASTEXITCODE -ne 3 ) {
    # Get the directory path of the current script
    $scriptDirectory = $PSScriptRoot
    # Construct the full path to the script
    $scriptPath = Join-Path -Path $scriptDirectory -ChildPath "Delete-Network-Shares.ps1"
    # Execute the script by calling the script file
    & $scriptPath 
    Write-Error "Error copying build from $SourceFolder to $ArchiveDirectory" -ErrorAction Stop
}

# Get the directory path of the current script
$scriptDirectory = $PSScriptRoot
# Construct the full path to the script
$scriptPath = Join-Path -Path $scriptDirectory -ChildPath "Delete-Network-Shares.ps1"
# Execute the script by calling the script file
& $scriptPath 
exit 0