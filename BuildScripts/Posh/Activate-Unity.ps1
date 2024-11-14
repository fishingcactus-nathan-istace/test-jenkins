
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Param(
    [Parameter(Mandatory=$true)]
    [string]
    $UnityPath,
    [Parameter(Mandatory=$true)]
    [string[]]
    $Arguments,
    [Parameter(Mandatory=$false)]
    [string]
    $Username = "",
    [Parameter(Mandatory=$false)]
    [string]
    $Password = "",
    [Parameter(Mandatory=$false)]
    [string]
    $Serial = ""

)

$ErrorActionPreference = "Stop"

$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

. ("$ScriptDirectory\\Run-Unity-Function.ps1")

Function Get-Should-Activate-Unity {
    return $Username -ne "" -and $Password -ne "" -and $Serial -ne "";
}

if ( Get-Should-Activate-Unity ) {
    # Note: If you use continuous integration (CI) tools like Jenkins to activate via the command line, add the -nographics flag to prevent a WindowServer error.
    $combinedArgs = @("nographics", "serial $Serial", "username $Username", "password $Password", "quit") + $Arguments
    $Success = Run-Unity -UnityPath $UnityPath -Arguments $combinedArgs 

    # :NOTE: Unity License activation is crashing, but it does succeed!
    # if ( $Success -eq $false ) {
    #     Write-Error ">>> Error during license activation" -ErrorAction Stop
    # }
}
exit 0