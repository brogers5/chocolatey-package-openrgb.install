[CmdletBinding()]
param($IncludeStream)
Import-Module au

$currentPath = (Split-Path $MyInvocation.MyCommand.Definition)
. $currentPath\helpers.ps1

$toolsPath = Join-Path -Path $currentPath -ChildPath 'tools'
$softwareRepo = 'CalcProgrammer1/OpenRGB'

function global:au_GetLatest {
    $streams = [ordered] @{
        ReleaseCandidateWinRing0 = Get-LatestReleaseCandidateVersionInfo -WinRing0
        ReleaseCandidate         = Get-LatestReleaseCandidateVersionInfo
        #Temporarily disabled, since the latest Stable release currently doesn't have an installer
        # Stable                   = Get-LatestStableVersionInfo
    }

    return @{ Streams = $streams }
}

function global:au_BeforeUpdate ($Package) {
    Get-RemoteFiles -Purge -NoSuffix -Algorithm sha256

    $templateFilePath = Join-Path -Path $toolsPath -ChildPath 'VERIFICATION.txt.template'
    $verificationFilePath = Join-Path -Path $toolsPath -ChildPath 'VERIFICATION.txt'
    Copy-Item -Path $templateFilePath -Destination $verificationFilePath -Force

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_AfterUpdate ($Package) {
    $licenseUri = "https://gitlab.com/$($softwareRepo)/-/raw/$($Latest.Tag)/LICENSE"
    $licenseContents = Invoke-WebRequest -Uri $licenseUri -UseBasicParsing

    $licensePath = Join-Path -Path $toolsPath -ChildPath 'LICENSE.txt'
    Set-Content -Path $licensePath -Value "From: $licenseUri`r`n`r`n$licenseContents"

    #Archive the current source code to prepare for possible redistribution requests, as required by GPLv2
    Get-SourceCode -TagName $Latest.Tag
}

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            '(<packageSourceUrl>)[^<]*(</packageSourceUrl>)' = "`$1https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)`$2"
            '(<licenseUrl>)[^<]*(</licenseUrl>)'             = "`$1https://gitlab.com/$($softwareRepo)/-/blob/$($Latest.Tag)/LICENSE`$2"
            '(<projectSourceUrl>)[^<]*(</projectSourceUrl>)' = "`$1https://gitlab.com/$($softwareRepo)/-/tree/$($Latest.Tag)`$2"
            '(<releaseNotes>)[^<]*(</releaseNotes>)'         = "`$1https://gitlab.com/$($softwareRepo)/-/releases/$($Latest.Tag)`$2"
            '(<copyright>)[^<]*(</copyright>)'               = "`$1Copyright (C) $(Get-Date -Format yyyy) Adam Honse`$2"
        }
        'tools\VERIFICATION.txt'        = @{
            '%installerUrl%'      = "$($Latest.Url64)"
            '%checksumType%'      = "$($Latest.ChecksumType64.ToUpper())"
            '%installerFileName%' = "$($Latest.FileName64)"
            '%checksumValue%'     = "$($Latest.Checksum64)"
        }
        'tools\chocolateyinstall.ps1'   = @{
            '(^[$]fileName\s*=\s*)(''.*'')' = "`$1'$($Latest.FileName64)'"
        }
    }
}

Update-Package -ChecksumFor None -IncludeStream $IncludeStream -NoReadme
