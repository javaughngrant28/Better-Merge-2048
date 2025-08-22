

local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local CollisionGroupUtil = require(game.ReplicatedStorage.Shared.Utils.CollisionGroupUtil)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local CharacterHitbox = require(script.Parent.CharacterHitbox)

local Maid: MaidModule.Maid = MaidModule.new()



local function CharacterSetup(character: Model)
    CollisionGroupUtil.ForModle(character,'Char')
    CharacterHitbox.Create(character)
end

local function onCharacterAdded(player: Player, character: Model)
    Maid[player.Name..'LoadedConnection'] = player.CharacterAppearanceLoaded:Once(CharacterSetup)
    CharacterSetup(character)
end

Observers.observeCharacter(onCharacterAdded)

