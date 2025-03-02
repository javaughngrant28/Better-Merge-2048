
local MaidModule = require(game.ReplicatedStorage.Shared.Modules.Maid)
local SlimeAPI = require(game.ServerScriptService.Services.Slime.SlimeAPI)

local Maid: MaidModule.Maid = MaidModule.new()

local SlimeFolder: Folder = game.Workspace.Slimes

local function Merge(slime1: Model, slime2: Model, value: number)
    if not slime1 or not slime1.Parent or not slime1.PrimaryPart then return end
    slime2:Destroy()

    local slime1Position: Vector3 = slime1.PrimaryPart.CFrame.Position
    slime1:Destroy()

    SlimeAPI.CreateSlimeAt(value + 1, slime1Position + Vector3.new(0,4,0))
end

local function Connect(slime: Model)
    local hitbox: Part = slime.PrimaryPart
    if not hitbox then return end

    local slimeValue = slime:GetAttribute('Value')

    Maid[slime] = hitbox.Touched:Connect(function(hit)
        if not hit.Parent then return end

        local attributes = hit.Parent:GetAttributes()
        local value = attributes['Value']

        if not value then return end
        if value ~= slimeValue then return end

        Merge(slime, hit.Parent, value)
    end)
end

for _, slime: Model in SlimeFolder:GetChildren() do
    Connect(slime)
end

SlimeFolder.ChildAdded:Connect(Connect)