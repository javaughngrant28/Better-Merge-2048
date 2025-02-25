
local AttachedPartName = 'UpperTorso'
local HitboxSize = Vector3.new(4,4,2)


local function CreatePart(): Part
    local part = Instance.new('Part')
    part.Name = 'Hitbox'
    part.Size = HitboxSize
    part.Transparency = 1
    part.Massless = true
    part.CollisionGroup = 'Hitbox'
    return part
end

local function CreateWeldConstraint(p0: Part, p1: Part): WeldConstraint
    local weldConstraint = Instance.new('WeldConstraint')
    weldConstraint.Part0 = p0
    weldConstraint.Part1 = p1
    return weldConstraint
end

local CharacterHibox = {}

function CharacterHibox.Create(character: Model)
    local torso = character:WaitForChild(AttachedPartName,2) :: Part
    assert(torso,`{AttachedPartName} Not A Valid Memeber OF {character}`)

    local hitbox = CreatePart()
    hitbox.CFrame = torso.CFrame
    hitbox.Parent = character

    local weldConstraint = CreateWeldConstraint(torso,hitbox)
    weldConstraint.Parent = hitbox
end

return CharacterHibox