-- 🌟 Menu Blox Fruits Chuyên Nghiệp - Bởi ChatGPT
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BFProMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 340)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Visible = true

local UICorner = Instance.new("UICorner", frame)

local y = 10
function createButton(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40 + y, 100, 180)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
    y = y + 45
    return btn
end

-- Auto Farm
local farmOn = false
createButton("🥷 Auto Farm: Tắt", function(self)
    farmOn = not farmOn
    self.Text = farmOn and "🥷 Auto Farm: Bật" or "🥷 Auto Farm: Tắt"
    spawn(function()
        while farmOn do
            for _,e in pairs(workspace.Enemies:GetChildren()) do
                local h = e:FindFirstChild("HumanoidRootPart")
                if h and char and root then
                    root.CFrame = h.CFrame + Vector3.new(0,0,2)
                    wait(0.2)
                    -- Đánh bằng phím Z
                    VIM:SendKeyEvent(true, "Z", false, game)
                    wait(0.1)
                    VIM:SendKeyEvent(false, "Z", false, game)
                end
            end
            wait(1)
        end
    end)
end)

-- Fly
local flying = false
local flyVel
createButton("🕊️ Fly: Tắt", function(self)
    flying = not flying
    self.Text = flying and "🕊️ Fly: Bật" or "🕊️ Fly: Tắt"
    if flying then
        local body = Instance.new("BodyVelocity")
        body.Velocity = Vector3.zero
        body.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        body.Parent = root
        flyVel = body

        UIS.InputBegan:Connect(function(i,gp)
            if not gp and flying then
                if i.KeyCode == Enum.KeyCode.Space then
                    body.Velocity = Vector3.new(0,50,0)
                elseif i.KeyCode == Enum.KeyCode.LeftControl then
                    body.Velocity = Vector3.new(0,-50,0)
                elseif i.KeyCode == Enum.KeyCode.W then
                    body.Velocity = root.CFrame.LookVector * 50
                elseif i.KeyCode == Enum.KeyCode.S then
                    body.Velocity = -root.CFrame.LookVector * 50
                elseif i.KeyCode == Enum.KeyCode.A then
                    body.Velocity = -root.CFrame.RightVector * 50
                elseif i.KeyCode == Enum.KeyCode.D then
                    body.Velocity = root.CFrame.RightVector * 50
                end
            end
        end)
    else
        if flyVel then flyVel:Destroy() end
    end
end)

-- Hitbox
local hitboxOn = false
createButton("🎯 Hitbox: Tắt", function(self)
    hitboxOn = not hitboxOn
    self.Text = hitboxOn and "🎯 Hitbox: Bật" or "🎯 Hitbox: Tắt"
    spawn(function()
        while hitboxOn do
            for _,enemy in pairs(workspace.Enemies:GetChildren()) do
                local part = enemy:FindFirstChild("HumanoidRootPart")
                if part then
                    part.Size = Vector3.new(60,60,60)
                    part.Transparency = 0.5
                    part.Material = Enum.Material.Neon
                    part.CanCollide = false
                end
            end
            wait(1)
        end
    end)
end)

-- Auto Chest
local chestOn = false
createButton("🪙 Auto Rương: Tắt", function(self)
    chestOn = not chestOn
    self.Text = chestOn and "🪙 Auto Rương: Bật" or "🪙 Auto Rương: Tắt"
    spawn(function()
        while chestOn do
            for _,chest in pairs(workspace:GetChildren()) do
                if chest:IsA("Model") and (chest:FindFirstChild("Chest") or chest:FindFirstChild("HumanoidRootPart")) then
                    local c = chest:FindFirstChild("Chest") or chest:FindFirstChild("HumanoidRootPart")
                    if c then
                        root.CFrame = c.CFrame + Vector3.new(0,2,0)
                        wait(0.5)
                    end
                end
            end
            wait(1)
        end
    end)
end)

-- Speed Hack
local speedOn = false
createButton("⚡ Chạy Nhanh: Tắt", function(self)
    speedOn = not speedOn
    self.Text = speedOn and "⚡ Chạy Nhanh: Bật" or "⚡ Chạy Nhanh: Tắt"
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = speedOn and 150 or 16
    end
end)

-- Toggle GUI visibility
createButton("👁️ Ẩn/Hiện Menu", function()
    frame.Visible = not frame.Visible
end)

-- Thoát menu
createButton("❌ Thoát menu", function()
    gui:Destroy()
end)
