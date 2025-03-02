local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local CharacterEvents = require(script.Parent.Parent.Components.CharacterEvents)
local MaidModule = require(game.ReplicatedStorage.Shared.Modules.Maid)
local SoundUtil = require(game.ReplicatedStorage.Shared.Utils.SoundUtil)

local sound = game.ReplicatedStorage.Assets.Sounds.Bounce

local Maid: MaidModule.Maid = MaidModule.new()


local CollisionGroupName = 'Char'
local raycastParams = RaycastParams.new()
raycastParams.CollisionGroup = CollisionGroupName
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local debouce = false
local debouceTime = 0.2

local function Jump(power: number)
    if debouce then return end
    debouce = true

    local character = Players.LocalPlayer.Character
    local rootPart = character.HumanoidRootPart

    rootPart.AssemblyLinearVelocity = Vector3.zero
    rootPart.AssemblyLinearVelocity = Vector3.new(0,power * .1,0) * rootPart.AssemblyMass
    
    SoundUtil.PlayFromPlayerCharacter(character,sound)
    
    task.wait(debouceTime)
    debouce = false
end

local function JumpRequest()
    if debouce then return end
    local rayOrigin = Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position
    local rayDirection = Vector3.new(0, -8, 0)

    local raycastResult = Workspace:Raycast(rayOrigin, rayDirection)
    if not raycastResult then return end

    local instance: Instance? = raycastResult.Instance

    if not instance or not instance.Parent:IsA('Model') then
        return
    end

    local attributes = instance.Parent:GetAttributes()
    local bounceAttribute = attributes['Bounce']

    if not bounceAttribute then return end

    Jump(bounceAttribute)
end

CharacterEvents.Spawn(function(character)
    local humanoid: Humanoid = character:FindFirstChild('Humanoid')
    Maid['StateChanged'] = humanoid.StateChanged:Connect(function(_,currentState)
        if currentState ~= Enum.HumanoidStateType.Landed then return end
        JumpRequest()
    end)
end)

UserInputService.JumpRequest:Connect(JumpRequest)