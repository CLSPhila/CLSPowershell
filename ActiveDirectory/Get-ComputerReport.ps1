<#

.SYNOPSIS
Collect Basic Information about a computer

.DESCRIPTION
Uses WMI info to collect information about a computer. Useful for looking for likely causes of trouble, 
such as low free space, low free memory, large windows profiles.


#>


param(
    [string]$ComputerName = $env:COMPUTERNAME
)

$collection = @()

if ($ComputerName -eq $env:COMPUTERNAME) {
    # If we're using the local machine, don't bother passing -ComputerName
    # because then the script will require remote registry management
    # turned on, even to access local wmi information.
    $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
    $CDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID ='C:'"
    [pscustomobject]@{
        ComputerName = $ComputerName
        TotalPhysicalMemoryGB = $computerSystem.TotalPhysicalMemory / 1000000000
        Model = $computerSystem.Model
        Manufacturer = $computerSystem.Manufacturer
        CDriveTotalTB = $CDrive.Size / 1000000000000
        CDriveFreePercent = ($CDrive.FreeSpace / $CDrive.Size) * 100
    }
} else {
    $opt = New-CIMSessionOptions -Protocol DCOM


    @(foreach($computer in $ComputerName) {
        $sess = New-CIMSession -SessionOption $opt -ComputerName $computer
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
        $CDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID ='C:'" -ComputerName $computer
        [pscustomobject]@{
            ComputerName = $computer
            TotalPhysicalMemoryGB = $computerSystem.TotalPhysicalMemory / 1000000000
            Model = $computerSystem.Model
            Manufacturer = $computerSystem.Manufacturer
            CDriveTotalTB = $CDrive.Size / 1000000000000
            CDriveFreePercent = ($CDrive.FreeSpace / $CDrive.Size) * 100
        }
    })
}