<#

.SYNOPSIS
Collect information about the Exchange Online mailboxes of staff

.DESCRIPTION
Uses the Exchange Powershell module to build a report about CLS's Exchange Online.

#>

param(
    # Name of the account whose credentials you are using to authenticate to Exchange
    [string]$UserPrincipalName = $(throw "-UserPrincipalName is required."),
    # Path to the csv that should be written out.
    [string]$OutputPath = $(throw "-OutputPath is required.")
)

# Connecting to Exchange Online for MFA-enabld accounts requires downloading a special package from microsoft. Its not obvious how to use that package in a 
# script. This section finds the right dll and loads it. Awkward, but it works. NateV found this online.
$modules = @(Get-ChildItem -Path "$($env:LOCALAPPDATA)\Apps\2.0" -Filter "Microsoft.Exchange.Management.ExoPowershellModule.manifest" -Recurse )
$moduleName =  Join-Path $modules[0].Directory.FullName "Microsoft.Exchange.Management.ExoPowershellModule.dll"
Import-Module -FullyQualifiedName $moduleName -Force
$scriptName =  Join-Path $modules[0].Directory.FullName "CreateExoPSSession.ps1"
. $scriptName


# Load an exchange online session
Connect-EXOPSSession -UserPrincipalName $UserPrincipalName

get-mailbox | get-mailboxstatistics | 
    Select-Object DisplayName, ItemCount, TotalItemSize | 
    Export-CSV -Path $OutputPath

Get-PSSession | Remove-PSSession