--[[
Copyright 2024 Danny Jelsma

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

if not BuildShuffler.Config.Enabled then
    return
end

BuildShuffler.Builds = nil
BuildShuffler.NextWeapon = nil

local function shouldIgnoreTrait(traitData)
    local traitName = traitData.Name

    if traitData.Slot == "Familiar"
            or traitData.Slot == "Spell"
            or traitData.Slot == "Keepsake"
            or traitData.Slot == "Assist"
            or string.match(string.lower(traitName), "costume")
            or string.match(string.lower(traitName), "maxhealth")
            or string.match(string.lower(traitName), "maxmana")
            or BuildShuffler.tableContains(traitData.InheritFrom, "ShopTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "SpellTalentTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "GiftTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "ChaosBlessing")
            or BuildShuffler.tableContains(traitData.InheritFrom, "ChaosCurse")
            or BuildShuffler.tableContains(traitData.InheritFrom, "ChaosLegacyTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "MetaUpgradeTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "AssistTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "BaseCirce")
            or BuildShuffler.tableContains(traitData.InheritFrom, "InPersonOlympianTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "BaseIcarus")
            or BuildShuffler.tableContains(traitData.InheritFrom, "ManaTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "NarcissusA")
            or BuildShuffler.tableContains(traitData.InheritFrom, "BaseEcho")
            or BuildShuffler.tableContains(traitData.InheritFrom, "SpellTrait")
            or BuildShuffler.tableContains(traitData.InheritFrom, "BiomeState")
    then
        --DebugPrint({ Text = "Ignoring Trait: ".. traitName })
        return true
    end

    --DebugPrint({ Text = "NOT Ignoring Trait: ".. traitName })
    return false
end

function BuildShuffler.InitializeBuildStore()
    BuildShuffler.Builds = { }
    local playerWeapons = ShallowCopyTable(WeaponSets.HeroPrimaryWeapons)

    if BuildShuffler.Config.LimitWeaponPool then
        local maxSize = BuildShuffler.Config.LimitWeaponPoolSize

        while #playerWeapons > maxSize do
            local randomIndex = RandomInt(1, #playerWeapons)

            table.remove(playerWeapons, randomIndex)
        end
    end

    for _, weaponName in ipairs(playerWeapons) do
        if IsWeaponUnlocked(weaponName) and not BuildShuffler.tableContains(BuildShuffler.Config.ExcludedWeapons, weaponName) then
            BuildShuffler.Builds[weaponName] = {
                Traits = { },
                LootTypeHistory = { },
            }
        end
    end

    DebugPrint({ Text = "Eligible Weapons:" })
    DebugPrintTable(BuildShuffler.Builds, true, 0)
    BuildShuffler.pickNextWeapon()
end

function BuildShuffler.saveCurrentBuild()
    if BuildShuffler.Builds == nil then
        BuildShuffler.InitializeBuildStore()
    end

    local equippedWeaponName = GetEquippedWeapon()

    DebugPrint({ Text = "Saving Build: ".. equippedWeaponName })

    local traits = { }

    for _, traitData in pairs(CurrentRun.Hero.Traits) do
        if not shouldIgnoreTrait(traitData) then
            table.insert(traits, traitData)
        end
    end

    BuildShuffler.Builds[equippedWeaponName] = {
        Traits = traits,
        LootTypeHistory = ShallowCopyTable(CurrentRun.LootTypeHistory),
    }
end

function BuildShuffler.restoreBuild(weaponName)
    if BuildShuffler.Builds == nil then
        BuildShuffler.InitializeBuildStore()
    end

    local build = BuildShuffler.Builds[weaponName]

    if build ~= nil then
        local traitsCopy = ShallowCopyTable(CurrentRun.Hero.Traits)

        for _, traitData in pairs(traitsCopy) do
            if not shouldIgnoreTrait(traitData) then
                RemoveTrait(CurrentRun.Hero, traitData.Name)
            end
        end

        if #build.Traits > 0 then
            for _, traitData in pairs(build.Traits) do
                AddTraitToHero({ TraitData = traitData, SkipNewTraitHighlight = true })
            end
        end

        CurrentRun.LootTypeHistory = build.LootTypeHistory
        EquipPlayerWeapon(WeaponData[weaponName])
        EquipWeaponUpgrade(CurrentRun.Hero, {SkipNewTraitHighlight = true })
    else
        DebugPrint({ Text = "No build found for weapon: ".. weaponName })
    end
end

function BuildShuffler.getBuild(weaponName)
    if BuildShuffler.Builds == nil then
        BuildShuffler.InitializeBuildStore()
    end

    return BuildShuffler.Builds[weaponName]
end

local function getEligibleWeapons(excludeWeapon)
    if BuildShuffler.Builds == nil then
        BuildShuffler.InitializeBuildStore()
    end

    local eligibleWeapons = { }

    for weaponName, _ in pairs(BuildShuffler.Builds) do
        if excludeWeapon == nil or weaponName ~= excludeWeapon then
            table.insert(eligibleWeapons, weaponName)
        end
    end

    return eligibleWeapons
end

function BuildShuffler.pickNextWeapon()
    if BuildShuffler.Builds == nil then
        BuildShuffler.InitializeBuildStore()
    end

    local eligibleWeapons
    local excludeWeapon = GetEquippedWeapon()

    eligibleWeapons = getEligibleWeapons(excludeWeapon)

    local randomIndex = RandomInt(1, #eligibleWeapons)
    local newWeapon = eligibleWeapons[randomIndex]

    BuildShuffler.NextWeapon = newWeapon

    DebugPrint({ Text = "Next Weapon: ".. newWeapon })
end
