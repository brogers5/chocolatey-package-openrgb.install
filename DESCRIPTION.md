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
* `/DontCheckForPawnIO` - By default, the package installation will check if [PawnIO](https://community.chocolatey.org/packages/pawnio) is installed on your system, and prompt you to install it if it is missing. If your configuration is either incompatible or does not require PawnIO, pass this to skip over the check.

## Package Notes

As of 1.0.0rc2, OpenRGB now depends on [PawnIO](https://community.chocolatey.org/packages/pawnio) to interface with I2C and SMBus devices, which may be required for compatibility with some graphics cards, RAM modules and motherboards. OpenRGB normally requires running as Administrator in order for PawnIO access to work correctly.

If this behavior is undesired, OpenRGB's installer can optionally create and start a service application to enable OpenRGB to work correctly without elevation. Users can opt into this via the installer's `OpenRGBRegisterService` feature:

```console
choco install openrgb.install --install-arguments="'ADDLOCAL=OpenRGBApplication,OpenRGBRegisterService'"
```

Note that this depends on the standard `OpenRGBApplication` feature, which should also be included in the desired feature list.

---

This package may create a [shim](https://docs.chocolatey.org/en-us/features/shim) for `OpenRGB.exe` to facilitate easier access to its command-line interface. However, `shimgen` will create a GUI shim, which will not wait for the underlying process to exit by default. This may cause issues with displaying console output when using the command-line interface. Users requiring this functionality should pass the `--shimgen-waitforexit` switch to ensure the shim behaves correctly.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name="'useRememberedArgumentsForUpgrades'"
```
