<#

.SYNOPSIS 
Report of CLS VMWare server workloads

.NOTES
See https://vdc-download.vmware.com/vmwb-repository/dcr-public/2156d7ad-8f0f-4001-9de5-0cb95340873b/84fc3e8c-4755-4376-9917-18eb49a6bcdf/vmware-powercli-111-user-guide.pdf for VMWare CLI user guide.

#>

# TODO - only run this if there's no active connection already.
# Connect-VIServer -Server 10.20.2.6

param(
    [System.Management.Automation.PSCredential]
    $creds = $(Get-Credential)
)

$vms = Get-VM
$opt = New-CIMSessionOption -Protocol DCOM


@(foreach($vm in $vms) {
    $vView = get-View $vm
    $computerName = $vView.Guest.HostName
    if ($null -ne $computerName -and $computerName -ne "") {
        $sess = New-CIMSession -SessionOption $opt -ComputerName $computerName -Credential $creds
    } else {
        $sess = $null
    }
    if ($null -ne $sess) {
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $sess
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $sess
        $CDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID ='C:'" -CimSession $sess
        $DDrive = Get-CimInstance -Classname Win32_LogicalDisk -Filter "DeviceID = 'D:'" -CimSession $sess
        [pscustomobject]@{
            Name = $vm.Name
            Powered = $vm.PowerState
            ComputerName = $computerName
            osName = $os.name
            osBuild = $os.version
            memoryGB = $vm.memoryGB
            usedVMWareSpace = $vm.UsedSpaceGB
            TotalPhysicalMemoryGB = $computerSystem.TotalPhysicalMemory / 1000000000
            Model = $computerSystem.Model
            Manufacturer = $computerSystem.Manufacturer
            CDriveTotalTB = $CDrive.Size / 1000000000000
            CDriveFreePercent = ($CDrive.FreeSpace / $CDrive.Size) * 100
            DDriveTotalTB = $DDrive.Size / 1000000000000
            DDriveFreePercent = ($DDrive.FreeSpace / $DDrive.Size) * 100
        } 
    } else {
        [pscustomobject]@{
            Name = $vm.Name
            Computername = ""
            osName = "Inaccessible"
            osBuild = "Inaccessible"
            Powered = $vm.PowerState
            memoryGB = $vm.memoryGB
            usedVMWareSpace = $vm.UsedSpaceGB
            TotalPhysicalMemoryGB = "Inaccessible"
            Model = "Inaccesible"
            Manufacturer = "Inaccessible"
            CDriveTotalTB = "Inaccessible"
            CDriveFreePercent = "Inaccessible"
            DDriveTotalTB = "Inaccessible"
            DDriveFreePercent = "Inaccessible"
        }
    }
})

# Get-VM  | select Name, PowerState, MemoryGB, UsedSpaceGB