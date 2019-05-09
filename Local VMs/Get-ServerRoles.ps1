<#

.SYNOPSIS 
Identify what server roles are running on a set of servers.

.DESCRIPTION
Given a list of windows servers, find out what roles are running on each.
This requires the ServerManager module (Import-Module servermanager)

.EXAMPLE
.\Get-ServerRoles.ps1 -creds $creds -ServerNames domainController1,sqlServer2 | export-csv -Path "..\data\serverRoles.csv"

.NOTES

#>

param(
    [System.Management.Automation.PSCredential]
    $creds = $(Get-Credential),

    [string[]]
    $ServerNames = $(throw "Please identify the server names")
)


@(
    foreach($serverName in $ServerNames) {
        $features = Get-WindowsFeature -Credential $creds -ComputerName $serverName | 
            Where-Object {$_.InstallState -eq "Installed"}
        
        foreach($feature in $features) {
            [PSCustomObject]@{
                ServerName = $serverName
                FeatureName = $feature.Name
                Installed = $feature.Installed
                InstallState = $feature.IntallState
                FeatureType = $feature.FeatureType
            }
        }
    }
)

