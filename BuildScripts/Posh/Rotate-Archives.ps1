
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#


#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

param(
    [Parameter(Mandatory = $true)][string] $ArchiveDirectory,
    [string]
    $Username,
    [Parameter(Mandatory = $true)]
    [string]
    $Password
)

$NumberOfVersionsToKeep = 10

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
    Write-Output "Authenticating user with net use : $($ArchiveDirectory)";
}

if ( $? -eq $false ) {
    Write-Error "There was an error connecting to $ArchiveDirectory" -ErrorAction Stop
}


$PathExists = Test-Path -Path $ArchiveDirectory 

if ( $PathExists -eq $False ) {
    Write-Host "Folder $($ArchiveDirectory) does not exist."
    exit 1
}

$AllFolders = Get-ChildItem -Path $ArchiveDirectory -Directory -Force -ErrorAction SilentlyContinue 
    | Sort-Object { [int]$_.Name } -Descending
    | Select-Object FullName

$Index = 0;

Write-Host "Keep number of versions lower than $($NumberOfVersionsToKeep)"

foreach ( $Folder in $AllFolders ) {
    if ( $Index -lt $NumberOfVersionsToKeep ) {
        Write-Host "Keep $($Folder.FullName)"
        $Index += 1
        continue
    }

    Get-ChildItem -Path $Folder.FullName -Include *.* -File -Recurse | ForEach-Object { 
        Write-Host "Remove $_"
        $_.Delete() 
    }

    Write-Host "Remove $($Folder.FullName)"
    Remove-Item -Path $Folder.FullName -Recurse -Force 
}