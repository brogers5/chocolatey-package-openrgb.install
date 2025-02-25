## OpenRGB

One of the biggest complaints about RGB is the software ecosystem surrounding it. Every manufacturer has their own app, their own brand, their own style. If you want to mix and match devices, you end up with a ton of conflicting, functionally identical apps competing for your background resources. On top of that, these apps are proprietary and Windows-only. Some even require online accounts. What if there was a way to control all of your RGB devices from a single app, on both Windows and Linux, without any nonsense? That is what OpenRGB sets out to achieve. One app to rule them all.

![OpenRGB Screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-openrgb.install@4559dfe2a59c5e2a7df1cb69957ab8e5125d4401/Screenshot.png)

### Features

* Set colors and select effect modes for a wide variety of RGB hardware
* Save and load profiles
* Control lighting from third party software using the OpenRGB SDK
* Command line interface
* Connect multiple instances of OpenRGB to synchronize lighting across multiple PCs
* Can operate standalone or in a client/headless server configuration
* View device information
* No official/manufacturer software required
* Graphical view of device LEDs makes creating custom patterns easy

## Package Parameters

* `/NoShim` - Opt out of creating a shim, and removes any existing shim.

## Package Notes

This package may create a [shim](https://docs.chocolatey.org/en-us/features/shim) for `OpenRGB.exe` to facilitate easier access to its command-line interface. However, `shimgen` will create a GUI shim, which will not wait for the underlying process to exit by default. This may cause issues with displaying console output when using the command-line interface. Users requiring this functionality should pass the `--shimgen-waitforexit` switch to ensure the shim behaves correctly.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name="'useRememberedArgumentsForUpgrades'"
```
