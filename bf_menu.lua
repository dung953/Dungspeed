-- 🌟 Menu nhanh Blox Fruit: Auto Farm, Fly, Hitbox, Teleport, Tắt GUI
local p = game.Players.LocalPlayer
local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
g.Name = "BFMenu"

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0,200,0,240)
f.Position = UDim2.new(0,100,0,100)
f.BackgroundColor3 = Color3.fromRGB(30,30,30)

local btns = {"AutoFarm","Teleport","Fly","Hitbox","Tắt"}
local funcs = {}
local y = 10

function mkBtn(txt, fn)
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(1,-20,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = txt
	b.BackgroundColor3 = Color3.fromRGB(50 + y*2,100,200 - y)
	b.TextColor3 = Color3.new(1,1,1)
	b.MouseButton1Click:Connect(fn)
	y = y + 50
end

-- 🥷 Auto Farm
mkBtn("AutoFarm", function()
	spawn(function()
		while wait(1) do
			for _,e in pairs(workspace.Enemies:GetChildren()) do
				local h = e:FindFirstChild("HumanoidRootPart")
				if h then
					p.Character:FindFirstChild("HumanoidRootPart").CFrame = h.CFrame + Vector3.new(0,0,2)
				end
			end
		end
	end)
end)

-- 🚀 Teleport
mkBtn("Teleport", function()
	for _,v in pairs(workspace:GetDescendants()) do
		if v.Name == "Blox Fruit Dealer" and v:FindFirstChild("HumanoidRootPart") then
			p.Character:FindFirstChild("HumanoidRootPart").CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
			break
		end
	end
end)

-- 🕊️ Fly
local fly = false
local dir = Vector3.zero
mkBtn("Fly", function()
	fly = not fly
	if fly then
		spawn(function()
			while fly do wait()
				p.Character.HumanoidRootPart.Velocity = dir * 50
			end
		end)
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i,gp)
	if not fly or gp then return end
	local k = i.KeyCode
	if k == Enum.KeyCode.W then dir = Vector3.new(0,0,-1)
	elseif k == Enum.KeyCode.S then dir = Vector3.new(0,0,1)
	elseif k == Enum.KeyCode.A then dir = Vector3.new(-1,0,0)
	elseif k == Enum.KeyCode.D then dir = Vector3.new(1,0,0)
	elseif k == Enum.KeyCode.Space then dir = Vector3.new(0,1,0)
	elseif k == Enum.KeyCode.LeftControl then dir = Vector3.new(0,-1,0)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(i)
	if fly then dir = Vector3.zero end
end)

-- 🎯 Hitbox
local hbx = false
mkBtn("Hitbox", function()
	hbx = not hbx
	spawn(function()
		while hbx do wait(1)
			for _,e in pairs(workspace.Enemies:GetChildren()) do
				local h = e:FindFirstChild("HumanoidRootPart")
				if h then
					h.Size = Vector3.new(50,50,50)
					h.Transparency = 0.5
					h.Material = Enum.Material.ForceField
					h.CanCollide = false
				end
			end
		end
	end)
end)

-- ❌ Tắt GUI
mkBtn("Tắt", function() g:Destroy() end)
