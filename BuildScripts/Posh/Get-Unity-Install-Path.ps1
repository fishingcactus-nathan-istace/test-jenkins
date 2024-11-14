
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

[CmdletBinding()]
[OutputType([string])]
Param(
    [Parameter(Mandatory=$true)]
    [string]
    $ExpectedVersion,
    [Parameter(Mandatory=$false)]
    [string]
    $UnityHubLocation = 'C:\Program Files\Unity Hub\Unity Hub.exe',
    [Parameter(Mandatory=$false)]
    [int]
    $TimeOutMilliseconds = 3600000
)

$ErrorActionPreference = "Stop"

[Diagnostics.ProcessStartInfo]$pInfo = [Diagnostics.ProcessStartInfo]::new()
$pInfo.FileName = $UnityHubLocation
$pInfo.RedirectStandardError = $true
$pInfo.RedirectStandardOutput = $true
$pInfo.UseShellExecute = $false
$pInfo.Arguments = "-- --headless editors -i"

[Diagnostics.Process]$p = [Diagnostics.Process]::new()
$p.StartInfo = $pInfo
$started = $p.Start()
if ($started -eq $false)
{
    Write-Error "Start for Unity Hub process returned false" -ErrorAction Stop
}
$exited = $p.WaitForExit($TimeOutMilliseconds)
if ($exited -eq $false)
{
    $p.Kill()
    Write-Error "Unity Hub process did no exit after 1 hour, killing..." -ErrorAction Stop
}
else
{
    for() {
        $line = $p.StandardOutput.ReadLine()
        if ($null -eq $line) { break }
        # process the line
        $version, $path = $line.split(",");
        $version = $version.Trim();
        if ( $version -eq $ExpectedVersion )
        {
            [string]$path = $path.Trimstart(" installed at ").Trim();
            Write-Information "$path"
            return $path;
            exit 0
        }
    }
    Write-Error "Expected version $ExpectedVersion not found." -ErrorAction Stop
}
Write-Error  "Something else went wrong." -ErrorAction Stop
exit 1