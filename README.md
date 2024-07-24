# Hades II Build Shuffler
Hades II Build Shuffler is a gameplay mod for Hades II that allows players to use multiple weapons in a single run, randomly shuffling between them. Each weapon has its own set of boons, requiring you to create and manage multiple builds within a single run.

Every time you enter a room, a random weapon is selected from the weapon pool and given to you. The boons you choose for each weapon are saved and will be re-added every time you get that weapon again. When you switch to another weapon, the boons are removed.
This effectively requires you to manage and create multiple builds in a single run. By default, three random weapons picked from all your unlocked weapons will be added to the weapon pool (this is configurable).

**NOTE:** This mod is in its early stages and may have issues or crashes. Hades II is also in Early Access, so any update may break the mod or cause issues.

**NOTE 2:** This mod has not been tested on the surface yet. It should work, but it might not be as balanced as it should be. Please report any issues you encounter.

**IMPORTANT: Please *disable* the *Transmit Data* setting in the Hades settings menu! Supergiant Games uses the data for balancing and fine-tuning, and the shuffler throws all balancing out of the window, making the data useless for the developers.**

## Features
- **Weapon Shuffling**: Every room, a random weapon is selected from the weapon pool and given to you. It will use the aspects you had equipped before starting the run.
- **Multiple Builds**: Your boons for each build are remembered. They are removed from your player when you switch to a new weapon and restored when you switch back.
- **Balance Changes**: To make sure that you can have enough boons for each build and do not become too weak, all "meta progression" items (Psyche, Ashes, etc.) are replaced with boons, hammers and poms of power. You will also encounter more hammers, ensuring that every weapon can obtain at least one hammer upgrade.
- **God Pool Per Build**: Each weapon has its own god pool. If a god has good boons for one weapon/build, but is bad for another weapon/build, you do not have to worry about picking the god, as it will not be added to the god pool of your other builds.
- **Next Weapon**: You will always be told about the weapon you will get in the next room at the top left of your screen, allowing you to plan around this.
- **Weapon Pool Size**: The amount of weapons in the weapon pool can be configured. By default, only three random weapons are added to the pool. I found this to be the best balance, as adding more weapons made the run more difficult as you obtain fewer boons per weapon.

## Prerequisites
**NOTE**: These aren't needed when using r2modman! If you are using r2modman, you can skip this section.
Before installing the mod, make sure you have the following installed:
1. The latest version of ModImporter: https://www.nexusmods.com/hades2/mods/1
2. The latest version of ModUtil (Put this in your Mods folder): https://github.com/SGG-Modding/ModUtil/releases

Earlier versions of ModImport and ModUtil might not support Hades II, so make sure you are using a recent version!

## Installation
**NOTE**: The instructions below are for ModImporter (or the Nexusmods version). These instructions are NOT for the Thunderstore version of the mod. It is recommended to use the ThunderStore version of this mod as it is easier to install. If you are using the Thunderstore version, you will need to use the fork of the r2modman, which can be found [here](https://github.com/xiaoxiao921/r2modmanPlus/releases). Installation through r2modmanPlus is as easy as just clicking the "Install" button.

**NOTE 2**: Once r2modman (not the fork) supports Hades II and Hell2Modding stabilizes/matures, ModImporter will likely no longer be supported!

1. Download the latest release from the [releases page](https://github.com/Dannyj1/HadesIIBuildShuffler/releases)
2. Extract the ZIP file (right-click and select 'Extract All').
3. In the `Content` folder of your Hades II installation folder (Usually `C:\Program Files (x86)\Steam\steamapps\common\Hades II\Content`), create a mods folder if it doesn't exist yet.
4. Copy the `HadesIIBuildShuffler` folder from the extracted ZIP file to the `mods` folder. You do not need the other files (README, LICENSE), only the `HadesIIBuildShuffler` folder.
5. Open the config.lua file in the HadesIIBuildShuffler folder using a text editor (e.g., Notepad) to change settings if desired.
6. Run ModImporter.
7. Enjoy!

## Configuration
**NOTE**: When using Hell2Modding, the configuration file is located in the `ReturnOfModding/config` folder of your r2modman data folder under the name `Dannyj1-Build_Shuffler.cfg`.

The mod includes a config.lua file to customize settings. Available options are:
- `Enabled`: Set to `true` to enable the mod, set to `false` to disable the mod. Default: `true`.
- `LimitWeaponPool`: Set to `true` to limit the weapon pool size to the amount specified in `LimitWeaponPoolSize`. When this is `false`, all weapons are added to the weapon pool. Default: `true`.
- `LimitWeaponPoolSize`: The amount of weapons in the weapon pool. Can be any number between 2 and 5. Ignored if LimitWeaponPool is set to false. Default: `3`.
- `ExcludedWeapons`: Really dislike a weapon? Add it to this list to exclude it from the weapon pool. Needs to be the exact name as used in the game's code. Valid values: `"WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob"` Default: `{}`.

## Known Issues
None at the moment. Please report any issues you find.

## Roadmap
- Test and balance the mod for the surface. This will likely happen once the area releases.

## I found a bug or my game crashed, what do I do?
Please create an issue ([click here](https://github.com/Dannyj1/HadesIIBuildShuffler/issues/new/choose)) with the following details:
- A detailed and clear description of what you were doing and what exactly happened.
- Any steps to reproduce the bug/crash, if possible.
- (Optional, but very helpful) A video showing the bug, if possible.
- The `Hades II.log` file located at `C:\Users\<Your Username>\Saved Games\Hades II` (location may vary on other operating systems)

## License
Copyright 2024 Danny Jelsma

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
