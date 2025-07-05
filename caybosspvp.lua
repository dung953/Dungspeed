-- ✅ Bật/tắt tính năng
_G.AutoFarmBoss = true
_G.AutoPvP = true

-- 🎯 Tên boss trong Workspace (bạn cần đổi đúng tên boss thật)
local bossName = "Boss"

-- 🔁 Auto Farm Boss
spawn(function()
    while _G.AutoFarmBoss and wait(1) do
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Model") and v.Name == bossName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                local hrp = v.HumanoidRootPart
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0)
                    wait(0.2)
                    while v.Humanoid.Health > 0 and _G.AutoFarmBoss do
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                        wait(0.2)
                    end
                end
            end
        end
    end
end)

-- 🔁 Auto PvP: đánh người chơi khác
spawn(function()
    while _G.AutoPvP and wait(1) do
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local target = plr.Character.HumanoidRootPart
                local myChar = game.Players.LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    myChar.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 0, 2)
                    wait(0.3)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                end
            end
        end
    end
end)
