
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

Param(
    [Parameter(Mandatory = $true)]
    [string]
    $TempBuildFolder
)

Remove-Item -path $TempBuildFolder -Recurse -ErrorAction SilentlyContinue

exit 0