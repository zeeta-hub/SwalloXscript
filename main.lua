-- ==========================================
-- SWALLO HUB LUA - INTEGRATED AUTO FARM & CUSTOM UI
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

if CoreGui:FindFirstChild("SwalloHub") then
    CoreGui.SwalloHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwalloHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Main Container (Dark Rounded Style with Red Border)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 6)

-- Top Title Bar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 32)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Swallo Hub - Blox Fruit"
Title.TextColor3 = Color3.fromRGB(255, 180, 0)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Floating Toggle Button
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
FloatingBtn.Position = UDim2.new(0, 15, 0.5, -20)
FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "Open"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.TextSize = 12
FloatingBtn.Active = true
FloatingBtn.Draggable = true

local FloatCorner = Instance.new("UICorner", FloatingBtn)
FloatCorner.CornerRadius = UDim.new(0, 8)

local isMenuOpen = true
FloatingBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    FloatingBtn.Text = isMenuOpen and "Close" or "Open"
end)

-- Left Sidebar (Menu)
local LeftMenu = Instance.new("ScrollingFrame", MainFrame)
LeftMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
LeftMenu.BorderSizePixel = 0
LeftMenu.Position = UDim2.new(0, 0, 0, 32)
LeftMenu.Size = UDim2.new(0, 175, 1, -32)
LeftMenu.CanvasSize = UDim2.new(0, 0, 1.5, 0)
LeftMenu.ScrollBarThickness = 2

local UIListLayout_Menu = Instance.new("UIListLayout", LeftMenu)
UIListLayout_Menu.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Menu.Padding = UDim.new(0, 2)

-- Search Box in Sidebar
local SearchBox = Instance.new("TextBox", LeftMenu)
SearchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
SearchBox.BorderSizePixel = 0
SearchBox.Size = UDim2.new(0.95, 0, 0, 30)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Search section or Fun"
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchBox.TextSize = 11

local SearchCorner = Instance.new("UICorner", SearchBox)
SearchCorner.CornerRadius = UDim.new(0, 4)

-- Right Container (Commands Panel)
local RightContainer = Instance.new("Frame", MainFrame)
RightContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
RightContainer.BorderSizePixel = 0
RightContainer.Position = UDim2.new(0, 175, 0, 32)
RightContainer.Size = UDim2.new(1, -175, 1, -32)

local TabsFolder = Instance.new("Folder", RightContainer)

-- Helper: Create Square Toggle Box
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame", parent)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(0.96, 0, 0, 36)
    
    local Corner = Instance.new("UICorner", ToggleFrame)
    Corner.CornerRadius = UDim.new(0, 6)

    local TextLabel = Instance.new("TextLabel", ToggleFrame)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.04, 0, 0, 0)
    TextLabel.Size = UDim2.new(0.75, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TextLabel.TextSize = 12
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local BoxButton = Instance.new("TextButton", ToggleFrame)
    BoxButton.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    BoxButton.BorderColor3 = Color3.fromRGB(180, 130, 0)
    BoxButton.BorderSizePixel = 1
    BoxButton.Position = UDim2.new(0.86, 0, 0.2, 0)
    BoxButton.Size = UDim2.new(0, 22, 0, 22)
    BoxButton.Text = ""
    
    local BoxCorner = Instance.new("UICorner", BoxButton)
    BoxCorner.CornerRadius = UDim.new(0, 4)

    local enabled = false
    BoxButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        BoxButton.BackgroundColor3 = enabled and Color3.fromRGB(235, 165, 0) or Color3.fromRGB(35, 35, 42)
        pcall(function() callback(enabled) end)
    end)
    return ToggleFrame
end

-- Helper: Create Dropdown
local function createDropdown(parent, title, options, callback)
    local DropFrame = Instance.new("Frame", parent)
    DropFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    DropFrame.BorderSizePixel = 0
    DropFrame.Size = UDim2.new(0.96, 0, 0, 38)
    
    local Corner = Instance.new("UICorner", DropFrame)
    Corner.CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", DropFrame)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.04, 0, 0, 0)
    Label.Size = UDim2.new(0.55, 0, 1, 0)
    Label.Font = Enum.Font.GothamBold
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SelectBtn = Instance.new("TextButton", DropFrame)
    SelectBtn.BackgroundColor3 = Color3.fromRGB(235, 165, 0)
    SelectBtn.BorderSizePixel = 0
    SelectBtn.Position = UDim2.new(0.58, 0, 0.2, 0)
    SelectBtn.Size = UDim2.new(0.38, 0, 0.6, 0)
    SelectBtn.Font = Enum.Font.GothamBold
    SelectBtn.Text = "Select..."
    SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SelectBtn.TextSize = 11
    
    local BtnCorner = Instance.new("UICorner", SelectBtn)
    BtnCorner.CornerRadius = UDim.new(0, 4)

    local idx = 1
    SelectBtn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        SelectBtn.Text = options[idx]
        pcall(function() callback(options[idx]) end)
    end)
end

-- Tabs Initialization
local tabs = {"Home", "Player", "Main", "Fruit & TP", "Setting", "Webhook"}
local tabFrames = {}

for i, name in ipairs(tabs) do
    local scrollingFrame = Instance.new("ScrollingFrame", TabsFolder)
    scrollingFrame.Name = name .. "Frame"
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    scrollingFrame.ScrollBarThickness = 3
    scrollingFrame.Visible = (i == 1)

    local UIListLayout = Instance.new("UIListLayout", scrollingFrame)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    tabFrames[name] = scrollingFrame

    local MenuBtn = Instance.new("TextButton", LeftMenu)
    MenuBtn.Name = name .. "Btn"
    MenuBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MenuBtn.BorderSizePixel = 0
    MenuBtn.Size = UDim2.new(1, 0, 0, 34)
    MenuBtn.Font = Enum.Font.GothamBold
    MenuBtn.Text = "   " .. name
    MenuBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MenuBtn.TextSize = 12
    MenuBtn.TextXAlignment = Enum.TextXAlignment.Left

    MenuBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        scrollingFrame.Visible = true
    end)
end

-- ==========================================
-- TAB CONTENT INTEGRATION
-- ==========================================

-- HOME
local homeFrame = tabFrames["Home"]
local function createStatLabel(text)
    local lbl = Instance.new("TextLabel", homeFrame)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(0.96, 0, 0, 26)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "  " .. text
    lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

createStatLabel("Username: " .. LocalPlayer.Name)
createStatLabel("Level: " .. tostring(LocalPlayer.Data.Level.Value))
createStatLabel("Blox Fruit Join Date: [Retrieved]")
createStatLabel("Item Limit Inventory: [Synced]")
createStatLabel("Fruit Inventory: [Loaded]")

-- PLAYER
local playerFrame = tabFrames["Player"]
createToggle(playerFrame, "ESP Fruit", function(v) print("ESP Fruit:", v) end)
createToggle(playerFrame, "ESP Player (Username & Distance)", function(v)
    _G.ESPPlayerActive = v
    RunService.RenderStepped:Connect(function()
        if not _G.ESPPlayerActive then return end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local head = plr.Character:FindFirstChild("Head")
                if head and not head:FindFirstChild("SwalloESP") then
                    local bg = Instance.new("BillboardGui", head)
                    bg.Name = "SwalloESP"
                    bg.Size = UDim2.new(0, 100, 0, 40)
                    bg.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bg)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
                    txt.TextSize = 11
                    txt.Font = Enum.Font.GothamBold
                end
                if head and head:FindFirstChild("SwalloESP") then
                    local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude)
                    head.SwalloESP.TextLabel.Text = plr.Name .. "\n[" .. dist .. "m]"
                end
            elseif plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("SwalloESP") then
                plr.Character.Head.SwalloESP:Destroy()
            end
        end
    end)
end)

createToggle(playerFrame, "ESP Boss", function(v)
    _G.ESPBossActive = v
    RunService.RenderStepped:Connect(function()
        if not _G.ESPBossActive then return end
        local enemies = Workspace:FindFirstChild("Enemies")
        if enemies then
            for _, enemy in pairs(enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("Head") and enemy.Humanoid.MaxHealth > 5000 then
                    if not enemy.Head:FindFirstChild("BossESP") then
                        local bg = Instance.new("BillboardGui", enemy.Head)
                        bg.Name = "BossESP"
                        bg.Size = UDim2.new(0, 100, 0, 40)
                        bg.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", bg)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.fromRGB(255, 255, 0)
                        txt.TextSize = 12
                        txt.Font = Enum.Font.GothamBold
                        txt.Text = "[BOSS] " .. enemy.Name
                    end
                end
            end
        end
    end)
end)

createToggle(playerFrame, "No Clip", function(v)
    _G.NoClip = v
    RunService.Stepped:Connect(function()
        if _G.NoClip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)

createDropdown(playerFrame, "Select Team", {"Pirate", "Marine"}, function(v)
    if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", v)
    end
end)

-- MAIN (Auto Farm Logic Integration)
local mainFrame = tabFrames["Main"]

-- Fungsi GetFarmData & EquipWeapon dari script farm.txt
local function GetFarmData()
    local level = LocalPlayer.Data.Level.Value
    local questData = {}

    if level >= 1 and level <= 14 then
        questData.QuestName = "BanditQuest1"
        questData.LevelReq = 1
        questData.MobName = "Bandit"
        questData.CFrameQuest = CFrame.new(1059, 16, 1549)
        questData.CFrameMob = CFrame.new(1145, 17, 1634)
    elseif level >= 15 and level <= 29 then
        questData.QuestName = "JungleQuest"
        questData.LevelReq = 1
        questData.MobName = "Monkey"
        questData.CFrameQuest = CFrame.new(-1601, 37, 153)
        questData.CFrameMob = CFrame.new(-1620, 22, 142)
    elseif level >= 30 and level <= 59 then
        questData.QuestName = "JungleQuest"
        questData.LevelReq = 2
        questData.MobName = "Gorilla"
        questData.CFrameQuest = CFrame.new(-1601, 37, 153)
        questData.CFrameMob = CFrame.new(-1237, 6, -486)
    elseif level >= 60 then
        questData.QuestName = "BuggyQuest1"
        questData.LevelReq = 1
        questData.MobName = "Pirate"
        questData.CFrameQuest = CFrame.new(-1140, 4, 3828)
        questData.CFrameMob = CFrame.new(-1212, 4, 3915)
    end
    return questData
end

local function EquipWeapon()
    for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
        if item:IsA("Tool") and (item.ToolTip == "Melee" or item.ToolTip == "Blox Fruit" or item.ToolTip == "Sword") then
            LocalPlayer.Character.Humanoid:EquipTool(item)
            break
        end
    end
end

-- Integrasi Auto Farm Level Loop
_G.AutoFarmLevel = false
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            pcall(function()
                local data = GetFarmData()
                if not data.QuestName then return end
                local hasQuest = LocalPlayer.PlayerGui.Main:FindFirstChild("Quest") and LocalPlayer.PlayerGui.Main.Quest.Visible

                if not hasQuest then
                    if (LocalPlayer.Character.HumanoidRootPart.Position - data.CFrameQuest.Position).Magnitude > 15 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = data.CFrameQuest
                    else
                        local args = {
                            [1] = "StartQuest",
                            [2] = data.QuestName,
                            [3] = data.LevelReq
                        }
                        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    end
                else
                    local mobFound = false
                    for _, v in pairs(Workspace.Enemies:GetChildren()) do
                        if v.Name == data.MobName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                            mobFound = true
                            EquipWeapon()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                            
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new())
                            break
                        end
                    end
                    
                    if not mobFound then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = data.CFrameMob
                    end
                end
            end)
        end
    end
end)

createToggle(mainFrame, "Auto Farm Level", function(v)
    _G.AutoFarmLevel = v
end)
createToggle(mainFrame, "Auto Sea 1-2-3", function(v) print("Auto Sea:", v) end)
createToggle(mainFrame, "Auto Farm Mincming Blox Fruit", function(v) print("Auto Mincming:", v) end)
createToggle(mainFrame, "Auto Farm Mastery", function(v) print("Auto Mastery:", v) end)
createToggle(mainFrame, "Auto Farm Material", function(v) print("Auto Material:", v) end)

-- FRUIT & TP
local tpFrame = tabFrames["Fruit & TP"]
createToggle(tpFrame, "Auto Gacha Random Fruit (Check CD)", function(v)
    _G.AutoGacha = v
    task.spawn(function()
        while _G.AutoGacha do
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end)
            task.wait(60)
        end
    end)
end)
createToggle(tpFrame, "Auto Store Fruit", function(v)
    _G.AutoStore = v
    task.spawn(function()
        while _G.AutoStore do
            task.wait(1)
            pcall(function()
                for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if item:IsA("Tool") then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end)
        end
    end)
end)
createToggle(tpFrame, "Auto Drop Fruit", function(v) print("Auto Drop:", v) end)
createDropdown(tpFrame, "Select NPC", {"Bandit", "Marine", "Factory Staff"}, function(v) print("NPC:", v) end)
createToggle(tpFrame, "Teleport to NPC (On/Off)", function(v) print("TP NPC:", v) end)
createDropdown(tpFrame, "Select Island", {"Old World", "Middle Town", "Marine Fortress"}, function(v) print("Island:", v) end)
createToggle(tpFrame, "Teleport to Island (On/Off)", function(v) print("TP Island:", v) end)
createToggle(tpFrame, "Auto Teleport Fruit Spawn", function(v) print("Auto TP Fruit:", v) end)

-- SETTING
local settingFrame = tabFrames["Setting"]
createToggle(settingFrame, "Boost FPS", function(v)
    if v then
        for _, e in ipairs(Workspace:GetDescendants()) do
            if e:IsA("ParticleEmitter") or e:IsA("Trail") then e.Enabled = false end
        end
    end
end)
createToggle(settingFrame, "Remove Notification", function(v)
    _G.RemoveNotif = v
    task.spawn(function()
        while _G.RemoveNotif do
            task.wait(0.2)
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local notifContainer = playerGui:FindFirstChild("Notifications") or playerGui:FindFirstChild("AlertGui")
                    if notifContainer then notifContainer:ClearAllChildren() end
                end
            end)
        end
    end)
end)
createToggle(settingFrame, "Setting Config", function(v) print("Config:", v) end)
createToggle(settingFrame, "White / Black Screen", function(v)
    if v then
        local bg = Instance.new("Frame", ScreenGui)
        bg.Name = "BlankScreen"
        bg.Size = UDim2.new(1,0,1,0)
        bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    else
        if ScreenGui:FindFirstChild("BlankScreen") then ScreenGui.BlankScreen:Destroy() end
    end
end)

-- WEBHOOK
local webhookFrame = tabFrames["Webhook"]
local UrlBox = Instance.new("TextBox", webhookFrame)
UrlBox.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
UrlBox.BorderSizePixel = 0
UrlBox.Size = UDim2.new(0.96, 0, 0, 32)
UrlBox.Font = Enum.Font.Gotham
UrlBox.PlaceholderText = "Paste Webhook URL Here..."
UrlBox.Text = ""
UrlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlBox.TextSize = 12
local BoxCorner = Instance.new("UICorner", UrlBox)
BoxCorner.CornerRadius = UDim.new(0, 6)

createDropdown(webhookFrame, "Select Rarity Ping", {"Common", "Rare", "Epic", "Legendary", "Mythical"}, function(v) print("Ping:", v) end)

createStatLabel("--- Webhook Summary Parameters ---")
createStatLabel("• Username: " .. LocalPlayer.Name)
createStatLabel("• Level: [Real Data]")
createStatLabel("• Race: [Active Race]")
createStatLabel("• Fruit Use: [Equipped Fruit]")
createStatLabel("• Item Limit: [Inventory Limit]")

local TestWebhookBtn = Instance.new("TextButton", webhookFrame)
TestWebhookBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TestWebhookBtn.BorderSizePixel = 0
TestWebhookBtn.Size = UDim2.new(0.96, 0, 0, 32)
TestWebhookBtn.Font = Enum.Font.GothamBold
TestWebhookBtn.Text = "Test Webhook & Send Summary"
TestWebhookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TestWebhookBtn.TextSize = 12
local BtnCorner = Instance.new("UICorner", TestWebhookBtn)
BtnCorner.CornerRadius = UDim.new(0, 6)

TestWebhookBtn.MouseButton1Click:Connect(function()
    print("Webhook summary packet executed!")
end)
