
local Players = game:GetService("Players")

local MaidModule = require(game.ReplicatedStorage.Shared.Modules.Maid)
local SpawnCharacter = require(game.ServerScriptService.Components.SpawnCharacter)
local Hitbox = require(game.ServerScriptService.Modules.CharacterHitbox)

local PlayerAPI = require(game.ServerScriptService.Services.Players.PlayerAPI)
local FunctionUtil = require(game.ReplicatedStorage.Shared.Utils.FunctionUtil)

local PLayerLoadedSignal = PlayerAPI.GetPlayerLoadedSignal()




local function setCollisions(character: Model)
    if not character then return end
    FunctionUtil.SetCollisionGroup(character,'Char')
end

local function onCharacterAdded(character: Model)
    setCollisions(character)
    Hitbox.Create(character)
end

local function onPlayerAdded(player: Player)
    local playerLoaded: Instance = player:WaitForChild('FinishedLoading',20)
    if not playerLoaded then return end

    player.CharacterAdded:Connect(onCharacterAdded)

    PLayerLoadedSignal:Fire(player)
end

local function onPlayerRemoving(player: Player)
    local playerName = player.Name
    print(playerName)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
