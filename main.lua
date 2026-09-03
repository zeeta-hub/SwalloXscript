-- ==========================================
-- SWALLO HUB LUA - CUSTOM UI (TANPA ORION)
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("SwalloHubCustom") then
    CoreGui.SwalloHubCustom:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwalloHubCustom"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Clean Modern UI)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderColor3 = Color3.fromRGB(180, 0, 0)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 6)

-- Top Bar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 30)

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel", TopBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Swallo Hub - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Floating Toggle Button (Bisa digeser dan untuk Buka/Tutup UI)
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
FloatingBtn.BorderSizePixel = 0
FloatingBtn.Position = UDim2.new(0, 15, 0.5, -20)
FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "Open"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.TextSize = 11
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

-- Left Sidebar Menu
local LeftMenu = Instance.new("ScrollingFrame", MainFrame)
LeftMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
LeftMenu.BorderSizePixel = 0
LeftMenu.Position = UDim2.new(0, 0, 0, 30)
LeftMenu.Size = UDim2.new(0, 140, 1, -30)
LeftMenu.CanvasSize = UDim2.new(0, 0, 1.2, 0)
LeftMenu.ScrollBarThickness = 2

local UIListLayout_Menu = Instance.new("UIListLayout", LeftMenu)
UIListLayout_Menu.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Menu.Padding = UDim.new(0, 3)

-- Right Container Panel
local RightContainer = Instance.new("Frame", MainFrame)
RightContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
RightContainer.BorderSizePixel = 0
RightContainer.Position = UDim2.new(0, 140, 0, 30)
RightContainer.Size = UDim2.new(1, -140, 1, -30)

local TabsFolder = Instance.new("Folder", RightContainer)

-- Helper: Create Toggle Component
local function createToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame", parent)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(0.96, 0, 0, 32)
    
    local Corner = Instance.new("UICorner", ToggleFrame)
    Corner.CornerRadius = UDim.new(0, 4)

    local TextLabel = Instance.new("TextLabel", ToggleFrame)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.04, 0, 0, 0)
    TextLabel.Size = UDim2.new(0.75, 0, 1, 0)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TextLabel.TextSize = 11
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local BoxButton = Instance.new("TextButton", ToggleFrame)
    BoxButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    BoxButton.BorderSizePixel = 0
    BoxButton.Position = UDim2.new(0.85, 0, 0.15, 0)
    BoxButton.Size = UDim2.new(0, 22, 0, 22)
    BoxButton.Text = ""
    
    local BoxCorner = Instance.new("UICorner", BoxButton)
    BoxCorner.CornerRadius = UDim.new(0, 4)

    local enabled = false
    BoxButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        BoxButton.BackgroundColor3 = enabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(50, 50, 60)
        pcall(function() callback(enabled) end)
    end)
    return ToggleFrame
end

-- Setup Tabs System
local tabs = {"Home", "Player", "Auto Farm", "Fruit Settings"}
local tabFrames = {}

for i, name in ipairs(tabs) do
    local scrollingFrame = Instance.new("ScrollingFrame", TabsFolder)
    scrollingFrame.Name = name .. "Frame"
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    scrollingFrame.BorderSizePixel = 0
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 1.4, 0)
    scrollingFrame.ScrollBarThickness = 2
    scrollingFrame.Visible = (i == 1)

    local UIListLayout = Instance.new("UIListLayout", scrollingFrame)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    tabFrames[name] = scrollingFrame

    local MenuBtn = Instance.new("TextButton", LeftMenu)
    MenuBtn.Name = name .. "Btn"
    MenuBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MenuBtn.BorderSizePixel = 0
    MenuBtn.Size = UDim2.new(1, 0, 0, 32)
    MenuBtn.Font = Enum.Font.GothamBold
    MenuBtn.Text = "  " .. name
    MenuBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MenuBtn.TextSize = 11
    MenuBtn.TextXAlignment = Enum.TextXAlignment.Left

    MenuBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        scrollingFrame.Visible = true
    end)
end

-- TAB 1: Home
local homeFrame = tabFrames["Home"]
local function createStatLabel(text)
    local lbl = Instance.new("TextLabel", homeFrame)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(0.96, 0, 0, 25)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = "  " .. text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end
createStatLabel("Username: " .. LocalPlayer.Name)
createStatLabel("Level: [Ready]")

-- TAB 2: Player
local playerFrame = tabFrames["Player"]
createToggle(playerFrame, "No Clip [Contoh]", function(v) print("NoClip:", v) end)

-- TAB 3: Auto Farm
local farmFrame = tabFrames["Auto Farm"]
createToggle(farmFrame, "Enable Auto Farm Level [Contoh]", function(v) print("AutoFarm:", v) end)

-- TAB 4: Fruit Settings
local fruitFrame = tabFrames["Fruit Settings"]
createToggle(fruitFrame, "Auto Roll / Gacha Fruit [Contoh]", function(v) print("Gacha:", v) end)
createToggle(fruitFrame, "Auto Store Fruit [Contoh]", function(v) print("Store:", v) end)
