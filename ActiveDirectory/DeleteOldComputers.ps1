
<#

.SYNOPSIS
Remove a list of accounts from Active Directory.

.DESCRIPTION
Given a CSV file with a column "Name"that identifies AD computer accounts to remove, remove those accounts from AD. 
This is probably most useful with a list of old accounts generated by Get-OldComputersReport.ps1

#>

.PARAMETER Path
The path to the csv file listing accounts to delete.

# Add the Active Directory bits and not complain if they're already there

param(
	[string]$Path = $(throw "Must provide a path to a csv file.")
)

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Get domain DNS suffix
$dnsroot = '@' + (Get-ADDomain).dnsroot

# Import the file with the users. You can change the filename to reflect your file
$computers = Import-Csv $Path

foreach ($computer in $computers) {
	Remove-ADComputer -Identity $computer.Name
}