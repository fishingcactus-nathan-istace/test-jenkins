
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
    [Parameter(Mandatory = $false)]
    [bool]
    $ShouldSucceed = $false
)

$ErrorActionPreference = "Stop"

$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

. ("$ScriptDirectory\\Run-Unity-Function.ps1")

[int]$result = Run-Unity -UnityPath $UnityPath -Arguments $Arguments
if ( $ShouldSucceed -and $result -ne 0 ) {
    Write-Error "Unity Build failed" -ErrorAction Stop
}
exit $result