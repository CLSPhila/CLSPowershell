
<#

.DESCRIPTION
Remove a user from Exchange Distribution Groups.

.NOTES
Probably doesn't work anymore, with Exchange Online.

#>


param(
    [string]$user = $(throw "Identfy the user to remove from distribution groups.")
)

$mailbox=get-mailbox $user

$dgs= Get-DistributionGroup
 
foreach($dg in $dgs){
    
    $DGMs = Get-DistributionGroupMember -identity $dg.Identity
    foreach ($dgm in $DGMs){
        if ($dgm.name -eq $mailbox.name){
       
            write-host 'User Found In Group' $dg.identity
              Remove-DistributionGroupMember $dg.Name -Member $user
        }
    }
}