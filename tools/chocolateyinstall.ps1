$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$softwareNamePattern = 'OpenRGB'

$fileName = 'OpenRGB_1.0rc2_Windows_64_0fca93e.msi'
$filePath = Join-Path -Path $toolsDir -ChildPath $fileName

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  file64         = $filePath
  softwareName   = $softwareNamePattern
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

#Remove installer binary post-install to prevent disk bloat
Remove-Item -Path $filePath -Force -ErrorAction SilentlyContinue

$pp = Get-PackageParameters
$shimName = 'OpenRGB'
if ($pp.NoShim) {
  Uninstall-BinFile -Name $shimName
}
else {
  $installLocation = Get-AppInstallLocation -AppNamePattern $softwareNamePattern
  if ($null -ne $installLocation) {
    $shimPath = Join-Path -Path $installLocation -ChildPath 'OpenRGB.exe'
    Install-BinFile -Name $shimName -Path $shimPath
  }
  else {
    Write-Warning 'Skipping shim creation - install location not detected'
  }
}

if (!$pp.DontCheckForPawnIO) {
  $pawnIoInstallLocation = Get-AppInstallLocation -AppNamePattern 'PawnIO'
  if ($null -eq $pawnIoInstallLocation) {
    Write-Warning 'OpenRGB has recently switched from using WinRing0 to PawnIO, which may require a separate installation.'
    Write-Warning 'If your devices require I2C or SMBus access, please install PawnIO prior to using OpenRGB.'
  }
}
