---====== Load spawner ======---

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Services ======---

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReSt = game:GetService("ReplicatedStorage")
local Plr = Players.LocalPlayer

---====== Lighting RED ======---

local cc = Lighting:FindFirstChild("MainColorCorrection")
if not cc then
    cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "MainColorCorrection"
    cc.Parent = Lighting
end

cc.TintColor = Color3.fromRGB(255,0,0)
cc.Contrast = 1

TweenService:Create(cc, TweenInfo.new(1.5), {Contrast = 0}):Play()
TweenService:Create(cc, TweenInfo.new(6), {TintColor = Color3.fromRGB(255,255,255)}):Play()

---====== Create entity ======---

local entity = spawner.Create({
    Entity = {
        Name = "Ripper",
        Asset = "rbxassetid://13942047057",
        HeightOffset = 0
    },

    Lights = {
        Flicker = {
            Enabled = true,
            Duration = 1
        },
        Shatter = true,
        Repair = false
    },

    CameraShake = {
        Enabled = true,
        Range = 80,
        Values = {2, 20, 0.1, 1}
    },

    Movement = {
        Speed = 65,
        Delay = 1,
        Reversed = false
    },

    Rebounding = {
        Enabled = false
    },

    Damage = {
        Enabled = true,
        Range = 40,
        Amount = 9999 -- chạm = chết
    },

    Crucifixion = {
        Enabled = false
    },

    Death = {
        Type = "Guiding",
        Hints = {"you dIE ripper"},
        Cause = "die to ripper"
    }
})

---====== Callbacks ======---

entity:SetCallback("OnSpawned", function()
    print("[RIPPER] Spawned")
end)

entity:SetCallback("OnStartMoving", function()
    print("[RIPPER] Moving")
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
    if newHealth <= 0 then
        if ReSt:FindFirstChild("GameStats") then
            local stats = ReSt.GameStats:FindFirstChild("Player_"..Plr.Name)
            if stats then
                stats.Total.DeathCause.Value = "die to ripper"
            end
        end
        print("[RIPPER] Player killed")
    end
end)

entity:SetCallback("OnDespawned", function()
    print("[RIPPER] Despawned")
end)

---====== Run entity ======---

entity:Run()
