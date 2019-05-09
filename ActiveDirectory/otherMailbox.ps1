
<#

.SYNOPSIS
Set another mailbox for AD users.

.DESCRIPTION
Setting another mailbox for AD users is useful if syncing AD accounts to GSuite accounts, if the other accounts have a different domain. For example, 
If John Smith's account is jsmith@example.fake, this would add jsmith@another.fake as another mailbox for his AD account.

.PARAMETER Path
Path a csv file with a column SamAccountName that identifies the account's name without domain (i.e. John Smith might be jsmith)

.PARAMETER domain
The domain, as a string, of the alternate mailbox for a user. 

#>

param(
	[string]$Path = $(throw "Need a path to the csv of account names."),
	[string]$Domain = (throw "Need the domain name of the alternate mailbox.")
)


# Add the Active Directory bits and not complain if they're already there
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Get domain DNS suffix
$dnsroot = '@' + (Get-ADDomain).dnsroot

# Import the file with the users. You can change the filename to reflect your file
$users = Import-Csv $Path

foreach ($user in $users) {
	Set-ADUser -Identity $user.SamAccountName -Add @{otherMailbox=$user.SamAccountName + $Domain}
}