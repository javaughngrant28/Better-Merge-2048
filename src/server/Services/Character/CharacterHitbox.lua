
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()

local Hitbox = Instance.new('Part')
Hitbox.Anchored = false
Hitbox.CollisionGroup = 'Hitbox'
Hitbox.Transparency = 0.8
Hitbox.CastShadow = false
Hitbox.CanQuery = false
Hitbox.Name = 'CharacterHitbox'
Hitbox.Size = Vector3.new(4,6,4)
Hitbox.Massless = true

local function CreateHibox(character: Model)
    local hitboxClone = Hitbox:Clone()
    Maid[character.Name] = hitboxClone
    
    local success, err = pcall(function()
        local characterCFrame, characterModelSize = character:GetBoundingBox()
        local rootPart = character:FindFirstChild('HumanoidRootPart') :: Part

        rootPart.Anchored = true
        task.wait()
        hitboxClone.Parent = workspace
        hitboxClone.CFrame = characterCFrame
        hitboxClone.Position += Vector3.new(0,hitboxClone.Size.Y/2,0) - Vector3.new(0,characterModelSize.Y / 2,0)


        local weld = Instance.new('WeldConstraint')
        weld.Parent = hitboxClone
        weld.Part0 = rootPart
        weld.Part1 = hitboxClone

        rootPart.Anchored = false
    end)
    
    if not success then
        warn(err)
    end

    
end


return {
    Create = CreateHibox,
}
