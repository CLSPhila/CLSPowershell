<#

.SYNOPSIS
Get a report of computer accounts in Active Directory that have not been logged into in a certain timframe.


.PARAMETER DaysSinceLogin
A number of days from today (should be a negative number!). Defaults to -60 (i.e. 60 days ago)

.PARAMETER Path
Path where csv should be written

#>


param(
    [int]$DaysSinceLogin = -60,
    [string]$Path = $(throw "Provide a path to the csv file you wish to write.")
)

$date = [DateTime]::Today.addDays($DaysSinceLogin)
get-adcomputer -Filter 'LastLogonDate -le $date' -Properties LastLogonDate, Name | 
    Select-Object Name, LastLogonDate, DistinguishedName | 
    export-csv -Path $Path