-- Swallo Hub - Blox Fruit (Red Theme & Floating Toggle Button)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Membuat ScreenGui Utama
local SwalloHub = Instance.new("ScreenGui")
SwalloHub.Name = "SwalloHub"
SwalloHub.Parent = CoreGui
SwalloHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Jendela Utama)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SwalloHub
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

-- Top Bar / Header
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Swallo Hub - Blox Fruit"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Minimize di Pojok Kanan Atas
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Size = UDim2.new(0, 30, 0, 25)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18

-- Tombol Bundar Mengambang (Floating Toggle Button) saat UI ditutup
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = SwalloHub
OpenButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
OpenButton.BorderSizePixel = 0
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Text = "SW"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextSize = 16
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true

-- Membuat bentuk tombol jadi bundar sempurna
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = OpenButton

-- Sidebar / Menu Utama (Hanya ada Home)
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.Active = true
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 160, 1, -35)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Sidebar
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Tombol Menu "Home"
local HomeBtn = Instance.new("TextButton")
HomeBtn.Name = "Home"
HomeBtn.Parent = Sidebar
HomeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
HomeBtn.BorderSizePixel = 0
HomeBtn.Size = UDim2.new(1, 0, 0, 35)
HomeBtn.Font = Enum.Font.SourceSansBold
HomeBtn.Text = "  Home"
HomeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
HomeBtn.TextSize = 14
HomeBtn.TextXAlignment = Enum.TextXAlignment.Left

-- Container Konten Kanan untuk Menu Home
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.Active = true
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 160, 0, 35)
Container.Size = UDim2.new(1, -160, 1, -35)
Container.CanvasSize = UDim2.new(0, 0, 1, 0)
Container.ScrollBarThickness = 6

local ContainerLayout = Instance.new("UIListLayout")
ContainerLayout.Parent = Container
ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContainerLayout.Padding = UDim.new(0, 8)

-- Header Section di Menu Home
local function createSectionHeader(text)
	local label = Instance.new("TextLabel")
	label.Parent = Container
	label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	label.BorderSizePixel = 0
	label.Size = UDim2.new(1, 0, 0, 30)
	label.Font = Enum.Font.SourceSansBold
	label.Text = "  " .. text
	label.TextColor3 = Color3.fromRGB(255, 100, 100)
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
end

-- Elemen Konten / Fitur Home
local function createToggleFeature(text, defaultState)
	local frame = Instance.new("Frame")
	frame.Parent = Container
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Size = UDim2.new(1, 0, 0, 40)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.8, 0, 1, 0)
	label.Font = Enum.Font.SourceSansBold
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Parent = frame
	toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 50, 50)
	toggleBtn.Position = UDim2.new(1, -45, 0.5, -12)
	toggleBtn.Size = UDim2.new(0, 35, 0, 24)
	toggleBtn.Text = ""
	
	local active = defaultState
	toggleBtn.MouseButton1Click:Connect(function()
		active = not active
		toggleBtn.BackgroundColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(50, 50, 50)
	end)
end

createSectionHeader("Welcome to Swallo Hub")
createToggleFeature("Main Status Active", true)
createToggleFeature("Auto Collect Chest", false)

-- Fungsi Buka Tutup UI & Munculkan Tombol Bundar
local isOpen = true

local function toggleUI()
	isOpen = not isOpen
	MainFrame.Visible = isOpen
	OpenButton.Visible = not isOpen
end

MinimizeButton.MouseButton1Click:Connect(toggleUI)
OpenButton.MouseButton1Click:Connect(toggleUI)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Insert then
		toggleUI()
	end
end)
