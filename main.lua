-- Swallo Hub - Blox Fruit (Red Theme & Draggable/Toggleable)
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
MainFrame.Draggable = true -- Membuat UI bisa digeser (Draggable)

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

-- Tombol Close / Minimize di Pojok Kanan Atas
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

-- Konten Area / Sidebar & Panel
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.Active = true
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 160, 1, -35)
Sidebar.CanvasSize = UDim2.new(0, 0, 2, 0)
Sidebar.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Sidebar
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi untuk membuat tombol menu di Sidebar
local function createMenuButton(name, order)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Parent = Sidebar
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.BorderSizePixel = 0
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.Font = Enum.Font.SourceSans
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextSize = 14
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.LayoutOrder = order
	return btn
end

-- Menu Sesuai Gambar
createMenuButton("Farming Other", 1)
createMenuButton("Fruit and Raid, Dunge", 2)
createMenuButton("Sea Event", 3)
createMenuButton("Upgrade Race", 4)
createMenuButton("Get and Upgrade Item", 5)
createMenuButton("Volcano Event", 6)
createMenuButton("ESP", 7)
createMenuButton("PVP", 8)
createMenuButton("Tab Webhook", 9)

-- Container Konten Kanan (Area Fitur Sea Event sebagai contoh)
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.Active = true
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 160, 0, 35)
Container.Size = UDim2.new(1, -160, 1, -35)
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Container.ScrollBarThickness = 6

local ContainerLayout = Instance.new("UIListLayout")
ContainerLayout.Parent = Container
ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContainerLayout.Padding = UDim.new(0, 8)

-- Header Section di dalam Konten
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

-- Tombol Fitur / Toggle dalam List
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

-- Menambahkan elemen menu Sea Event
createSectionHeader("Sea Event Tab")
createToggleFeature("Refresh Player", false)
createToggleFeature("Auto Sea Event With Friend", false)
createToggleFeature("Auto Repair Ur Ship", false)
createToggleFeature("Auto Sea Event", true)
createToggleFeature("Auto Find Mirage", false)

createSectionHeader("Kitsune Event")
createToggleFeature("Teleport To Kitsune Island", false)
createToggleFeature("Hop Server [ Next Night / Full Moon ]", false)

-- Fitur Buka Tutup (Minimize / Open Close) via Tombol Kiri Atas (-) dan Tombol Keyboard (Insert / RightShift)
local isOpen = true
MinimizeButton.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	MainFrame.Visible = isOpen
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Insert then
		isOpen = not isOpen
		MainFrame.Visible = isOpen
	end
end)
