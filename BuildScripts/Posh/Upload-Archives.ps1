
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

param(
    [Parameter(Mandatory = $true)][string] 
    $ArchiveFilePath,
    [Parameter(Mandatory = $true)][string] 
    $BucketName,
    [Parameter(Mandatory = $true)][string] 
    $AccessKey,
    [Parameter(Mandatory = $true)][string] 
    $SecretKey,
    [Parameter(Mandatory = $true)][string] 
    $Platform
)

Write-Host "Will upload $($ArchiveFilePath)"

$KeyPrefix = $Platform

Write-S3Object -File $ArchiveFilePath -Bucketname "$($BucketName)/$($Platform)" -SecretKey $SecretKey -AccessKey $AccessKey

Get-S3Object -Bucketname $BucketName -KeyPrefix $KeyPrefix -SecretKey $SecretKey -AccessKey $AccessKey
    | Where-Object {
        $Split = $_.Key.Split( "/" )
        if ( $Split.Length -ne 2 ) {
            return $false
        }

        return $true
    } 
    | Select-Object @{ Name="Name"; Expression = { $_.Key.Split( "/" )[ 1 ] } }
    | Sort-Object  { [int]$_.Name } -Unique -Descending
    | Select-Object -Skip 10
    | ForEach-Object {
        $Key = "$($Platform)/$($_.Name)"
        
        Write-Host "Remove $($Key)"
        Remove-S3Object -Force -SecretKey $SecretKey -AccessKey $AccessKey -BucketName $BucketName -Key $Key
    }