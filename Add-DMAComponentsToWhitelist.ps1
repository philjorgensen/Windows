<#
Adds un-allowed DMA component to whitelist to resolve automatic device encryption issues.
Only necessary for Whiskey Lake generation ThinkPad

Reference: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-bitlocker#un-allowed-dma-capable-busdevices-detected
#>
$Path = "SYSTEM\CurrentControlSet\Control\DmaSecurity\AllowedBuses"
$Keys = @{

    'PCI Express Upstream Switch Port' = 'PCI\VEN_8086&DEV_15C0'

}

if (!(Get-PSDrive HKLM -ErrorAction SilentlyContinue)) {
    New-PSDrive -Name HKLM -PSProvider Registry -Root Registry::HKEY_LOCAL_MACHINE | Out-Null
}

foreach ($Key in $Keys.GetEnumerator()) {
    New-ItemProperty -Path HKLM:$Path -Name $Key.Key -Value $Key.Value -PropertyType String -Force | Out-Null
}