
#
# THIS FILE WAS AUTO-GENERATED. DO NOT MODIFY LOCALLY BUT INSTEAD UPDATE THE PACKAGE com.fishingcactus.jenkins
#

# Get the list of existing network connections
$networkConnections = Get-WmiObject Win32_NetworkConnection

# Check if there are any network connections
if ($networkConnections) {
    Write-Output "Network connections found. Deleting..."
    
    # Loop through each network connection and delete it
    foreach ($connection in $networkConnections) {
        $remotePath = $connection.RemotePath
        
        Write-Output "Deleting network connection to $remotePath"
        
        # Use net use command to delete the network connection
        net use $remotePath /delete
    }
    
    Write-Output "All network connections deleted."
} else {
    Write-Output "No network connections found."
}
