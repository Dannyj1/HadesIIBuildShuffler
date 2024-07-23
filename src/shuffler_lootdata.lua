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

BuildShuffler.MetaProgressReplacements = {
    {
        Name = "StackUpgrade",
        GameStateRequirements = {
            NamedRequirements = { "StackUpgradeLegal", },
            {
                Path = { "CurrentRun", "LootTypeHistory" },
                CountOf = {
                    "AphroditeUpgrade",
                    "ApolloUpgrade",
                    "DemeterUpgrade",
                    "HephaestusUpgrade",
                    "HestiaUpgrade",
                    "HeraUpgrade",
                    "PoseidonUpgrade",
                    "ZeusUpgrade",
                },
                Comparison = ">=",
                Value = 1,
            },
        }
    },
    {
        Name = "WeaponUpgrade",
        GameStateRequirements = {
            NamedRequirements = { "HammerLootRequirements" },
            {
                Path = { "CurrentRun", "LootTypeHistory" },
                CountOf = {
                    "AphroditeUpgrade",
                    "ApolloUpgrade",
                    "DemeterUpgrade",
                    "HephaestusUpgrade",
                    "HestiaUpgrade",
                    "HeraUpgrade",
                    "PoseidonUpgrade",
                    "ZeusUpgrade",
                },
                Comparison = ">=",
                Value = 1,
            },
        }
    },
    {
        Name = "WeaponUpgrade",
        GameStateRequirements = {
            NamedRequirements = { "LateHammerLootRequirements" },
            {
                Path = { "CurrentRun", "LootTypeHistory" },
                CountOf = {
                    "AphroditeUpgrade",
                    "ApolloUpgrade",
                    "DemeterUpgrade",
                    "HephaestusUpgrade",
                    "HestiaUpgrade",
                    "HeraUpgrade",
                    "PoseidonUpgrade",
                    "ZeusUpgrade",
                },
                Comparison = ">=",
                Value = 1,
            },
        }
    },
    {
        Name = "HermesUpgrade",
        GameStateRequirements = {
            -- unlock requirements
            {
                PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
            },
            {
                Path = { "GameState", "TextLinesRecord" },
                HasAll = { "HermesFirstPickUp", "PoseidonLegacyBoonIntro01" },
            },

            -- run requirements
            RequiredNotInStore = "ShopHermesUpgrade",
            {
                Path = { "CurrentRun", "BiomeUseRecord", },
                HasNone = { "HermesUpgrade", "ShopHermesUpgrade", },
            },
            {
                Path = { "CurrentRun", "EncounterDepth" },
                Comparison = ">=",
                Value = 8,
            },
            {
                Path = { "CurrentRun", "LootTypeHistory", "HermesUpgrade" },
                Comparison = "<=",
                Value = 1,
            },

        }
    },
    {
        Name = "Devotion",
        GameStateRequirements = {
            -- unlock requirements
            NamedRequirements = { "DevotionTestUnlocked", },

            -- run requirements
            {
                Path = { "CurrentRun", "EncounterDepth" },
                Comparison = ">=",
                Value = 7,
            },
            {
                Path = { "CurrentRun", "BiomeEncounterDepth" },
                Comparison = ">=",
                Value = 2,
            },
            {
                Path = { "CurrentRun", "LootTypeHistory" },
                CountOf = {
                    "AphroditeUpgrade",
                    "ApolloUpgrade",
                    "DemeterUpgrade",
                    "HephaestusUpgrade",
                    "HestiaUpgrade",
                    "HeraUpgrade",
                    "PoseidonUpgrade",
                    "ZeusUpgrade",
                },
                Comparison = ">=",
                Value = 2,
            },
            RequiredMinRoomsSinceDevotion = 15,
            RequiredMinExits = 2,
        }
    },
    {
        Name = "Boon",
        AllowDuplicates = true,
        GameStateRequirements = {
            -- None
        },
    },
    {
        Name = "Boon",
        AllowDuplicates = true,
        GameStateRequirements = {
            -- None
        },
    },
    {
        Name = "Boon",
        AllowDuplicates = true,
        GameStateRequirements = {
            -- None
        },
    },
}

ModUtil.LoadOnce(function()
    RewardStoreData.MetaProgressReplacements = DeepCopyTable(BuildShuffler.MetaProgressReplacements)

    if CurrentRun ~= nil then
        InitializeRewardStores(CurrentRun)
    end
end)
