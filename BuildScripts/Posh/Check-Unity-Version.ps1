
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Param(
    [Parameter(Mandatory=$true)]
    [string]
    $ProjectPath
)

$ErrorActionPreference = "Stop"

$content = Get-Content -Path "$ProjectPath\ProjectSettings\ProjectVersion.txt"
$content = $content.Split([Environment]::NewLine)[0];

[string]$unityVersion = $content.Split(' ')[1].Trim();
Write-Information "$unityVersion"
return "$unityVersion"