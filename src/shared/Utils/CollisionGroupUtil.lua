
local function SetModleCollisionGroup(model: Model, collisionGroupName: string)
    for _, descendant: BasePart in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
           descendant.CollisionGroup = collisionGroupName
        end
    end
end

return {
    ForModle = SetModleCollisionGroup,
}
