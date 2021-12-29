#region Required Modules

Import-Module VMWare.PowerCLI

#endregion

#region Adjustable Variables

$MyHosts = "<Enter VCenter Host FQDN>"
$username = "<Enter Username to connect to VCenter Host>"
$password = "<Enter User's Password here>"
$Days = "<Enter a number of days to remove snapshots older than>"

#endregion

#region Connect to VCenter

#Connects to the vcenter server
$MyHosts | Foreach {
Write-Host "Connecting to host: $($_)"
$connection = Connect-VIServer $_ -User $username -Password $password
}

#endregion

#region Delete Snapshots older than time entered in $Days

#Gets a list of all VMs in vcenter and lists all snapshots older than 7 days
Get-VM | Get-Snapshot | Where {$_.Created -lt (Get-Date).AddDays(-$days)} | Remove-Snapshot -Confirm:$false

#endregion
