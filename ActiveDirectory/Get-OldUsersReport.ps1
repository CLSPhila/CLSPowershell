
<#

.SYNOPSIS
Get a report of users in AD that have not logged in in some time.

.DESCRIPTION
Get a report of users in AD that haven't logged in in a while. Assumes a connection to AD exists already.

.PARAMETER DaysSinceLogin
A number of days from today (should be a negative number!). Defaults to -60 (i.e. 60 days ago)


#>


param(
    [int]$DaysSinceLogin = -60
)

$date = [DateTime]::Today.AddDays($DaysSinceLogin)

get-aduser -Filter {(LastLogonDate -le $date) -and (Enabled -eq $true)} -Properties Name, Enabled, LastLogonDate | 
    Select-Object Name, Enabled, LastLogonDate