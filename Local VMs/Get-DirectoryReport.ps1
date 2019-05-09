
<#
.SYNOPSIS
Shows a table of information about files in a directory (recursively).

.DESCRIPTION 
Recurses through children of $DirName and prints a table of information about the files in the directory.

Useful for creating a dataset of file information for further study

.Example
./DirectoryReport.ps1 -DirName .

Name                 Extension CreationTime          DirectoryName                                      SizeKB LastWrite LastAccessTime        Attributes
----                 --------- ------------          -------------                                      ------ --------- --------------        ----------
InstalledScriptInfos           12/17/2018 1:31:20 PM                                                     0.001           12/17/2018 1:31:20 PM  Directory
DirectoryReport.ps1  .ps1      2/18/2019 11:39:21 AM C:\Users\natec\Documents\WindowsPowerShell\Scripts  0.284           2/18/2019 11:39:22 AM    Archive
GetFolders.ps1       .ps1      2/16/2019 5:06:31 PM  C:\Users\natec\Documents\WindowsPowerShell\Scripts  0.212           2/16/2019 5:06:31 PM     Archive
getfreepercent.ps1   .ps1      12/21/2018 9:52:06 AM C:\Users\natec\Documents\WindowsPowerShell\Scripts   0.65           12/21/2018 9:52:06 AM    Archive

#>

param(
    [string]$DirName,
    [string]$OutFile
)

Get-ChildItem -Recurse -Path $DirName | Select-Object Name, Extension, CreationTime, DirectoryName, 
    @{Name = 'SizeKB'; Expression = {$_.Length / 1000}},
    LastWriteTime, LastAccessTime, Attributes | export-csv -path $OutFile -NoTypeInformation