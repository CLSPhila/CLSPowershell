
<#

.SYNOPSIS
Connect to microsoft exchange


.NOTES
Does not work with MFA-enabled accounts.
#>


param(
    [System.Management.Automation.PSCredential]
    $LiveCred = $(Get-Credential)
)


$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid/ 
    -Credential $LiveCred -Authentication Basic -AllowRedirection

Import-PSSession $Session