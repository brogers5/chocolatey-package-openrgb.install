$ErrorActionPreference = 'Stop'

$currentPath = (Split-Path $MyInvocation.MyCommand.Definition)
. $currentPath\helpers.ps1

$nuspecFileRelativePath = Join-Path -Path $currentPath -ChildPath 'openrgb.install.nuspec'
[xml] $nuspec = Get-Content $nuspecFileRelativePath
$version = [semver] $nuspec.package.metadata.version

$global:Latest = @{
    Url64 = Get-DownloadUri -Version $version
}

Write-Output 'Downloading...'
Get-RemoteFiles -Purge -NoSuffix

Write-Output 'Creating package...'
choco pack $nuspecFileRelativePath
