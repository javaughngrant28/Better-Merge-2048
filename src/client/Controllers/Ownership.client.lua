local Players = game:GetService("Players")
local player = Players.LocalPlayer

local CharacterEvents = require(script.Parent.Parent.Components.CharacterEvents)
local MaidModule = require(game.ReplicatedStorage.Shared.Modules.Maid)
local BadNetwork = require(game.ReplicatedStorage.Shared.Modules.BadNetwork)

local Maid: MaidModule.Maid = MaidModule.new()
local network: BadNetwork.Client = BadNetwork.new()

local slimeFolder: Folder = game.Workspace.Slimes

local SpawnTime = nil
local JustSpawned = true
local TimerThread = nil

local debounce = false
local debounceTime = 0.4



local function ConnnectToTouchEvent(slime: Model)
    if not JustSpawned then return end
    local hitbox = slime.PrimaryPart
    
    Maid[slime] = hitbox.Touched:Connect(function(hit: Part)
        if not player.Character then return end
        if hit.Parent ~= player.Character then return end
        if debounce then return end
        debounce = true
        
        network:Fire('UpdateOwnership', slime)
        
        task.wait(debounceTime)
        debounce = false
    end)
end

local function onRemoving()
    Maid:DoCleaning()
end

local function StartSpawnTime()
    if TimerThread then
        task.cancel(TimerThread)
    end

    TimerThread = task.spawn(function()
        SpawnTime = tick()

        while JustSpawned do
            task.wait(1)
            JustSpawned = (tick() - SpawnTime) < 30
        end

    end)
end

CharacterEvents.Spawn(function()
    if JustSpawned then
        StartSpawnTime()
    end

    for _, slime in slimeFolder:GetChildren() do
        ConnnectToTouchEvent(slime)
    end

    Maid['Sime Added'] = slimeFolder.ChildAdded:Connect(ConnnectToTouchEvent)
end)

CharacterEvents.Removing(onRemoving)