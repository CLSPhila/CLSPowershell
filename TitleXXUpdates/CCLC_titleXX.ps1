<#

.SYNOPSIS
Copy macros to users's directories

.DESCRIPTION 
CLS has a set of VBA Word macros that staff use to automate creating certain kinds of documents. 
We have single master version of the .dotm file that contains the macros, and we copy this file to
the startup directory of each user's Word application.

.PARAMETER MacroPath
Path to the master macro-containing .dot file that should be deployed to users, including the file name.

.PARAMETER UserPaths
Define all the paths to folders awhere macros are stored. Has the form \\shared\users\*\macros. 
This collects all the \macros\ subdirectories under all the \users\ directories.

.PARAMETER MacroFileName
Name of the macro file in --DirectoryPath that will be copied to users.

.PARAMETER LogPath
Path to a logfile for recording success or failure.

#>

param(
    [string]$MacroPath =  "\\cclc1\installs\Templates\Copy_to_TMacros\TITLEXX.dot",
    [string]$UserPaths = "\\cclc1\users\*\macros",
    [string]$MacroFileName = 'TITLEXX.dot',
    [string]$LogPath =  '\\cclc1\units\Public\titlexx.log'
)

$folders = Get-ChildItem -Path $UserPaths

ForEach($folder in $folders)
{
    Remove-Item -Path (Join-Path -Path $folder -ChildPath $MacroFileName)
    Copy-Item -Path $MacroPath -Destination $folder
    $folder | Out-File $LogPath -Append
}