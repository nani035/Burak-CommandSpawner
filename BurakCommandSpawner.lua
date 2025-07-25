-- BurakCommandSpawner.lua | Made by Burak

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote for pet spawn
local spawnPetRemote = ReplicatedStorage:FindFirstChild("SpawnPet") or ReplicatedStorage:WaitForChild("SpawnPet")

-- List of pets
local petList = {
    ["Dragon Fly"] = "Dragon Fly",
    ["Caterpillar"] = "Caterpillar",
    ["Butterfly"] = "Butterfly",
    ["Bee"] = "Bee",
    ["Snail"] = "Snail",
    ["Fire Fly"] = "Fire Fly",
    ["Lady Bug"] = "Lady Bug",
}

-- Change speed and jump
local function setPlayerStats()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 50     -- Fast run
    humanoid.JumpPower = 120    -- High jump
end

-- Spawn pet function
local function spawnPet(petName)
    if petList[petName] then
        spawnPetRemote:FireServer(petList[petName])
        warn("[BurakSpawner] Spawned: " .. petName)
    else
        warn("[BurakSpawner] Invalid Pet: " .. petName)
    end
end

-- Spawn all pets
local function spawnAllPets()
    for petName, _ in pairs(petList) do
        spawnPet(petName)
        wait(0.2)
    end
end

-- Command listener
LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower():sub(1,10) == "/spawnpet " then
        local petName = msg:sub(11)
        spawnPet(petName)
    elseif msg:lower() == "/spawnallpets" then
        spawnAllPets()
    end
end)

-- Apply movement settings once character is loaded
if LocalPlayer.Character then
    setPlayerStats()
end
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    setPlayerStats()
end)-- BurakCommandSpawner.lua | Made by Burak
-- Non-visual pet spawner with /spawnpet and /spawnallpets command

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

-- Fast Run
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            if Humanoid then
                Humanoid.WalkSpeed = 50 -- Normal is 16
            end
        end)
    end
end)

-- Remote reference
local spawnPetRemote = ReplicatedStorage:FindFirstChild("SpawnPet") or ReplicatedStorage:WaitForChild("SpawnPet")

-- List of pets
local petList = {
    ["Dragon Fly"] = "Dragon Fly",
    ["Caterpillar"] = "Caterpillar",
    ["Butterfly"] = "Butterfly",
    ["Bee"] = "Bee",
    ["Snail"] = "Snail",
    ["Fire Fly"] = "Fire Fly",
    ["Lady Bug"] = "Lady Bug",
}

-- Pet spawner function
local function spawnPet(petName)
    if petList[petName] then
        spawnPetRemote:FireServer(petList[petName])
        warn("[BurakSpawner] Spawned: " .. petName)
    else
        warn("[BurakSpawner] Invalid Pet: " .. petName)
    end
end

-- Spawn all pets function
local function spawnAllPets()
    for petName, _ in pairs(petList) do
        spawnPet(petName)
        wait(0.2) -- small delay to avoid overload
    end
end

-- Chat command listener
LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower():sub(1,10) == "/spawnpet " then
        local petName = msg:sub(11)
        spawnPet(petName)
    elseif msg:lower() == "/spawnallpets" then
        spawnAllPets()
    end
end)
