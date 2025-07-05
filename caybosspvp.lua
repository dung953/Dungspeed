-- GUI FARM BOSS + PVP - KHÔNG NoClip
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "⚔️ Auto Cày Boss + PvP 🇻🇳", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "FarmPVPVN"
})

_G.AutoFarmBoss = false
_G.AutoPvP = false

-- ✅ Tab: Auto Farm
local TabFarm = Window:MakeTab({Name = "📦 Auto Farm Boss", Icon = "rbxassetid://4483345998", PremiumOnly = false})

TabFarm:AddTextbox({
    Name = "🔤 Nhập tên Boss",
    Default = "Boss",
    TextDisappear = false,
    Callback = function(value)
        _G.BossName = value
    end
})

TabFarm:AddToggle({
    Name = "🔁 Bật Auto Farm Boss",
    Default = false,
    Callback = function(v)
        _G.AutoFarmBoss = v
    end
})

-- ✅ Tab: Auto PvP
local TabPVP = Window:MakeTab({Name = "⚔️ Auto PvP", Icon = "rbxassetid://4483345998", PremiumOnly = false})

TabPVP:AddToggle({
    Name = "⚔️ Tự đánh người chơi khác",
    Default = false,
    Callback = function(v)
        _G.AutoPvP = v
    end
})

-- 🔁 Loop Farm Boss
spawn(function()
    while task.wait(1) do
        if _G.AutoFarmBoss and _G.BossName then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == _G.BossName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        while v.Humanoid.Health > 0 and _G.AutoFarmBoss do
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                            wait(0.25)
                        end
                    end
                end
            end
        end
    end
end)

-- 🔁 Loop Auto PvP
spawn(function()
    while task.wait(1) do
        if _G.AutoPvP then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local me = game.Players.LocalPlayer.Character
                    if me and me:FindFirstChild("HumanoidRootPart") then
                        me.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                        wait(0.2)
                    end
                end
            end
        end
    end
end)

-- ✅ Khởi động GUI
OrionLib:Init()
