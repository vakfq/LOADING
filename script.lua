local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomLoadingScreen"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Fullscreen background
local bg = Instance.new("Frame")
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.ZIndex = 1
bg.Parent = screenGui

-- Loading Text
local title = Instance.new("TextLabel")
title.Text = "Loading..."
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 48
title.AnchorPoint = Vector2.new(0.5, 0)
title.Position = UDim2.new(0.5, 0, 0.3, 0)
title.Size = UDim2.new(0, 300, 0, 60)
title.BackgroundTransparency = 1
title.ZIndex = 2
title.Parent = screenGui

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Text = "Please wait while the game loads..."
subtitle.Font = Enum.Font.Gotham
subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subtitle.TextSize = 20
subtitle.AnchorPoint = Vector2.new(0.5, 0)
subtitle.Position = UDim2.new(0.5, 0, 0.38, 0)
subtitle.Size = UDim2.new(0, 300, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.ZIndex = 2
subtitle.Parent = screenGui

-- Progress Bar Background
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0.5, 0, 0.04, 0)
barBG.Position = UDim2.new(0.25, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBG.BorderSizePixel = 0
barBG.ZIndex = 2
barBG.Parent = screenGui

-- Progress Bar Fill
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
barFill.BorderSizePixel = 0
barFill.ZIndex = 3
barFill.Parent = barBG

-- Credit
local credit = Instance.new("TextLabel")
credit.Text = "Made by vakfq"
credit.Font = Enum.Font.Gotham
credit.TextColor3 = Color3.fromRGB(150, 150, 150)
credit.TextSize = 16
credit.AnchorPoint = Vector2.new(0.5, 1)
credit.Position = UDim2.new(0.5, 0, 0.97, 0)
credit.BackgroundTransparency = 1
credit.ZIndex = 2
credit.Parent = screenGui

-- Roblox Icon (spinning)
local icon = Instance.new("ImageLabel")
icon.Image = "rbxasset://textures/ui/Settings/MenuBarIcons/RobloxLogo.png"
icon.BackgroundTransparency = 1
icon.Size = UDim2.new(0, 80, 0, 80)
icon.Position = UDim2.new(0.5, -40, 0.15, 0)
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.ZIndex = 2
icon.Parent = screenGui

-- Spinner tween
task.spawn(function()
	while true do
		TweenService:Create(icon, TweenInfo.new(2, Enum.EasingStyle.Linear), {
			Rotation = icon.Rotation + 360
		}):Play()
		task.wait(2)
	end
end)

-- Progress logic
local duration = 300 -- seconds
local steps = 100
for i = 1, steps do
	local progress = i / steps
	barFill:TweenSize(UDim2.new(progress, 0, 1, 0), "Out", "Sine", 0.1, true)

	if progress < 0.21 then
		subtitle.Text = "Loading assets..."
	elseif progress < 0.34 then
		subtitle.Text = "Loading character..."
	elseif progress < 0.67 then
		subtitle.Text = "Loading map..."
	elseif progress < 1 then
		subtitle.Text = "Finalizing..."
	else
		subtitle.Text = "Done!"
	end

	task.wait(duration / steps)
end

-- Fade out
screenGui:Destroy()
