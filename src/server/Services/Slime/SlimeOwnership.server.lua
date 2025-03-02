
local BadNetwork = require(game.ReplicatedStorage.Shared.Modules.BadNetwork)
local Network: BadNetwork.Server = BadNetwork.new()

local function Update(player: Player, slime: Model)
    local primaryPart = slime.PrimaryPart
    if not primaryPart then return end

    primaryPart:SetNetworkOwner(player)
end

Network:On('UpdateOwnership',Update)