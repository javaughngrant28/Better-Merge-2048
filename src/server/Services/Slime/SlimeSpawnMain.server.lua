
local SpawnFolder = game.Workspace.Slimes
local SpawnPart = game.ReplicatedStorage.Spawn

local RandomChance = require(game.ReplicatedStorage.Shared.Modules.RandomChance)

local Slimes:  {Model} = {}
local Max = 20

local SpawnChance = {
    [`1`] = 68,
    [`2`] = 32,
    [`3`] = 2
}

local function GetCFrameFormPart(part: Part): CFrame
    local size = part.Size
    local position = part.Position

    local randomOffset = Vector3.new(
            math.random() * size.X - size.X / 2,
            math.random() * size.Y - size.Y / 2,
            math.random() * size.Z - size.Z / 2
        )
    
        return CFrame.new(position + randomOffset)
end


local function SpawnSlime(value: number)
    print(value)
    local slimeClone = Slimes[value]:Clone()
    slimeClone.Parent = SpawnFolder

    local spawnCFrame = GetCFrameFormPart(SpawnPart) :: CFrame

    task.defer(workspace.PivotTo, slimeClone, spawnCFrame)
end

local function BatchSpawn(number)
    for _ = 1, number do
        local value = unpack(RandomChance.GetResults(SpawnChance,1))
        SpawnSlime(tonumber(value))
    end
end


for _, SlimeModel: Model in game.ReplicatedStorage.Assets.Slimes:GetChildren() do
    local attributes = SlimeModel:GetAttributes()
    local bounce = attributes['Bounce']
    local value = attributes['Value']

    assert(bounce,`{SlimeModel}: Does not have bounce attribute`)
    assert(value,`{SlimeModel}: Does not have value attribute`)

    Slimes[value] = SlimeModel
end

BatchSpawn(Max)