
local Signal = require(game.ReplicatedStorage.Shared.Modules.Signal)
local CreateSlimeSignal = Signal.new()

local SlimeAPI = {}

function SlimeAPI._GetSlimeAPI()
    return CreateSlimeSignal
end

function SlimeAPI.CreateSlimeAt(slimeValue: number, position: Vector3)
    CreateSlimeSignal:Fire(slimeValue,position)
end

return SlimeAPI