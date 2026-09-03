-- ==========================================
-- SWALLO HUB LUA - UPDATED WITH ORION UI & FARM_2
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Anti AFK[cite: 3]
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Load Orion UI Library[cite: 3]
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Swallo Hub - Blox Fruits", HidePremium = false, SaveConfig = false, ConfigFolder = "SwalloHub"})

-- Global Variable Auto Farm[cite: 3]
_G.AutoFarmLevel = false

-- Function 1: Otomatis Pegang Fighting Style / Melee[cite: 3]
function EquipFightingStyle()
    pcall(function()
        if LocalPlayer.Character:FindFirstChildOfClass("Tool") and LocalPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Melee" then
            return
        end
        for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
            if item:IsA("Tool") and item.ToolTip == "Melee" then
                LocalPlayer.Character.Humanoid:EquipTool(item)
                break
            end
        end
    end)
end

-- Function 2: Database Level, Quest NPC, dan Mob (First Sea)[cite: 3]
function GetQuestAndMobData()
    local lvl = LocalPlayer.Data.Level.Value
    local data = {}

    if lvl >= 1 and lvl <= 14 then
        data.QuestName = "BanditQuest1"; data.LevelReq = 1; data.MobName = "Bandit"
        data.QuestPos = CFrame.new(1059, 16, 1549); data.MobPos = CFrame.new(1145, 17, 1634)
    elseif lvl >= 15 and lvl <= 29 then
        data.QuestName = "JungleQuest"; data.LevelReq = 1; data.MobName = "Monkey"
        data.QuestPos = CFrame.new(-1601, 37, 153); data.MobPos = CFrame.new(-1620, 22, 142)
    elseif lvl >= 30 and lvl <= 59 then
        data.QuestName = "JungleQuest"; data.LevelReq = 2; data.MobName = "Gorilla"
        data.QuestPos = CFrame.new(-1601, 37, 153); data.MobPos = CFrame.new(-1237, 6, -486)
    elseif lvl >= 60 and lvl <= 89 then
        data.QuestName = "BuggyQuest1"; data.LevelReq = 1; data.MobName = "Pirate"
        data.QuestPos = CFrame.new(-1140, 4, 3828); data.MobPos = CFrame.new(-1212, 4, 3915)
    elseif lvl >= 90 and lvl <= 119 then
        data.QuestName = "DesertQuest"; data.LevelReq = 1; data.MobName = "Desert Bandit"
        data.QuestPos = CFrame.new(894, 6, 4385); data.MobPos = CFrame.new(932, 6, 4484)
    elseif lvl >= 120 and lvl <= 149 then
        data.QuestName = "SnowQuest"; data.LevelReq = 1; data.MobName = "Snow Bandit"
        data.QuestPos = CFrame.new(1385, 87, -1298); data.MobPos = CFrame.new(1289, 105, -1442)
    elseif lvl >= 150 then
        data.QuestName = "MarineQuest2"; data.LevelReq = 1; data.MobName = "Chief Marine"
        data.QuestPos = CFrame.new(-5036, 28, 4325); data.MobPos = CFrame.new(-4830, 21, 4299)
    end

    return data
end

-- Function 3: Main Loop Auto Farm[cite: 3]
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            pcall(function()
                local farmData = GetQuestAndMobData()
                if not farmData.QuestName then return end
                local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible

                if not hasQuest then
                    if (LocalPlayer.Character.HumanoidRootPart.Position - farmData.QuestPos.Position).Magnitude > 15 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = farmData.QuestPos
                    else
                        local args = { [1] = "StartQuest", [2] = farmData.QuestName, [3] = farmData.LevelReq }
                        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    end
                else
                    EquipFightingStyle()

                    local mobTarget = nil
                    for _, v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == farmData.MobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                            mobTarget = v
                            break
                        end
                    end

                    if mobTarget then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = mobTarget.HumanoidRootPart.CFrame * CFrame.new(0, 6.5, 0)
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new())
                    else
                        LocalPlayer.Character.HumanoidRootPart.CFrame = farmData.MobPos
                    end
                end
            end)
        end
    end
end)

-- Tabs Setup Sesuai Permintaan (Hanya Home, Player, Main)
local HomeTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

HomeTab:AddLabel("Username: " .. LocalPlayer.Name)
HomeTab:AddLabel("Level: " .. tostring(LocalPlayer.Data.Level.Value))

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(v)
        _G.NoClip = v
        game:GetService("RunService").Stepped:Connect(function()
            if _G.NoClip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
})

PlayerTab:AddDropdown({
    Name = "Select Team",
    Default = "Pirate",
    Options = {"Pirate", "Marine"},
    Callback = function(v)
        if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", v)
        end
    end
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Enable Auto Farm & Fighting Style",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
    end    
})

OrionLib:Init()
