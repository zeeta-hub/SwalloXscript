-- ==========================================
-- SWALLO HUB LUA - UI ONLY (ORION LIBRARY)
-- ==========================================

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "Swallo Hub - Blox Fruits", 
    HidePremium = false, 
    SaveConfig = false, 
    ConfigFolder = "SwalloHub"
})

-- ----------------------------------------------------
-- MEMBUAT TAB (MENU)
-- ----------------------------------------------------

-- Tab 1: Home
local HomeTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

HomeTab:AddLabel("Status: UI Ready")
HomeTab:AddParagraph("Info Hub", "Silakan pilih menu di samping untuk menggunakan fitur Swallo Hub.")

-- Tab 2: Player
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddToggle({
    Name = "No Clip [Contoh]",
    Default = false,
    Callback = function(v)
        -- Tempat kode No Clip nanti
    end
})

PlayerTab:AddDropdown({
    Name = "Select Team [Contoh]",
    Default = "Pirate",
    Options = {"Pirate", "Marine"},
    Callback = function(v)
        -- Tempat kode Select Team nanti
    end
})

-- Tab 3: Auto Farm
local MainTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Enable Auto Farm Level [Contoh]",
    Default = false,
    Callback = function(Value)
        -- Tempat kode Auto Farm nanti
    end    
})

-- Tab 4: Fruit Settings
local FruitTab = Window:MakeTab({
    Name = "Fruit Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

FruitTab:AddToggle({
    Name = "Auto Roll / Gacha Fruit [Contoh]",
    Default = false,
    Callback = function(Value)
        -- Tempat kode Gacha nanti
    end    
})

FruitTab:AddToggle({
    Name = "Auto Store Fruit [Contoh]",
    Default = false,
    Callback = function(Value)
        -- Tempat kode Store Fruit nanti
    end    
})

-- Inisialisasi UI Orion
OrionLib:Init()
