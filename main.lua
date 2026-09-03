-- Swallo Hub - Blox Fruit (Banana Hub UI Style & Red Theme)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Membuat ScreenGui Utama
local SwalloHub = Instance.new("ScreenGui")
SwalloHub.Name = "SwalloHub"
SwalloHub.Parent = CoreGui
SwalloHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Mirip layout Banana Hub: Search bar kiri atas, Sidebar menu di kiri, Container di kanan)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SwalloHub
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
MainFrame.BorderColor3 = Color3.fromRGB(40, 50, 70)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true

-- Garis Aksen Border Merah Tipis di Luar / Dalam
local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(255, 0, 0)
MainStroke.Thickness = 1.5

-- Top Bar Mini / Judul Hub di atas Search Bar
local TopBarInfo = Instance.new("Frame")
TopBarInfo.Name = "TopBarInfo"
TopBarInfo.Parent = MainFrame
TopBarInfo.BackgroundTransparency = 1
TopBarInfo.Size = UDim2.new(1, 0, 0, 30)

local HubTitle = Instance.new("TextLabel")
HubTitle.Name = "HubTitle"
HubTitle.Parent = TopBarInfo
HubTitle.BackgroundTransparency = 1
HubTitle.Position = UDim2.new(0, 15, 0, 0)
HubTitle.Size = UDim2.new(0, 300, 1, 0)
HubTitle.Font = Enum.Font.SourceSansBold
HubTitle.Text = "Swallo Hub - Blox Fruit"
HubTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
HubTitle.TextSize = 15
HubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close / Minimize di Pojok Kanan Atas
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBarInfo
MinimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Size = UDim2.new(0, 25, 0, 20)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeButton

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

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

-- Panel Kiri (Sidebar mirip Banana Hub: Ada kolom Search di bagian atas menu)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 16, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.Size = UDim2.new(0, 180, 1, -30)

-- Search Bar ala Banana Hub
local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Parent = Sidebar
SearchBox.BackgroundColor3 = Color3.fromRGB(20, 26, 38)
SearchBox.BorderSizePixel = 0
SearchBox.Position = UDim2.new(0, 10, 0, 10)
SearchBox.Size = UDim2.new(1, -20, 0, 28)
SearchBox.Font = Enum.Font.SourceSans
SearchBox.PlaceholderText = "Search section or Fun"
SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 130, 150)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 13
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 4)
SearchCorner.Parent = SearchBox

-- List Menu di Sidebar (Hanya Home sesuai permintaan)
local MenuList = Instance.new("ScrollingFrame")
MenuList.Name = "MenuList"
MenuList.Parent = Sidebar
MenuList.Active = true
MenuList.BackgroundTransparency = 1
MenuList.BorderSizePixel = 0
MenuList.Position = UDim2.new(0, 0, 0, 48)
MenuList.Size = UDim2.new(1, 0, 1, -48)
MenuList.CanvasSize = UDim2.new(0, 0, 0, 0)
MenuList.ScrollBarThickness = 2

local MenuLayout = Instance.new("UIListLayout")
MenuLayout.Parent = MenuList
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuLayout.Padding = UDim.new(0, 4)

-- Indikator Garis Kuning/Merah Aktif di Menu Kiri (Garis kecil penanda aktif ala Banana Hub)
local HomeBtn = Instance.new("TextButton")
HomeBtn.Name = "HomeBtn"
HomeBtn.Parent = MenuList
HomeBtn.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
HomeBtn.BorderSizePixel = 0
HomeBtn.Size = UDim2.new(1, 0, 0, 35)
HomeBtn.Font = Enum.Font.SourceSansBold
HomeBtn.Text = "     Home"
HomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeBtn.TextSize = 14
HomeBtn.TextXAlignment = Enum.TextXAlignment.Left

local ActiveIndicator = Instance.new("Frame")
ActiveIndicator.Name = "ActiveIndicator"
ActiveIndicator.Parent = HomeBtn
ActiveIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ActiveIndicator.BorderSizePixel = 0
ActiveIndicator.Position = UDim2.new(0, 0, 0, 0)
ActiveIndicator.Size = UDim2.new(0, 3, 1, 0)

-- Container / Panel Kanan (Tempat Konten/Fitur)
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.Active = true
Container.BackgroundColor3 = Color3.fromRGB(18, 24, 36)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 180, 0, 30)
Container.Size = UDim2.new(1, -180, 1, -30)
Container.CanvasSize = UDim2.new(0, 0, 1, 0)
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)

local ContainerLayout = Instance.new("UIListLayout")
ContainerLayout.Parent = Container
ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContainerLayout.Padding = UDim.new(0, 6)

-- Header Tab di dalam Container Kanan (Mirip "Sea Event Tab" di gambar)
local function createTabHeader(text)
	local headerFrame = Instance.new("Frame")
	headerFrame.Parent = Container
	headerFrame.BackgroundTransparency = 1
	headerFrame.Size = UDim2.new(1, 0, 0, 35)

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Parent = headerFrame
	titleLabel.BackgroundTransparency = 1
	titleLabel.Position = UDim2.new(0, 15, 0, 0)
	titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
	titleLabel.Font = Enum.Font.SourceSansBold
	titleLabel.Text = text
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 16
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left

	-- Tombol Search kecil di kanan atas panel konten ala Banana Hub
	local searchIconBtn = Instance.new("TextButton")
	searchIconBtn.Parent = headerFrame
	searchIconBtn.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
	searchIconBtn.BorderSizePixel = 0
	searchIconBtn.Position = UDim2.new(1, -35, 0.5, -12)
	searchIconBtn.Size = UDim2.new(0, 24, 0, 24)
	searchIconBtn.Font = Enum.Font.SourceSansBold
	searchIconBtn.Text = "🔍"
	searchIconBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	searchIconBtn.TextSize = 11

	local iconCorner = Instance.new("UICorner")
	iconCorner.CornerRadius = UDim.new(0, 4)
	iconCorner.Parent = searchIconBtn
end

-- Elemen Toggle Kotak Khas Banana Hub (Kotak di sebelah kanan item)
local function createBananaToggle(text, defaultState)
	local itemFrame = Instance.new("Frame")
	itemFrame.Parent = Container
	itemFrame.BackgroundColor3 = Color3.fromRGB(24, 32, 46)
	itemFrame.BorderSizePixel = 0
	itemFrame.Size = UDim2.new(1, -10, 0, 42)
	itemFrame.Position = UDim2.new(0, 5, 0, 0)

	local itemCorner = Instance.new("UICorner")
	itemCorner.CornerRadius = UDim.new(0, 6)
	itemCorner.Parent = itemFrame

	local itemLabel = Instance.new("TextLabel")
	itemLabel.Parent = itemFrame
	itemLabel.BackgroundTransparency = 1
	itemLabel.Position = UDim2.new(0, 15, 0, 0)
	itemLabel.Size = UDim2.new(0.75, 0, 1, 0)
	itemLabel.Font = Enum.Font.SourceSansBold
	itemLabel.Text = text
	itemLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
	itemLabel.TextSize = 14
	itemLabel.TextXAlignment = Enum.TextXAlignment.Left

	-- Kotak Checkbox ala Banana Hub
	local checkBox = Instance.new("TextButton")
	checkBox.Parent = itemFrame
	checkBox.BackgroundColor3 = defaultState and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 40, 58)
	checkBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
	checkBox.BorderSizePixel = 1
	checkBox.Position = UDim2.new(1, -42, 0.5, -12)
	checkBox.Size = UDim2.new(0, 24, 0, 24)
	checkBox.Text = ""

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = checkBox

	local active = defaultState
	checkBox.MouseButton1Click:Connect(function()
		active = not active
		checkBox.BackgroundColor3 = active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 40, 58)
	end)
end

-- Membangun Tampilan Menu Home
createTabHeader("Home Tab")
createBananaToggle("Main Status Active", true)
createBananaToggle("Auto Collect Chest", false)

-- Fungsi Buka Tutup UI & Tombol Bundar
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
