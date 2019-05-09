
<#

.SYNOPSIS 
Add External Contacts to Exchang365.

.DESCRIPTION 
Add external contacts to Exchange365. Assumes there is a PSSession established.


#>

param(
    [string]$Path = $(throw "Need a path to csv of contacts")
)

Import-Csv $Path | 
    %{New-MailContact -Name $_.Name -DisplayName $_.Name -ExternalEmailAddress $_.ExternalEmailAddress -FirstName $_.FirstName -LastName $_.LastName}