-- Swallo Hub Lua
-- UI Library: Fluent or Orion style custom implementation
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Clean up existing UI if any
if CoreGui:FindFirstChild("SwalloHub") then
    CoreGui.SwalloHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwalloHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Red Theme)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Swallo Hub Lua | Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Left Menu (Sidebar)
local LeftMenu = Instance.new("ScrollingFrame")
LeftMenu.Name = "LeftMenu"
LeftMenu.Parent = MainFrame
LeftMenu.Active = true
LeftMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LeftMenu.BorderSizePixel = 0
LeftMenu.Position = UDim2.new(0, 0, 0, 30)
LeftMenu.Size = UDim2.new(0, 140, 1, -30)
LeftMenu.CanvasSize = UDim2.new(0, 0, 1.2, 0)
LeftMenu.ScrollBarThickness = 4

local UIListLayout_Menu = Instance.new("UIListLayout")
UIListLayout_Menu.Parent = LeftMenu
UIListLayout_Menu.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Menu.Padding = UDim.new(0, 5)

-- Right Container (Commands/Content)
local RightContainer = Instance.new("Frame")
RightContainer.Name = "RightContainer"
RightContainer.Parent = MainFrame
RightContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
RightContainer.BorderSizePixel = 0
RightContainer.Position = UDim2.new(0, 140, 0, 30)
RightContainer.Size = UDim2.new(1, -140, 1, -30)

-- Folder for tabs content
local TabsFolder = Instance.new("Folder")
TabsFolder.Name = "TabsFolder"
TabsFolder.Parent = RightContainer

-- Helper function to create toggles with colored box when ON
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = ToggleFrame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.02, 0, 0, 0)
    TextLabel.Size = UDim2.new(0.8, 0, 1, 0)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TextLabel.TextSize = 12
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local BoxButton = Instance.new("TextButton")
    BoxButton.Parent = ToggleFrame
    BoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BoxButton.BorderColor3 = Color3.fromRGB(150, 0, 0)
    BoxButton.Position = UDim2.new(0.88, 0, 0.15, 0)
    BoxButton.Size = UDim2.new(0, 20, 0, 20)
    BoxButton.Text = ""

    local enabled = false
    BoxButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            BoxButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        else
            BoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        pcall(function() callback(enabled) end)
    end)
    
    return ToggleFrame
end

-- Helper function to create Dropdowns
local function createDropdown(parent, title, options, callback)
    local DropFrame = Instance.new("Frame")
    DropFrame.Parent = parent
    DropFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    DropFrame.BorderSizePixel = 0
    DropFrame.Size = UDim2.new(1, 0, 0, 35)

    local Label = Instance.new("TextLabel")
    Label.Parent = DropFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.02, 0, 0, 0)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SelectBtn = Instance.new("TextButton")
    SelectBtn.Parent = DropFrame
    SelectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SelectBtn.BorderSizePixel = 0
    SelectBtn.Position = UDim2.new(0.62, 0, 0.15, 0)
    SelectBtn.Size = UDim2.new(0.35, 0, 0.7, 0)
    SelectBtn.Font = Enum.Font.Gotham
    SelectBtn.Text = "Select..."
    SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SelectBtn.TextSize = 11

    -- Simple selection rotation logic placeholder
    local idx = 1
    SelectBtn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        SelectBtn.Text = options[idx]
        pcall(function() callback(options[idx]) end)
    end)
end

-- Create Tab Content Panels
local tabs = {"Home", "Player", "Main", "Fruit & TP", "Setting", "Webhook"}
local tabFrames = {}

for i, name in ipairs(tabs) do
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = name .. "Frame"
    scrollingFrame.Parent = TabsFolder
    scrollingFrame.Active = true
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    scrollingFrame.ScrollBarThickness = 4
    scrollingFrame.Visible = (i == 1)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = scrollingFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    tabFrames[name] = scrollingFrame

    -- Menu Button on Left
    local MenuBtn = Instance.new("TextButton")
    MenuBtn.Name = name .. "Btn"
    MenuBtn.Parent = LeftMenu
    MenuBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MenuBtn.BorderSizePixel = 0
    MenuBtn.Size = UDim2.new(1, 0, 0, 35)
    MenuBtn.Font = Enum.Font.GothamBold
    MenuBtn.Text = "  " .. name
    MenuBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MenuBtn.TextSize = 12
    MenuBtn.TextXAlignment = Enum.TextXAlignment.Left

    MenuBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        scrollingFrame.Visible = true
    end)
end

----------------------------------------------------------------
-- 1. HOME TAB (Player Statistics)
----------------------------------------------------------------
local homeFrame = tabFrames["Home"]

local function createStatLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = homeFrame
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "  " .. text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

createStatLabel("Username: " .. LocalPlayer.Name)
createStatLabel("Level: [Fetching Data...]")
createStatLabel("Blox Fruit Join Date: [Unknown]")
createStatLabel("Item Limit Inventory: [Loading...]")
createStatLabel("Fruit Inventory: [Loading...]")

----------------------------------------------------------------
-- 2. PLAYER TAB
----------------------------------------------------------------
local playerFrame = tabFrames["Player"]
createToggle(playerFrame, "ESP Fruit", function(v) print("ESP Fruit:", v) end)
createToggle(playerFrame, "ESP Player (Username & Distance)", function(v) print("ESP Player:", v) end)
createToggle(playerFrame, "ESP Boss", function(v) print("ESP Boss:", v) end)
createToggle(playerFrame, "No Clip", function(v)
    RunService.Stepped:Connect(function()
        if v and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end)
createDropdown(playerFrame, "Select Team", {"Pirate", "Marine"}, function(selected)
    print("Selected Team:", selected)
end)

----------------------------------------------------------------
-- 3. MAIN TAB
----------------------------------------------------------------
local mainFrame = tabFrames["Main"]
createToggle(mainFrame, "Auto Farm Blox Fruit", function(v) print("Auto Farm:", v) end)
createDropdown(mainFrame, "Select Farm Method", {"Farm Level", "Bones", "Katakuri"}, function(v) print("Method:", v) end)
createToggle(mainFrame, "Auto Sea 1-2-3", function(v) print("Auto Sea:", v) end)
createToggle(mainFrame, "Auto Farm Mincming Blox Fruit", function(v) print("Auto Mincming:", v) end)
createToggle(mainFrame, "Auto Farm Mastery", function(v) print("Auto Mastery:", v) end)
createToggle(mainFrame, "Auto Farm Material", function(v) print("Auto Material:", v) end)

----------------------------------------------------------------
-- 4. FRUIT & TELEPORT TAB
----------------------------------------------------------------
local tpFrame = tabFrames["Fruit & TP"]
createToggle(tpFrame, "Auto Gacha Random Fruit (Check CD)", function(v) print("Auto Gacha:", v) end)
createToggle(tpFrame, "Auto Store Fruit", function(v) print("Auto Store:", v) end)
createToggle(tpFrame, "Auto Drop Fruit", function(v) print("Auto Drop:", v) end)

createDropdown(tpFrame, "Select NPC", {"Bandit", "Marine", "Factory Staff", "Island Empress"}, function(v) print("NPC:", v) end)
createToggle(tpFrame, "Teleport to NPC (On/Off)", function(v) print("TP NPC Active:", v) end)

createDropdown(tpFrame, "Select Island", {"Old World", "Middle Town", "Marine Fortress", "Floating Turtle"}, function(v) print("Island:", v) end)
createToggle(tpFrame, "Teleport to Island (On/Off)", function(v) print("TP Island Active:", v) end)

createToggle(tpFrame, "Auto Teleport Fruit Spawn", function(v) print("Auto TP Fruit Spawn:", v) end)

----------------------------------------------------------------
-- 5. SETTING TAB
----------------------------------------------------------------
local settingFrame = tabFrames["Setting"]
createToggle(settingFrame, "Boost FPS", function(v)
    if v then
        for _, e in ipairs(game:GetDescendants()) do
            if e:IsA("ParticleEmitter") or e:IsA("Trail") then e.Enabled = false end
        end
    end
end)
createToggle(settingFrame, "Remove Notification", function(v) print("Remove Notif:", v) end)
createToggle(settingFrame, "Setting Config", function(v) print("Config Menu:", v) end)
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

----------------------------------------------------------------
-- 6. WEBHOOK TAB
----------------------------------------------------------------
local webhookFrame = tabFrames["Webhook"]

local UrlBox = Instance.new("TextBox")
UrlBox.Parent = webhookFrame
UrlBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UrlBox.BorderColor3 = Color3.fromRGB(150, 0, 0)
UrlBox.Size = UDim2.new(0.95, 0, 0, 30)
UrlBox.Font = Enum.Font.Gotham
UrlBox.PlaceholderText = "Paste Webhook URL Here..."
UrlBox.Text = ""
UrlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlBox.TextSize = 11

createDropdown(webhookFrame, "Select Rarity Ping", {"Common", "Rare", "Epic", "Legendary", "Mythical"}, function(v) print("Ping Rarity:", v) end)

createStatLabel("--- Webhook Summary Parameters ---")
createStatLabel("• Username: " .. LocalPlayer.Name)
createStatLabel("• Level: [Real Data]")
createStatLabel("• Race: [Active Race]")
createStatLabel("• Fruit Use: [Equipped Fruit]")
createStatLabel("• Item Limit: [Inventory Limit]")

local TestWebhookBtn = Instance.new("TextButton")
TestWebhookBtn.Parent = webhookFrame
TestWebhookBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
TestWebhookBtn.BorderSizePixel = 0
TestWebhookBtn.Size = UDim2.new(0.95, 0, 0, 30)
TestWebhookBtn.Font = Enum.Font.GothamBold
TestWebhookBtn.Text = "Test Webhook & Send Summary"
TestWebhookBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TestWebhookBtn.TextSize = 12

TestWebhookBtn.MouseButton1Click:Connect(function()
    print("Webhook test sent successfully!")
end)
