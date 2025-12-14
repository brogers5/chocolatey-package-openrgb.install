<!--markdownlint-disable-next-line MD033 MD045 -->
# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-openrgb.install@4559dfe2a59c5e2a7df1cb69957ab8e5125d4401/openrgb.install.png" width="48" height="48" alt="OpenRGB (Install) icon"/> Chocolatey Package: [OpenRGB (Install)](https://community.chocolatey.org/packages/openrgb.install)

[![Latest package version shield](https://img.shields.io/chocolatey/v/openrgb.install.svg?include_prereleases)](https://community.chocolatey.org/packages/openrgb.install)
[![Total package download count shield](https://img.shields.io/chocolatey/dt/openrgb.install.svg)](https://community.chocolatey.org/packages/openrgb.install)

---

This package is part of a family of packages published for OpenRGB. This repository is for the installer package.

* For the meta package, see [chocolatey-package-openrgb](https://github.com/brogers5/chocolatey-package-openrgb).
* For the portable package, see [chocolatey-package-openrgb.portable](https://github.com/brogers5/chocolatey-package-openrgb.portable).

See the [Chocolatey FAQs](https://docs.chocolatey.org/en-us/faqs) for more information on [meta packages](https://docs.chocolatey.org/en-us/faqs/#what-is-the-difference-between-packages-no-suffix-as-compared-to-install-portable) and [installer/portable packages](https://docs.chocolatey.org/en-us/faqs#what-distinction-does-chocolatey-make-between-an-installable-and-a-portable-application).

---

## Install

[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved stable version from the Chocolatey Community Repository:

```shell
choco install openrgb.install --source="'https://community.chocolatey.org/api/v2'"
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-openrgb.install/releases). The `nupkg` can be installed from the current directory (with dependencies sourced from the Community Repository) as follows:

```shell
choco install openrgb.install --source="'.;https://community.chocolatey.org/api/v2/'"
```

This package also supports the project's Release Candidate builds. Opt into these with the `--prerelease` switch.

## Build

[Install Chocolatey](https://chocolatey.org/install), and the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au), then clone this repository.

Once cloned, simply run `build.ps1`. The MSI is intentionally untracked to avoid bloating the repository, so the script will download the OpenRGB installer MSI from the official distribution point, then packs everything together.

A successful build will create `openrgb.install.x.y.z.nupkg`, where `x.y.z` should be the Nuspec's normalized `version` value at build time.

>[!Note]
>Chocolatey package builds are non-deterministic. Consequently, an independently built package's checksum will not match that of the officially published package.

## Update

This package should be automatically updated by the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au). If it is outdated by more than a few days, please [open an issue](https://github.com/brogers5/chocolatey-package-openrgb.install/issues).

AU expects the parent directory that contains this repository to share a name with the Nuspec (`openrgb.install`). Your local repository should therefore be cloned accordingly:

```shell
git clone git@github.com:brogers5/chocolatey-package-openrgb.install.git openrgb.install
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):

```shell
mklink /J openrgb.install ..\chocolatey-package-openrgb.install
```

Once created, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

To limit the scope of update checks to a specific update channel, pass the `-IncludeStream` parameter with the desired Stream name:

```powershell
.\update.ps1 -IncludeStream 'Stable'
```

```powershell
.\update.ps1 -IncludeStream 'ReleaseCandidate'
```

```powershell
.\update.ps1 -IncludeStream 'ReleaseCandidateWinRing0'
```

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) using the latest [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
