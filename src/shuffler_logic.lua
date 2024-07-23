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

ModUtil.Path.Wrap("LeaveRoom", function(base, currentRun, door)
    BuildShuffler.saveCurrentBuild()
    BuildShuffler.restoreBuild(BuildShuffler.NextWeapon)
    BuildShuffler.pickNextWeapon()

    base(currentRun, door)
    BuildShuffler.createNextWeaponText(BuildShuffler.NextWeapon)
end)

ModUtil.Path.Wrap("StartOver", function(base, args)
    BuildShuffler.InitializeBuildStore()
    local nextWeapon = BuildShuffler.NextWeapon

    DebugPrint({ Text = "Starting Weapon: " .. nextWeapon })
    EquipPlayerWeapon(WeaponData[nextWeapon])
    EquipWeaponUpgrade(CurrentRun.Hero)
    BuildShuffler.pickNextWeapon()

    base(args)
    BuildShuffler.createNextWeaponText(BuildShuffler.NextWeapon)
end)

ModUtil.Path.Wrap("ChooseRoomReward", function(base, run, room, rewardStoreName, previouslyChosenRewards, args)
    if rewardStoreName == "MetaProgress" then
        rewardStoreName = "MetaProgressReplacements"
        DebugPrint({ Text = "Replacing MetaProgress rewardStore with MetaProgressReplacements" })
    end

    DebugPrint({ Text = "Next reward store: " .. rewardStoreName })

    return base(run, room, rewardStoreName, previouslyChosenRewards, args)
end)

ModUtil.Path.Wrap("UnlockRoomExits", function(base, run, room, delay)
    if BuildShuffler.NextWeapon == nil or CurrentRun.LootTypeHistory == nil then
        base(run, room, delay)
        return
    end

    local currentLootTypeHistory = ShallowCopyTable(CurrentRun.LootTypeHistory)
    local nextLootType = BuildShuffler.getBuild(BuildShuffler.NextWeapon)

    if nextLootType == nil then
        base(run, room, delay)
        return
    end

    local nextLootTypeHistory = ShallowCopyTable(nextLootType.LootTypeHistory)

    CurrentRun.LootTypeHistory = nextLootTypeHistory
    base(run, room, delay)
    CurrentRun.LootTypeHistory = currentLootTypeHistory
end)

ModUtil.Path.Wrap("AttemptRerollDoor", function(base, run, door)
    if BuildShuffler.NextWeapon == nil or CurrentRun.LootTypeHistory == nil then
        base(run, door)
        return
    end

    local currentLootTypeHistory = ShallowCopyTable(CurrentRun.LootTypeHistory)
    local nextLootType = BuildShuffler.getBuild(BuildShuffler.NextWeapon)

    if nextLootType == nil then
        base(run, door)
        return
    end

    local nextLootTypeHistory = ShallowCopyTable(nextLootType.LootTypeHistory)

    CurrentRun.LootTypeHistory = nextLootTypeHistory
    base(run, door)
    CurrentRun.LootTypeHistory = currentLootTypeHistory
end)

local function getFriendlyWeaponName(weaponName)
    if weaponName == nil then
        return "None"
    end

    if weaponName == "WeaponStaffSwing" then
        return "Staff"
    elseif weaponName == "WeaponAxe" then
        return "Axe"
    elseif weaponName == "WeaponDagger" then
        return "Blades"
    elseif weaponName == "WeaponTorch" then
        return "Flames"
    elseif weaponName == "WeaponLob" then
        return "Skull"
    else
        return weaponName
    end
end

function BuildShuffler.createNextWeaponText(nextWeapon)
    local textFormat = DeepCopyTable(UIData.CurrentRunDepth.TextFormat)
    textFormat.Color = Color.White
    textFormat.FontSize = 20
    textFormat.Justification = "Left"
    local text = "Next: " .. getFriendlyWeaponName(nextWeapon)

    if ScreenAnchors["BuildShufflerNextWeapon"] ~= nil then
        ModifyTextBox({ Id = ScreenAnchors["BuildShufflerNextWeapon"], Text = text })
    else
        local x = ScreenWidth * 0.013
        local y = ScreenHeight * 0.075

        ScreenAnchors["BuildShufflerNextWeapon"] = CreateScreenObstacle({ Name = "BlankObstacle", X = x, Y = y, Group = "Combat_Menu_Overlay" })
        CreateTextBox(MergeTables(textFormat, { Id = ScreenAnchors["BuildShufflerNextWeapon"], Text = text }))
    end
end
