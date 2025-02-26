﻿$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'OpenRGB'
  fileType       = 'MSI'
  silentArgs     = '/qn /norestart'
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

[array] $keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($keys.Count -eq 1) {
  $keys | ForEach-Object {
    $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
    $packageArgs['file'] = ''

    Uninstall-ChocolateyPackage @packageArgs
  }
}
elseif ($keys.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning 'To prevent accidental data loss, no programs will be uninstalled.'
  Write-Warning 'Please alert package maintainer the following keys were matched:'
  $keys | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

Uninstall-BinFile -Name 'OpenRGB'
