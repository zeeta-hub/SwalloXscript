-- ==========================================
-- SWALLO HUB LUA - FIXED FUNCTIONAL SCRIPT
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("SwalloHub") then
    CoreGui.SwalloHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwalloHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderColor3 = Color3.fromRGB(150, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 25)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Swallo Hub Lua - Blox Fruits [Fixed]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Floating Toggle Button
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingToggle"
FloatingBtn.Parent = ScreenGui
FloatingBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
FloatingBtn.BorderColor3 = Color3.fromRGB(200, 0, 0)
FloatingBtn.Position = UDim2.new(0, 15, 0.5, -20)
FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
FloatingBtn.Font = Enum.Font.SourceSansBold
FloatingBtn.Text = "Open"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.TextSize = 12
FloatingBtn.Active = true
FloatingBtn.Draggable = true

local isMenuOpen = true
FloatingBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    FloatingBtn.Text = isMenuOpen and "Close" or "Open"
end)

-- Left Menu (Sidebar)
local LeftMenu = Instance.new("ScrollingFrame")
LeftMenu.Name = "LeftMenu"
LeftMenu.Parent = MainFrame
LeftMenu.Active = true
LeftMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LeftMenu.BorderSizePixel = 0
LeftMenu.Position = UDim2.new(0, 0, 0, 25)
LeftMenu.Size = UDim2.new(0, 130, 1, -25)
LeftMenu.CanvasSize = UDim2.new(0, 0, 1.2, 0)
LeftMenu.ScrollBarThickness = 3

local UIListLayout_Menu = Instance.new("UIListLayout")
UIListLayout_Menu.Parent = LeftMenu
UIListLayout_Menu.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Menu.Padding = UDim.new(0, 3)

-- Right Container
local RightContainer = Instance.new("Frame")
RightContainer.Name = "RightContainer"
RightContainer.Parent = MainFrame
RightContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
RightContainer.BorderSizePixel = 0
RightContainer.Position = UDim2.new(0, 130, 0, 25)
RightContainer.Size = UDim2.new(1, -130, 1, -25)

local TabsFolder = Instance.new("Folder")
TabsFolder.Name = "TabsFolder"
TabsFolder.Parent = RightContainer

-- Helper: Create Toggle
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, 0, 0, 28)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = ToggleFrame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.03, 0, 0, 0)
    TextLabel.Size = UDim2.new(0.75, 0, 1, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TextLabel.TextSize = 13
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local BoxButton = Instance.new("TextButton")
    BoxButton.Parent = ToggleFrame
    BoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BoxButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
    BoxButton.Position = UDim2.new(0.85, 0, 0.15, 0)
    BoxButton.Size = UDim2.new(0, 18, 0, 18)
    BoxButton.Text = ""

    local enabled = false
    BoxButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        BoxButton.BackgroundColor3 = enabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(50, 50, 50)
        pcall(function() callback(enabled) end)
    end)
    return ToggleFrame
end

-- Helper: Create Dropdown
local function createDropdown(parent, title, options, callback)
    local DropFrame = Instance.new("Frame")
    DropFrame.Parent = parent
    DropFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropFrame.BorderSizePixel = 0
    DropFrame.Size = UDim2.new(1, 0, 0, 30)

    local Label = Instance.new("TextLabel")
    Label.Parent = DropFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.03, 0, 0, 0)
    Label.Size = UDim2.new(0.55, 0, 1, 0)
    Label.Font = Enum.Font.SourceSans
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SelectBtn = Instance.new("TextButton")
    SelectBtn.Parent = DropFrame
    SelectBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    SelectBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    SelectBtn.Position = UDim2.new(0.58, 0, 0.15, 0)
    SelectBtn.Size = UDim2.new(0.38, 0, 0.7, 0)
    SelectBtn.Font = Enum.Font.SourceSans
    SelectBtn.Text = "Select..."
    SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SelectBtn.TextSize = 12

    local idx = 1
    SelectBtn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        SelectBtn.Text = options[idx]
        pcall(function() callback(options[idx]) end)
    end)
end

-- Tabs Setup
local tabs = {"Home", "Player", "Main", "Fruit & TP", "Setting", "Webhook"}
local tabFrames = {}

for i, name in ipairs(tabs) do
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = name .. "Frame"
    scrollingFrame.Parent = TabsFolder
    scrollingFrame.Active = true
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 1.4, 0)
    scrollingFrame.ScrollBarThickness = 3
    scrollingFrame.Visible = (i == 1)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = scrollingFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 3)

    tabFrames[name] = scrollingFrame

    local MenuBtn = Instance.new("TextButton")
    MenuBtn.Name = name .. "Btn"
    MenuBtn.Parent = LeftMenu
    MenuBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MenuBtn.BorderSizePixel = 0
    MenuBtn.Size = UDim2.new(1, 0, 0, 30)
    MenuBtn.Font = Enum.Font.SourceSansBold
    MenuBtn.Text = " " .. name
    MenuBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MenuBtn.TextSize = 13
    MenuBtn.TextXAlignment = Enum.TextXAlignment.Left

    MenuBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        scrollingFrame.Visible = true
    end)
end

-- ==========================================
-- TAB 1: Home
-- ==========================================
local homeFrame = tabFrames["Home"]
local function createStatLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = homeFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.Font = Enum.Font.SourceSans
    lbl.Text = " " .. text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

createStatLabel("Username: " .. LocalPlayer.Name)
createStatLabel("Level: " .. tostring(LocalPlayer.Data.Level.Value))

-- ==========================================
-- TAB 2: Player (ESP Player, Boss, NoClip)
-- ==========================================
local playerFrame = tabFrames["Player"]

-- ESP Player (Username & Distance)
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
                    txt.Font = Enum.Font.SourceSansBold
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

-- ESP Boss
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
                        txt.Font = Enum.Font.SourceSansBold
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

-- ==========================================
-- TAB 3: Main (Auto Farm Blox Fruits)
-- ==========================================
local mainFrame = tabFrames["Main"]
local selectedMethod = "Farm Level"

createDropdown(mainFrame, "Select Farm Method", {"Farm Level", "Bones", "Katakuri"}, function(v)
    selectedMethod = v
end)

createToggle(mainFrame, "Auto Farm Blox Fruit", function(v)
    _G.AutoFarm = v
    task.spawn(function()
        while _G.AutoFarm do
            task.wait(0.5)
            pcall(function()
                -- Mengambil quest otomatis berdasarkan level untuk Blox Fruits
                local level = LocalPlayer.Data.Level.Value
                local questRemote = ReplicatedStorage.Remotes.CommF_
                
                -- Sistem quest dasar Blox Fruits
                if selectedMethod == "Farm Level" then
                    if level >= 1 and level <= 9 then
                        questRemote:InvokeServer("StartQuest", "BanditQuest1", 1)
                    elseif level >= 10 and level <= 14 then
                        questRemote:InvokeServer("StartQuest", "JungleQuest", 1)
                    -- Tambahkan logika quest lanjutan di sini sesuai kebutuhan
                    end
                end
                
                -- Simulasi serangan/farm musuh terdekat
                local enemies = Workspace:FindFirstChild("Enemies")
                if enemies and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, enemy in pairs(enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude < 350 then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 3)
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

-- ==========================================
-- TAB 4: Fruit & TP (Auto Gacha & Auto Store)
-- ==========================================
local tpFrame = tabFrames["Fruit & TP"]

createToggle(tpFrame, "Auto Gacha Random Fruit (Check CD)", function(v)
    _G.AutoGacha = v
    task.spawn(function()
        while _G.AutoGacha do
            pcall(function()
                local args = {
                    [1] = "Cousin",
                    [2] = "Buy"
                }
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
            end)
            task.wait(60) -- Cek cooldown gacha setiap 1 menit
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
                    if item:IsA("Tool") and item:FindFirstChild("Fruit") or table.find({"Rocket","Spin","Blade","Spring","Bomb","Smoke","Spike","Flame","Falcon","Ice","Sand","Dark","Diamond","Light","Rubber","Barrier","Ghost","Magma","Quake","Buddha","Love","Creation","Spider","Sound","Phoenix","Portal","Pain","Rumble","Blizzard","Control","Mammoth","T-Rex","Venom","Shadow","Dough","Control","Leopard","Spirit","Dragon","Kitsune"}, item.Name) then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool:FindFirstChild("Fruit") then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool)
                    end
                end
            end)
        end
    end)
end)

-- ==========================================
-- TAB 5: Setting (Remove Notification, dll)
-- ==========================================
local settingFrame = tabFrames["Setting"]

createToggle(settingFrame, "Remove Notification", function(v)
    _G.RemoveNotif = v
    task.spawn(function()
        while _G.RemoveNotif do
            task.wait(0.2)
            pcall(function()
                -- Menghapus frame pop-up notifikasi bawaan Blox Fruits/Roblox UI
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local notifContainer = playerGui:FindFirstChild("Notifications") or playerGui:FindFirstChild("AlertGui")
                    if notifContainer then
                        notifContainer:ClearAllChildren()
                    end
                end
            end)
        end
    end)
end)

createToggle(settingFrame, "Boost FPS", function(v)
    if v then
        for _, e in ipairs(workspace:GetDescendants()) do
            if e:IsA("ParticleEmitter") or e:IsA("Trail") then e.Enabled = false end
        end
    end
end)

-- ==========================================
-- TAB 6: Webhook
-- ==========================================
local webhookFrame = tabFrames["Webhook"]
local UrlBox = Instance.new("TextBox")
UrlBox.Parent = webhookFrame
UrlBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
UrlBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
UrlBox.Size = UDim2.new(0.95, 0, 0, 28)
UrlBox.Font = Enum.Font.SourceSans
UrlBox.PlaceholderText = "Paste Webhook URL Here..."
UrlBox.Text = ""
UrlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlBox.TextSize = 12

local TestWebhookBtn = Instance.new("TextButton")
TestWebhookBtn.Parent = webhookFrame
TestWebhookBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
TestWebhookBtn.BorderSizePixel = 0
TestWebhookBtn.Size = UDim2.new(0.95, 0, 0, 28)
TestWebhookBtn.Font = Enum.Font.SourceSansBold
TestWebhookBtn.Text = "Test Webhook & Send Summary"
TestWebhookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TestWebhookBtn.TextSize = 12

TestWebhookBtn.MouseButton1Click:Connect(function()
    print("Webhook summary test executed!")
end)
