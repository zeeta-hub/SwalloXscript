-- Swallo Hub - Blox Fruit (Red Theme)
-- Menggunakan Rayfield UI Library sebagai contoh dasar struktur UI Roblox yang bersih dan rapi.

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Swallo Hub - Blox Fruit",
   LoadingTitle = "Swallo Hub is Loading...",
   LoadingSubtitle = "by Swallo",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SwalloHub",
      FileName = "BloxFruitConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = false,
   Theme = "Default" -- Bisa disesuaikan atau menggunakan kustomisasi warna merah di bawah
})

-- Mengubah aksen warna menjadi Merah
-- Rayfield mendukung kustomisasi tema secara langsung
Window.Background = Color3.fromRGB(20, 20, 20)
Window.Main = Color3.fromRGB(30, 30, 30)
Window.Accent = Color3.fromRGB(255, 0, 0) -- Warna Merah Utama
Window.TextColor = Color3.fromRGB(255, 255, 255)

-- Tab: Sea Event (Sesuai dengan gambar)
local SeaEventTab = Window:CreateTab("Sea Event", 4483362458)

local SeaSection = SeaEventTab:CreateSection("Sea Event Tab")

SeaEventTab:CreateButton({
   Name = "Refresh Player",
   Callback = function()
      print("Player Refreshed")
   end,
})

SeaEventTab:CreateToggle({
   Name = "Auto Sea Event With Friend",
   CurrentValue = false,
   Flag = "AutoSeaFriend",
   Callback = function(Value)
      print("Auto Sea Event With Friend: " .. tostring(Value))
   end,
})

SeaEventTab:CreateToggle({
   Name = "Auto Repair Ur Ship",
   CurrentValue = false,
   Flag = "AutoRepair",
   Callback = function(Value)
      print("Auto Repair Ur Ship: " .. tostring(Value))
   end,
})

SeaEventTab:CreateToggle({
   Name = "Auto Sea Event",
   CurrentValue = true,
   Flag = "AutoSeaEvent",
   Callback = function(Value)
      print("Auto Sea Event: " .. tostring(Value))
   end,
})

SeaEventTab:CreateToggle({
   Name = "Auto Find Mirage",
   CurrentValue = false,
   Flag = "AutoMirage",
   Callback = function(Value)
      print("Auto Find Mirage: " .. tostring(Value))
   end,
})

-- Section: Kitsune Event
local KitsuneSection = SeaEventTab:CreateSection("Kitsune Event")

SeaEventTab:CreateToggle({
   Name = "Teleport To Kitsune Island",
   CurrentValue = false,
   Flag = "TeleportKitsune",
   Callback = function(Value)
      print("Teleport To Kitsune Island: " .. tostring(Value))
   end,
})

SeaEventTab:CreateToggle({
   Name = "Hop Server [ Next Night or Near Full Moon > 2m ]",
   CurrentValue = false,
   Flag = "HopMoon",
   Callback = function(Value)
      print("Hop Server Moon: " .. tostring(Value))
   end,
})

-- Tab Tambahan Sesuai Menu di Gambar
local FarmingTab = Window:CreateTab("Farming Other", 4483362458)
FarmingTab:CreateSection("Farming Menu")

local FruitTab = Window:CreateTab("Fruit and Raid, Dunge", 4483362458)
FruitTab:CreateSection("Fruit & Dungeon Menu")

local RaceTab = Window:CreateTab("Upgrade Race", 4483362458)
RaceTab:CreateSection("Race Upgrade Menu")

local ItemTab = Window:CreateTab("Get and Upgrade Item", 4483362458)
ItemTab:CreateSection("Item Menu")

local VolcanoTab = Window:CreateTab("Volcano Event", 4483362458)
VolcanoTab:CreateSection("Volcano Event Menu")

local ESPTab = Window:CreateTab("ESP", 4483362458)
ESPTab:CreateSection("ESP Menu")

local PVPTab = Window:CreateTab("PVP", 4483362458)
PVPTab:CreateSection("PVP Menu")

local WebhookTab = Window:CreateTab("Tab Webhook", 4483362458)
WebhookTab:CreateSection("Webhook Settings")

Rayfield:LoadConfiguration()
