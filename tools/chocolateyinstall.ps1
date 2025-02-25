$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$softwareNamePattern = 'OpenRGB'

$fileName = 'OpenRGB_1.0rc1_Windows_64_1fbacde.msi'
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
