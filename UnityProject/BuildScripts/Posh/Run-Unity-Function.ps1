
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Function Run-Unity {
    [CmdletBinding()]
    [OutputType([int])]
    Param(
        [Parameter(Mandatory=$true)]
        [string]
        $UnityPath,
        [Parameter(Mandatory=$true)]
        [string[]]
        $Arguments,
        [Parameter(Mandatory = $false)]
        [string]
        $LogFile = "-",
        [Parameter(Mandatory=$false)]
        [int]
        # 12 hours
        $TimeOutMilliseconds = 12 * 60 * 60 * 1000
    )

    [Diagnostics.ProcessStartInfo]$pInfo = [Diagnostics.ProcessStartInfo]::new()
    $pInfo.FileName = $UnityPath
    $pInfo.RedirectStandardError = $false
    $pInfo.RedirectStandardOutput = $false
    $pInfo.UseShellExecute = $false
    $pInfo.Arguments = "-quit -batchmode -logFile $LogFile"
    foreach ($argument in $Arguments) {
        $pInfo.Arguments += " -$argument"
    }

    Write-Debug "Arguments $($pInfo.Arguments)"
    [Diagnostics.Process]$p = [Diagnostics.Process]::new()
    $p.StartInfo = $pInfo
    $started = $p.Start()
    if ($started -eq $false)
    {
        Write-Error "Start for Unity process returned false" -ErrorAction Stop
    }
    $exited = $p.WaitForExit($TimeOutMilliseconds)
    if ($exited -eq $false)
    {
        $p.Kill()
        $TimeOutHours = $TimeOutMilliseconds / ( 1000 * 60 * 60 )
        Write-Error "Unity process did no exit after $TimeOutHours hour, killing..." -ErrorAction Stop
    }
    return $p.ExitCode
}