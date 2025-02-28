local FunctionUtil = require(game.ReplicatedStorage.Shared.Utils.FunctionUtil)

local function setCollisions(character: Model)
    if not character then return end
    FunctionUtil.SetCollisionGroup(character,'Char')
end

local function IncressCharacterMass(character: Model)
    for _, part: Part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CustomPhysicalProperties = PhysicalProperties.new(20, 0.5, 1,0.3,1)
        end
    end
end

local function UpdateTouchPros(character: Model)
    local ignoreParts = {'HumanoidRootPart','LeftFoot','RightFoot'}
    for _, part: Part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and not table.find(ignoreParts,part.Name)  then
            part.CanQuery = false
            part.CanTouch = false
        end
    end
end


local CharacterSetup = {}


function CharacterSetup.Fire(character: Model)
    setCollisions(character)
    IncressCharacterMass(character)
    UpdateTouchPros(character)
end

return CharacterSetup