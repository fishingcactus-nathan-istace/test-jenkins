
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Param(
    [Parameter(Mandatory=$true)]
    [string]
    $UnityPath
)

$ErrorActionPreference = "Stop"

$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

. ("$ScriptDirectory\\Run-Unity-Function.ps1")

Function Get-Should-Activate-Unity {
    return $Username -ne "" -and $Password -ne "" -and $Serial -ne "";
}

if ( Get-Should-Activate-Unity ) {
    $Success = Run-Unity -UnityPath $UnityPath -Arguments @("returnlicense")

    # :NOTE: Unity License activation is crashing, but it does succeed!
    # if ( $Success -eq $false ) {
    #     Write-Error "Error during license deactivation" -ErrorAction Stop
    # }
}
exit 0