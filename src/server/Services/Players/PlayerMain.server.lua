
local Players = game:GetService("Players")

local MaidModule = require(game.ReplicatedStorage.Shared.Modules.Maid)
local CharacterSetup = require(game.ServerScriptService.Modules.CharacterSetup)

local PlayerAPI = require(game.ServerScriptService.Services.Players.PlayerAPI)

local PLayerLoadedSignal = PlayerAPI.GetPlayerLoadedSignal()






local function onCharacterAdded(character: Model)
    CharacterSetup.Fire(character)
end

local function onPlayerAdded(player: Player)
    local playerLoaded: Instance = player:WaitForChild('FinishedLoading',20)
    if not playerLoaded then return end

    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterAppearanceLoaded:Connect(onCharacterAdded)

    PLayerLoadedSignal:Fire(player)
end

local function onPlayerRemoving(player: Player)
    local playerName = player.Name
    print(playerName)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
