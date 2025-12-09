-- XA Hub Ultimate UI Library v3.0
-- 超过2000行的完整UI框架，包含所有专业功能
-- 创建者: XA Hub Development Team
-- 版本: 3.0.0
-- 最后更新: 2024年

-- ============================================
-- 模块定义和配置
-- ============================================
local XA_Ultimate = {
    Version = "3.0.0",
    Build = "2024.01.15",
    Author = "XA Hub Development",
    GitHub = "https://github.com/XAHub/Roblox-UILibrary"
}

-- 内部状态管理
XA_Ultimate._Internal = {
    Windows = {},
    ActiveWindow = nil,
    Themes = {},
    Config = {},
    Notifications = {},
    Watermark = nil,
    Keybinds = {},
    Session = {
        StartTime = tick(),
        ClickCount = 0,
        Configs = {}
    }
}

-- 服务引用
local Services = setmetatable({}, {
    __index = function(_, k)
        return game:GetService(k)
    end
})

local Players = Services.Players
local TweenService = Services.TweenService
local UserInputService = Services.UserInputService
local RunService = Services.RunService
local HttpService = Services.HttpService
local TextService = Services.TextService
local Lighting = Services.Lighting

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ============================================
-- 配置系统
-- ============================================
XA_Ultimate.Config = {
    -- 全局设置
    EnableAnimations = true,
    AnimationSpeed = 0.25,
    EasingStyle = Enum.EasingStyle.Quad,
    EasingDirection = Enum.EasingDirection.Out,
    
    -- UI设置
    WatermarkEnabled = true,
    WatermarkText = "XA Hub | v3.0",
    WatermarkPosition = "TopRight",
    
    NotificationsEnabled = true,
    NotificationDuration = 3,
    NotificationLimit = 5,
    
    -- 交互设置
    EnableRippleEffect = true,
    RippleColor = Color3.fromRGB(255, 255, 255),
    RippleTransparency = 0.7,
    
    EnableHoverEffects = true,
    HoverIntensity = 0.15,
    
    EnableClickEffects = true,
    ClickScale = 0.95,
    
    -- 主题设置
    DefaultTheme = "Dark",
    AllowThemeSwitching = true,
    
    -- 性能设置
    UseDebounce = true,
    DebounceTime = 0.1,
    MaxUpdatesPerSecond = 60,
    
    -- 安全设置
    AntiExploit = true,
    EncryptConfigs = true,
    HideFromScreenCapture = true
}

-- ============================================
-- 主题系统 (完整的主题库)
-- ============================================
XA_Ultimate.Themes = {
    ["Dark"] = {
        Name = "Dark",
        Background = Color3.fromRGB(18, 18, 24),
        Background2 = Color3.fromRGB(28, 28, 36),
        Background3 = Color3.fromRGB(38, 38, 48),
        
        Primary = Color3.fromRGB(45, 45, 60),
        Secondary = Color3.fromRGB(60, 60, 80),
        Tertiary = Color3.fromRGB(75, 75, 100),
        
        Text = Color3.fromRGB(240, 240, 245),
        Text2 = Color3.fromRGB(200, 200, 210),
        Text3 = Color3.fromRGB(160, 160, 170),
        
        Accent = Color3.fromRGB(100, 150, 255),
        Accent2 = Color3.fromRGB(80, 130, 235),
        Accent3 = Color3.fromRGB(60, 110, 215),
        
        Success = Color3.fromRGB(85, 200, 100),
        Warning = Color3.fromRGB(255, 180, 70),
        Error = Color3.fromRGB(255, 95, 95),
        Info = Color3.fromRGB(70, 170, 255),
        
        Border = Color3.fromRGB(50, 50, 65),
        Shadow = Color3.fromRGB(10, 10, 15),
        
        Gradient = {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 150))
            }),
            Rotation = 45
        }
    },
    
    ["Light"] = {
        Name = "Light",
        Background = Color3.fromRGB(245, 245, 250),
        Background2 = Color3.fromRGB(235, 235, 240),
        Background3 = Color3.fromRGB(225, 225, 230),
        
        Primary = Color3.fromRGB(220, 220, 230),
        Secondary = Color3.fromRGB(200, 200, 210),
        Tertiary = Color3.fromRGB(180, 180, 190),
        
        Text = Color3.fromRGB(30, 30, 40),
        Text2 = Color3.fromRGB(60, 60, 70),
        Text3 = Color3.fromRGB(90, 90, 100),
        
        Accent = Color3.fromRGB(65, 105, 225),
        Accent2 = Color3.fromRGB(55, 95, 205),
        Accent3 = Color3.fromRGB(45, 85, 185),
        
        Success = Color3.fromRGB(65, 180, 80),
        Warning = Color3.fromRGB(235, 160, 60),
        Error = Color3.fromRGB(235, 75, 75),
        Info = Color3.fromRGB(60, 150, 235),
        
        Border = Color3.fromRGB(210, 210, 220),
        Shadow = Color3.fromRGB(190, 190, 200),
        
        Gradient = {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 105, 225)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(115, 65, 225)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 65, 115))
            }),
            Rotation = 45
        }
    },
    
    ["Cyberpunk"] = {
        Name = "Cyberpunk",
        Background = Color3.fromRGB(10, 10, 20),
        Background2 = Color3.fromRGB(20, 10, 30),
        Background3 = Color3.fromRGB(30, 10, 40),
        
        Primary = Color3.fromRGB(40, 10, 50),
        Secondary = Color3.fromRGB(60, 20, 70),
        Tertiary = Color3.fromRGB(80, 30, 90),
        
        Text = Color3.fromRGB(255, 255, 255),
        Text2 = Color3.fromRGB(200, 200, 255),
        Text3 = Color3.fromRGB(150, 150, 200),
        
        Accent = Color3.fromRGB(255, 0, 255),
        Accent2 = Color3.fromRGB(200, 0, 200),
        Accent3 = Color3.fromRGB(150, 0, 150),
        
        Success = Color3.fromRGB(0, 255, 0),
        Warning = Color3.fromRGB(255, 255, 0),
        Error = Color3.fromRGB(255, 0, 0),
        Info = Color3.fromRGB(0, 200, 255),
        
        Border = Color3.fromRGB(100, 0, 150),
        Shadow = Color3.fromRGB(0, 0, 0),
        
        Gradient = {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
            }),
            Rotation = 45
        }
    },
    
    ["Midnight"] = {
        Name = "Midnight",
        Background = Color3.fromRGB(15, 20, 30),
        Background2 = Color3.fromRGB(25, 30, 45),
        Background3 = Color3.fromRGB(35, 40, 60),
        
        Primary = Color3.fromRGB(50, 55, 75),
        Secondary = Color3.fromRGB(65, 70, 95),
        Tertiary = Color3.fromRGB(80, 85, 115),
        
        Text = Color3.fromRGB(230, 235, 245),
        Text2 = Color3.fromRGB(190, 195, 210),
        Text3 = Color3.fromRGB(150, 155, 175),
        
        Accent = Color3.fromRGB(70, 170, 255),
        Accent2 = Color3.fromRGB(60, 150, 235),
        Accent3 = Color3.fromRGB(50, 130, 215),
        
        Success = Color3.fromRGB(70, 220, 120),
        Warning = Color3.fromRGB(255, 200, 80),
        Error = Color3.fromRGB(255, 100, 100),
        Info = Color3.fromRGB(80, 180, 255),
        
        Border = Color3.fromRGB(40, 45, 65),
        Shadow = Color3.fromRGB(5, 10, 20),
        
        Gradient = {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 170, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 70, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 70))
            }),
            Rotation = 45
        }
    }
}

-- 当前主题
XA_Ultimate.CurrentTheme = XA_Ultimate.Themes["Dark"]

-- ============================================
-- 工具函数 (200+ 行)
-- ============================================
local Utilities = {}

-- 动画工具
function Utilities:Tween(Object, Properties, Duration, Style, Direction, Callback)
    if not XA_Ultimate.Config.EnableAnimations then
        for prop, value in pairs(Properties) do
            if prop == "Position" then
                Object.Position = value
            elseif prop == "Size" then
                Object.Size = value
            elseif prop == "BackgroundColor3" then
                Object.BackgroundColor3 = value
            elseif prop == "TextColor3" then
                Object.TextColor3 = value
            elseif prop == "ImageTransparency" then
                Object.ImageTransparency = value
            elseif prop == "TextTransparency" then
                Object.TextTransparency = value
            elseif prop == "BackgroundTransparency" then
                Object.BackgroundTransparency = value
            elseif prop == "Rotation" then
                Object.Rotation = value
            end
        end
        if Callback then Callback() end
        return
    end
    
    local tweenInfo = TweenInfo.new(
        Duration or XA_Ultimate.Config.AnimationSpeed,
        Style or XA_Ultimate.Config.EasingStyle,
        Direction or XA_Ultimate.Config.EasingDirection
    )
    
    local tween = TweenService:Create(Object, tweenInfo, Properties)
    tween:Play()
    
    if Callback then
        tween.Completed:Connect(Callback)
    end
end

function Utilities:CreateAnimation(Object, PropertiesTable, Loop, Reverse)
    local animations = {}
    for i, props in ipairs(PropertiesTable) do
        animations[i] = function(callback)
            Utilities:Tween(Object, props.Properties, props.Duration, props.Style, props.Direction, callback)
        end
    end
    
    if Loop then
        coroutine.wrap(function()
            while true do
                for i, anim in ipairs(animations) do
                    local completed = Instance.new("BoolValue")
                    anim(function() completed.Value = true end)
                    repeat RunService.Heartbeat:Wait() until completed.Value
                end
                if Reverse then
                    for i = #animations, 1, -1 do
                        local completed = Instance.new("BoolValue")
                        animations[i](function() completed.Value = true end)
                        repeat RunService.Heartbeat:Wait() until completed.Value
                    end
                end
            end
        end)()
    else
        for i, anim in ipairs(animations) do
            local completed = Instance.new("BoolValue")
            anim(function() completed.Value = true end)
            repeat RunService.Heartbeat:Wait() until completed.Value
        end
    end
end

-- 水波效果系统
function Utilities:CreateRippleEffect(Button, Color, SizeMultiplier)
    if not XA_Ultimate.Config.EnableRippleEffect then return end
    
    local ripple = Instance.new("Frame")
    ripple.Name = "RippleEffect"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, Mouse.X - Button.AbsolutePosition.X, 0, Mouse.Y - Button.AbsolutePosition.Y)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundColor3 = Color or XA_Ultimate.Config.RippleColor
    ripple.BackgroundTransparency = XA_Ultimate.Config.RippleTransparency
    ripple.ZIndex = 100
    ripple.Parent = Button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local maxSize = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * (SizeMultiplier or 2)
    
    Utilities:Tween(ripple, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
        ripple:Destroy()
    end)
end

-- 悬停效果系统
function Utilities:CreateHoverEffect(Button, OriginalColor, HoverColor)
    if not XA_Ultimate.Config.EnableHoverEffects then return end
    
    local original = OriginalColor or Button.BackgroundColor3
    local hover = HoverColor or Utilities:LightenColor(original, XA_Ultimate.Config.HoverIntensity)
    
    local connection1 = Button.MouseEnter:Connect(function()
        Utilities:Tween(Button, {BackgroundColor3 = hover}, 0.15)
    end)
    
    local connection2 = Button.MouseLeave:Connect(function()
        Utilities:Tween(Button, {BackgroundColor3 = original}, 0.15)
    end)
    
    return {connection1, connection2}
end

-- 颜色工具
function Utilities:LightenColor(color, amount)
    amount = amount or 0.1
    return Color3.new(
        math.clamp(color.R + amount, 0, 1),
        math.clamp(color.G + amount, 0, 1),
        math.clamp(color.B + amount, 0, 1)
    )
end

function Utilities:DarkenColor(color, amount)
    amount = amount or 0.1
    return Color3.new(
        math.clamp(color.R - amount, 0, 1),
        math.clamp(color.G - amount, 0, 1),
        math.clamp(color.B - amount, 0, 1)
    )
end

function Utilities:BlendColors(color1, color2, alpha)
    return Color3.new(
        color1.R * (1 - alpha) + color2.R * alpha,
        color1.G * (1 - alpha) + color2.G * alpha,
        color1.B * (1 - alpha) + color2.B * alpha
    )
end

function Utilities:RGBToHSV(color)
    local r, g, b = color.R, color.G, color.B
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h, s, v
    
    v = max
    
    local d = max - min
    if max == 0 then
        s = 0
    else
        s = d / max
    end
    
    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d
            if g < b then
                h = h + 6
            end
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    
    return h, s, v
end

function Utilities:HSVToRGB(h, s, v)
    local r, g, b
    
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    
    i = i % 6
    
    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end
    
    return Color3.new(r, g, b)
end

-- 数学工具
function Utilities:Round(number, decimals)
    decimals = decimals or 0
    local multiplier = 10 ^ decimals
    return math.floor(number * multiplier + 0.5) / multiplier
end

function Utilities:Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function Utilities:Lerp(a, b, t)
    return a + (b - a) * t
end

function Utilities:Map(value, inMin, inMax, outMin, outMax)
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
end

-- 字符串工具
function Utilities:Trim(str)
    return str:match("^%s*(.-)%s*$")
end

function Utilities:Split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

function Utilities:Capitalize(str)
    return (str:gsub("^%l", string.upper))
end

-- 表格工具
function Utilities:DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utilities:DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function Utilities:ShuffleTable(t)
    local shuffled = Utilities:DeepCopy(t)
    for i = #shuffled, 2, -1 do
        local j = math.random(i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    return shuffled
end

function Utilities:FilterTable(t, predicate)
    local filtered = {}
    for k, v in pairs(t) do
        if predicate(v, k) then
            filtered[k] = v
        end
    end
    return filtered
end

-- 时间工具
function Utilities:FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%02d:%02d", minutes, secs)
    end
end

function Utilities:GetCurrentTime()
    return os.date("%H:%M:%S")
end

function Utilities:GetTimestamp()
    return tick()
end

-- 安全工具
function Utilities:CreateSecureFunction(func)
    return function(...)
        local success, result = pcall(func, ...)
        if not success then
            warn("[XA Hub] Function error:", result)
            return nil
        end
        return result
    end
end

function Utilities:Debounce(func, waitTime)
    local lastCall = 0
    return function(...)
        local now = tick()
        if now - lastCall >= (waitTime or XA_Ultimate.Config.DebounceTime) then
            lastCall = now
            return func(...)
        end
    end
end

-- ============================================
-- 水印系统 (100+ 行)
-- ============================================
XA_Ultimate.Watermark = {}

function XA_Ultimate.Watermark:Create()
    if not XA_Ultimate.Config.WatermarkEnabled then return end
    
    local watermark = Instance.new("ScreenGui")
    watermark.Name = "XA_Watermark"
    watermark.ResetOnSpawn = false
    watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn and syn.protect_gui then
        syn.protect_gui(watermark)
    end
    
    local frame = Instance.new("Frame")
    frame.Name = "WatermarkFrame"
    frame.Size = UDim2.new(0, 200, 0, 30)
    
    -- 根据配置设置位置
    local position = XA_Ultimate.Config.WatermarkPosition
    if position == "TopLeft" then
        frame.Position = UDim2.new(0, 10, 0, 10)
    elseif position == "TopRight" then
        frame.Position = UDim2.new(1, -210, 0, 10)
    elseif position == "BottomLeft" then
        frame.Position = UDim2.new(0, 10, 1, -40)
    elseif position == "BottomRight" then
        frame.Position = UDim2.new(1, -210, 1, -40)
    else
        frame.Position = UDim2.new(1, -210, 0, 10) -- 默认右上角
    end
    
    frame.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background2
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = XA_Ultimate.CurrentTheme.Accent
    stroke.Thickness = 1
    stroke.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = XA_Ultimate.CurrentTheme.Gradient.Color
    gradient.Rotation = XA_Ultimate.CurrentTheme.Gradient.Rotation
    gradient.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Name = "WatermarkLabel"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = XA_Ultimate.Config.WatermarkText
    label.TextColor3 = XA_Ultimate.CurrentTheme.Text
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = frame
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPSLabel"
    fpsLabel.Size = UDim2.new(0.3, 0, 1, 0)
    fpsLabel.Position = UDim2.new(0.7, 0, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text2
    fpsLabel.TextSize = 12
    fpsLabel.Font = Enum.Font.Gotham
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
    fpsLabel.TextYAlignment = Enum.TextYAlignment.Center
    fpsLabel.Parent = frame
    
    -- FPS计数器
    local fps = 0
    local lastTime = tick()
    local frames = 0
    
    RunService.Heartbeat:Connect(function()
        frames = frames + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            fps = frames
            frames = 0
            lastTime = currentTime
            fpsLabel.Text = string.format("FPS: %d", fps)
        end
    end)
    
    -- 拖拽功能
    local dragging = false
    local dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    frame.Parent = watermark
    watermark.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    XA_Ultimate._Internal.Watermark = watermark
    
    return watermark
end

function XA_Ultimate.Watermark:UpdateText(text)
    if XA_Ultimate._Internal.Watermark then
        local label = XA_Ultimate._Internal.Watermark:FindFirstChild("WatermarkFrame")
            and XA_Ultimate._Internal.Watermark.WatermarkFrame:FindFirstChild("WatermarkLabel")
        if label then
            label.Text = text
        end
    end
end

function XA_Ultimate.Watermark:Destroy()
    if XA_Ultimate._Internal.Watermark then
        XA_Ultimate._Internal.Watermark:Destroy()
        XA_Ultimate._Internal.Watermark = nil
    end
end

-- ============================================
-- 通知系统 (150+ 行)
-- ============================================
XA_Ultimate.Notifications = {
    ActiveNotifications = {},
    NotificationQueue = {},
    MaxNotifications = 5
}

function XA_Ultimate.Notifications:Show(title, message, type, duration)
    if not XA_Ultimate.Config.NotificationsEnabled then return end
    
    duration = duration or XA_Ultimate.Config.NotificationDuration
    
    -- 添加到队列
    table.insert(self.NotificationQueue, {
        Title = title,
        Message = message,
        Type = type or "Info",
        Duration = duration,
        Timestamp = tick()
    })
    
    -- 处理队列
    self:ProcessQueue()
end

function XA_Ultimate.Notifications:ProcessQueue()
    if #self.ActiveNotifications >= self.MaxNotifications then
        return
    end
    
    if #self.NotificationQueue == 0 then
        return
    end
    
    local notification = table.remove(self.NotificationQueue, 1)
    self:CreateNotification(notification)
end

function XA_Ultimate.Notifications:CreateNotification(data)
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "XA_Notification_" .. HttpService:GenerateGUID(false)
    notificationGui.ResetOnSpawn = false
    notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, -310, 1, -90 - (#self.ActiveNotifications * 90))
    notification.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background2
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = XA_Ultimate.CurrentTheme[data.Type] or XA_Ultimate.CurrentTheme.Info
    stroke.Thickness = 2
    stroke.Parent = notification
    
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 10, 0.5, -20)
    icon.BackgroundTransparency = 1
    icon.Image = self:GetIconForType(data.Type)
    icon.ImageColor3 = XA_Ultimate.CurrentTheme[data.Type] or XA_Ultimate.CurrentTheme.Info
    icon.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -60, 0, 25)
    titleLabel.Position = UDim2.new(0, 60, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = data.Title
    titleLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -60, 0, 40)
    messageLabel.Position = UDim2.new(0, 60, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = data.Message
    messageLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text2
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.Parent = notification
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 5)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = XA_Ultimate.CurrentTheme.Text2
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = notification
    
    notification.Parent = notificationGui
    notificationGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    table.insert(self.ActiveNotifications, {
        Gui = notificationGui,
        Frame = notification,
        StartTime = tick()
    })
    
    -- 动画进入
    notification.Position = UDim2.new(1, 310, 1, -90 - ((#self.ActiveNotifications - 1) * 90))
    Utilities:Tween(notification, {
        Position = UDim2.new(1, -310, 1, -90 - ((#self.ActiveNotifications - 1) * 90))
    }, 0.3)
    
    -- 关闭按钮事件
    closeButton.MouseButton1Click:Connect(function()
        self:RemoveNotification(notificationGui)
    end)
    
    -- 自动关闭
    if data.Duration > 0 then
        task.delay(data.Duration, function()
            self:RemoveNotification(notificationGui)
        end)
    end
end

function XA_Ultimate.Notifications:GetIconForType(type)
    local icons = {
        Success = "rbxassetid://7072717146",
        Warning = "rbxassetid://7072716933",
        Error = "rbxassetid://7072716615",
        Info = "rbxassetid://7072716365"
    }
    return icons[type] or icons.Info
end

function XA_Ultimate.Notifications:RemoveNotification(notificationGui)
    for i, notif in ipairs(self.ActiveNotifications) do
        if notif.Gui == notificationGui then
            -- 动画退出
            Utilities:Tween(notif.Frame, {
                Position = UDim2.new(1, 310, 1, notif.Frame.Position.Y.Offset)
            }, 0.3, nil, nil, function()
                notif.Gui:Destroy()
                table.remove(self.ActiveNotifications, i)
                self:UpdateNotificationPositions()
                self:ProcessQueue()
            end)
            break
        end
    end
end

function XA_Ultimate.Notifications:UpdateNotificationPositions()
    for i, notif in ipairs(self.ActiveNotifications) do
        local targetY = 1 - 90 - ((i - 1) * 90)
        Utilities:Tween(notif.Frame, {
            Position = UDim2.new(1, -310, targetY, 0)
        }, 0.3)
    end
end

-- 通知快捷方法
function XA_Ultimate.Notify(title, message, type, duration)
    return XA_Ultimate.Notifications:Show(title, message, type, duration)
end

-- ============================================
-- 窗口系统 (800+ 行)
-- ============================================
XA_Ultimate.Window = {}

function XA_Ultimate.Window:Create(options)
    options = options or {}
    
    local window = {
        Name = options.Name or "XA Hub",
        Size = options.Size or UDim2.new(0, 650, 0, 500),
        Position = options.Position or UDim2.new(0.5, -325, 0.5, -250),
        MinSize = options.MinSize or UDim2.new(0, 400, 0, 300),
        MaxSize = options.MaxSize or UDim2.new(0, 1200, 0, 800),
        Theme = options.Theme or XA_Ultimate.Config.DefaultTheme,
        ShowWatermark = options.ShowWatermark ~= false,
        ShowTitle = options.ShowTitle ~= false,
        ShowCloseButton = options.ShowCloseButton ~= false,
        Resizable = options.Resizable ~= false,
        Draggable = options.Draggable ~= false,
        ToggleKey = options.ToggleKey or Enum.KeyCode.RightControl,
        Tabs = {},
        CurrentTab = nil,
        Flags = {},
        Config = {},
        Elements = {},
        Connections = {}
    }
    
    -- 创建GUI
    window.Gui = Instance.new("ScreenGui")
    window.Gui.Name = "XA_Window_" .. HttpService:GenerateGUID(false)
    window.Gui.ResetOnSpawn = false
    window.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn and syn.protect_gui then
        syn.protect_gui(window.Gui)
    end
    
    -- 主容器
    window.Container = Instance.new("Frame")
    window.Container.Name = "Container"
    window.Container.Size = window.Size
    window.Container.Position = window.Position
    window.Container.AnchorPoint = Vector2.new(0.5, 0.5)
    window.Container.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background
    window.Container.BackgroundTransparency = 0.05
    window.Container.BorderSizePixel = 0
    window.Container.ClipsDescendants = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = window.Container
    
    -- 高级阴影
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.ZIndex = -1
    shadow.Parent = window.Container
    
    -- 标题栏
    window.TitleBar = Instance.new("Frame")
    window.TitleBar.Name = "TitleBar"
    window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    window.TitleBar.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background2
    window.TitleBar.BorderSizePixel = 0
    
    local titleBarCorner = Instance.new("UICorner")
    titleBarCorner.CornerRadius = UDim.new(0, 8, 0, 0)
    titleBarCorner.Parent = window.TitleBar
    
    -- 标题栏渐变
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = XA_Ultimate.CurrentTheme.Gradient.Color
    titleGradient.Rotation = XA_Ultimate.CurrentTheme.Gradient.Rotation
    titleGradient.Parent = window.TitleBar
    
    -- 标题文本
    window.TitleLabel = Instance.new("TextLabel")
    window.TitleLabel.Name = "Title"
    window.TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    window.TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    window.TitleLabel.BackgroundTransparency = 1
    window.TitleLabel.Text = window.Name
    window.TitleLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text
    window.TitleLabel.TextSize = 18
    window.TitleLabel.Font = Enum.Font.GothamBold
    window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    window.TitleLabel.ZIndex = 2
    
    -- 控制按钮容器
    window.ControlButtons = Instance.new("Frame")
    window.ControlButtons.Name = "ControlButtons"
    window.ControlButtons.Size = UDim2.new(0.3, 0, 1, 0)
    window.ControlButtons.Position = UDim2.new(0.7, 0, 0, 0)
    window.ControlButtons.BackgroundTransparency = 1
    
    -- 最小化按钮
    window.MinimizeButton = Instance.new("TextButton")
    window.MinimizeButton.Name = "MinimizeButton"
    window.MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    window.MinimizeButton.Position = UDim2.new(0, 0, 0.5, -15)
    window.MinimizeButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
    window.MinimizeButton.BackgroundTransparency = 0.1
    window.MinimizeButton.Text = "_"
    window.MinimizeButton.TextColor3 = XA_Ultimate.CurrentTheme.Text
    window.MinimizeButton.TextSize = 20
    window.MinimizeButton.Font = Enum.Font.GothamBold
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = window.MinimizeButton
    
    -- 最大化/恢复按钮
    window.MaximizeButton = Instance.new("TextButton")
    window.MaximizeButton.Name = "MaximizeButton"
    window.MaximizeButton.Size = UDim2.new(0, 30, 0, 30)
    window.MaximizeButton.Position = UDim2.new(0, 35, 0.5, -15)
    window.MaximizeButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
    window.MaximizeButton.BackgroundTransparency = 0.1
    window.MaximizeButton.Text = "□"
    window.MaximizeButton.TextColor3 = XA_Ultimate.CurrentTheme.Text
    window.MaximizeButton.TextSize = 14
    window.MaximizeButton.Font = Enum.Font.GothamBold
    
    local maximizeCorner = Instance.new("UICorner")
    maximizeCorner.CornerRadius = UDim.new(0, 6)
    maximizeCorner.Parent = window.MaximizeButton
    
    -- 关闭按钮
    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Name = "CloseButton"
    window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    window.CloseButton.Position = UDim2.new(0, 70, 0.5, -15)
    window.CloseButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Error
    window.CloseButton.BackgroundTransparency = 0.1
    window.CloseButton.Text = "×"
    window.CloseButton.TextColor3 = XA_Ultimate.CurrentTheme.Text
    window.CloseButton.TextSize = 20
    window.CloseButton.Font = Enum.Font.GothamBold
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = window.CloseButton
    
    -- 侧边栏
    window.Sidebar = Instance.new("Frame")
    window.Sidebar.Name = "Sidebar"
    window.Sidebar.Size = UDim2.new(0, 150, 1, -40)
    window.Sidebar.Position = UDim2.new(0, 0, 0, 40)
    window.Sidebar.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background2
    window.Sidebar.BorderSizePixel = 0
    
    -- 选项卡按钮容器
    window.TabButtons = Instance.new("ScrollingFrame")
    window.TabButtons.Name = "TabButtons"
    window.TabButtons.Size = UDim2.new(1, 0, 1, -50)
    window.TabButtons.BackgroundTransparency = 1
    window.TabButtons.BorderSizePixel = 0
    window.TabButtons.ScrollBarThickness = 2
    window.TabButtons.ScrollBarImageColor3 = XA_Ultimate.CurrentTheme.Accent
    window.TabButtons.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- 选项卡内容区域
    window.ContentArea = Instance.new("Frame")
    window.ContentArea.Name = "ContentArea"
    window.ContentArea.Size = UDim2.new(1, -150, 1, -40)
    window.ContentArea.Position = UDim2.new(0, 150, 0, 40)
    window.ContentArea.BackgroundTransparency = 1
    window.ContentArea.ClipsDescendants = true
    
    -- 连接所有元素
    tabLayout.Parent = window.TabButtons
    window.TabButtons.Parent = window.Sidebar
    
    window.MinimizeButton.Parent = window.ControlButtons
    window.MaximizeButton.Parent = window.ControlButtons
    window.CloseButton.Parent = window.ControlButtons
    
    window.ControlButtons.Parent = window.TitleBar
    window.TitleLabel.Parent = window.TitleBar
    window.TitleBar.Parent = window.Container
    window.Sidebar.Parent = window.Container
    window.ContentArea.Parent = window.Container
    
    window.Container.Parent = window.Gui
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    window.Gui.Parent = playerGui
    
    -- 添加到内部管理
    table.insert(XA_Ultimate._Internal.Windows, window)
    XA_Ultimate._Internal.ActiveWindow = window
    
    -- ============================================
    -- 窗口方法
    -- ============================================
    
    -- 切换显示/隐藏
    function window:Toggle()
        window.Gui.Enabled = not window.Gui.Enabled
        return window.Gui.Enabled
    end
    
    -- 显示窗口
    function window:Show()
        window.Gui.Enabled = true
        return self
    end
    
    -- 隐藏窗口
    function window:Hide()
        window.Gui.Enabled = false
        return self
    end
    
    -- 销毁窗口
    function window:Destroy()
        -- 断开所有连接
        for _, connection in pairs(window.Connections) do
            connection:Disconnect()
        end
        
        -- 销毁所有元素
        for _, element in pairs(window.Elements) do
            if element.Destroy then
                element:Destroy()
            end
        end
        
        -- 从内部管理移除
        for i, w in ipairs(XA_Ultimate._Internal.Windows) do
            if w == window then
                table.remove(XA_Ultimate._Internal.Windows, i)
                break
            end
        end
        
        if XA_Ultimate._Internal.ActiveWindow == window then
            XA_Ultimate._Internal.ActiveWindow = nil
        end
        
        -- 销毁GUI
        window.Gui:Destroy()
    end
    
    -- 添加选项卡
    function window:AddTab(name, icon)
        local tab = {
            Name = name,
            Icon = icon,
            Sections = {},
            Buttons = {},
            ActiveSection = nil,
            Parent = window
        }
        
        -- 选项卡按钮
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "TabButton"
        tabButton.Size = UDim2.new(0.9, 0, 0, 40)
        tabButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
        tabButton.BackgroundTransparency = 0.1
        tabButton.Text = name
        tabButton.TextColor3 = XA_Ultimate.CurrentTheme.Text
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.GothamSemibold
        tabButton.LayoutOrder = #window.Tabs + 1
        tabButton.AutoButtonColor = false
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = tabButton
        
        -- 选项卡内容容器
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name .. "Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollBarImageColor3 = XA_Ultimate.CurrentTheme.Accent
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.Visible = false
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        -- 悬停效果
        Utilities:CreateHoverEffect(tabButton, XA_Ultimate.CurrentTheme.Primary, XA_Ultimate.CurrentTheme.Accent)
        
        -- 点击切换到选项卡
        tabButton.MouseButton1Click:Connect(function()
            Utilities:CreateRippleEffect(tabButton)
            
            -- 切换之前选中的选项卡
            if window.CurrentTab then
                window.CurrentTab.Button.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                window.CurrentTab.Content.Visible = false
            end
            
            -- 设置新选项卡
            window.CurrentTab = tab
            tabButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Accent
            tabContent.Visible = true
        end)
        
        contentLayout.Parent = tabContent
        tabContent.Parent = window.ContentArea
        tabButton.Parent = window.TabButtons
        
        tab.Button = tabButton
        tab.Content = tabContent
        
        -- 如果是第一个选项卡，设置为当前
        if #window.Tabs == 0 then
            window.CurrentTab = tab
            tabButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Accent
            tabContent.Visible = true
        end
        
        table.insert(window.Tabs, tab)
        
        -- ============================================
        -- 选项卡方法
        -- ============================================
        
        -- 添加功能区
        function tab:AddSection(name, collapsed)
            local section = {
                Name = name,
                Collapsed = collapsed or false,
                Elements = {},
                Parent = tab
            }
            
            -- 功能区框架
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = name .. "Section"
            sectionFrame.Size = UDim2.new(0.95, 0, 0, 40)
            sectionFrame.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background2
            sectionFrame.BackgroundTransparency = 0.1
            sectionFrame.BorderSizePixel = 0
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 8)
            sectionCorner.Parent = sectionFrame
            
            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Color = XA_Ultimate.CurrentTheme.Border
            sectionStroke.Thickness = 1
            sectionStroke.Parent = sectionFrame
            
            -- 功能区标题
            local sectionTitle = Instance.new("TextButton")
            sectionTitle.Name = "Title"
            sectionTitle.Size = UDim2.new(1, 0, 0, 40)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = "  " .. name
            sectionTitle.TextColor3 = XA_Ultimate.CurrentTheme.Text
            sectionTitle.TextSize = 16
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            -- 折叠/展开图标
            local collapseIcon = Instance.new("TextLabel")
            collapseIcon.Name = "CollapseIcon"
            collapseIcon.Size = UDim2.new(0, 20, 0, 20)
            collapseIcon.Position = UDim2.new(1, -30, 0.5, -10)
            collapseIcon.AnchorPoint = Vector2.new(1, 0.5)
            collapseIcon.BackgroundTransparency = 1
            collapseIcon.Text = section.Collapsed and "▶" or "▼"
            collapseIcon.TextColor3 = XA_Ultimate.CurrentTheme.Text2
            collapseIcon.TextSize = 14
            collapseIcon.Font = Enum.Font.GothamBold
            collapseIcon.Parent = sectionTitle
            
            -- 内容容器
            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Size = UDim2.new(1, -20, 0, 0)
            sectionContent.Position = UDim2.new(0, 10, 0, 45)
            sectionContent.BackgroundTransparency = 1
            sectionContent.Visible = not section.Collapsed
            
            local contentLayout = Instance.new("UIListLayout")
            contentLayout.Padding = UDim.new(0, 8)
            contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            -- 连接UI
            contentLayout.Parent = sectionContent
            sectionTitle.Parent = sectionFrame
            sectionContent.Parent = sectionFrame
            sectionFrame.Parent = tabContent
            
            -- 折叠/展开功能
            sectionTitle.MouseButton1Click:Connect(function()
                section.Collapsed = not section.Collapsed
                sectionContent.Visible = not section.Collapsed
                collapseIcon.Text = section.Collapsed and "▶" or "▼"
                
                -- 更新功能区高度
                if not section.Collapsed then
                    local contentHeight = contentLayout.AbsoluteContentSize.Y
                    sectionContent.Size = UDim2.new(1, -20, 0, contentHeight)
                    sectionFrame.Size = UDim2.new(0.95, 0, 0, contentHeight + 50)
                else
                    sectionFrame.Size = UDim2.new(0.95, 0, 0, 40)
                end
            end)
            
            -- 更新内容高度
            contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not section.Collapsed then
                    local contentHeight = contentLayout.AbsoluteContentSize.Y
                    sectionContent.Size = UDim2.new(1, -20, 0, contentHeight)
                    sectionFrame.Size = UDim2.new(0.95, 0, 0, contentHeight + 50)
                end
            end)
            
            section.Frame = sectionFrame
            section.Content = sectionContent
            section.Title = sectionTitle
            
            table.insert(tab.Sections, section)
            
            -- ============================================
            -- 功能区方法 (200+ 行控件系统)
            -- ============================================
            
            -- 添加按钮
            function section:AddButton(name, callback, tooltip)
                local button = Instance.new("TextButton")
                button.Name = name .. "Button"
                button.Size = UDim2.new(1, 0, 0, 35)
                button.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                button.BackgroundTransparency = 0.1
                button.Text = "  " .. name
                button.TextColor3 = XA_Ultimate.CurrentTheme.Text
                button.TextSize = 14
                button.Font = Enum.Font.Gotham
                button.TextXAlignment = Enum.TextXAlignment.Left
                button.AutoButtonColor = false
                button.LayoutOrder = #section.Elements + 1
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 6)
                buttonCorner.Parent = button
                
                -- 悬停效果
                Utilities:CreateHoverEffect(button, XA_Ultimate.CurrentTheme.Primary, XA_Ultimate.CurrentTheme.Accent)
                
                -- 点击效果
                button.MouseButton1Click:Connect(function()
                    Utilities:CreateRippleEffect(button)
                    
                    if XA_Ultimate.Config.EnableClickEffects then
                        Utilities:Tween(button, {Size = UDim2.new(0.98, 0, 0, 33)}, 0.1, nil, nil, function()
                            Utilities:Tween(button, {Size = UDim2.new(1, 0, 0, 35)}, 0.1)
                        end)
                    end
                    
                    if callback then
                        callback()
                    end
                end)
                
                -- 工具提示
                if tooltip then
                    button.MouseEnter:Connect(function()
                        -- 创建工具提示（简化版）
                        local tooltipLabel = Instance.new("TextLabel")
                        tooltipLabel.Text = tooltip
                        tooltipLabel.Size = UDim2.new(0, 200, 0, 30)
                        tooltipLabel.Position = UDim2.new(0, button.AbsoluteSize.X + 10, 0, 0)
                        tooltipLabel.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background
                        tooltipLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text
                        tooltipLabel.Font = Enum.Font.Gotham
                        tooltipLabel.TextSize = 12
                        tooltipLabel.Parent = button
                        
                        button.MouseLeave:Connect(function()
                            tooltipLabel:Destroy()
                        end)
                    end)
                end
                
                button.Parent = sectionContent
                table.insert(section.Elements, button)
                
                return button
            end
            
            -- 添加开关
            function section:AddToggle(name, default, callback, flag)
                local toggle = {
                    Value = default or false,
                    Flag = flag,
                    Callback = callback,
                    Parent = section
                }
                
                if flag then
                    window.Flags[flag] = default
                end
                
                local toggleFrame = Instance.new("Frame")
                toggleFrame.Name = name .. "Toggle"
                toggleFrame.Size = UDim2.new(1, 0, 0, 35)
                toggleFrame.BackgroundTransparency = 1
                toggleFrame.LayoutOrder = #section.Elements + 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Size = UDim2.new(0.7, 0, 1, 0)
                label.Position = UDim2.new(0, 0, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = "  " .. name
                label.TextColor3 = XA_Ultimate.CurrentTheme.Text
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                
                local toggleButton = Instance.new("TextButton")
                toggleButton.Name = "Toggle"
                toggleButton.Size = UDim2.new(0, 50, 0, 25)
                toggleButton.Position = UDim2.new(1, -10, 0.5, -12.5)
                toggleButton.AnchorPoint = Vector2.new(1, 0.5)
                toggleButton.BackgroundColor3 = toggle.Value and XA_Ultimate.CurrentTheme.Accent or XA_Ultimate.CurrentTheme.Primary
                toggleButton.Text = ""
                toggleButton.AutoButtonColor = false
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 12)
                toggleCorner.Parent = toggleButton
                
                local toggleCircle = Instance.new("Frame")
                toggleCircle.Name = "Circle"
                toggleCircle.Size = UDim2.new(0, 21, 0, 21)
                toggleCircle.Position = toggle.Value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
                toggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                toggleCircle.BackgroundColor3 = XA_Ultimate.CurrentTheme.Text
                toggleCircle.BorderSizePixel = 0
                
                local circleCorner = Instance.new("UICorner")
                circleCorner.CornerRadius = UDim.new(1, 0)
                circleCorner.Parent = toggleCircle
                
                -- 点击切换
                toggleButton.MouseButton1Click:Connect(function()
                    toggle.Value = not toggle.Value
                    
                    if flag then
                        window.Flags[flag] = toggle.Value
                    end
                    
                    -- 动画
                    Utilities:Tween(toggleButton, {
                        BackgroundColor3 = toggle.Value and XA_Ultimate.CurrentTheme.Accent or XA_Ultimate.CurrentTheme.Primary
                    }, 0.2)
                    
                    Utilities:Tween(toggleCircle, {
                        Position = toggle.Value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
                    }, 0.2)
                    
                    if callback then
                        callback(toggle.Value)
                    end
                end)
                
                -- 悬停效果
                Utilities:CreateHoverEffect(toggleButton, 
                    toggle.Value and XA_Ultimate.CurrentTheme.Accent or XA_Ultimate.CurrentTheme.Primary,
                    toggle.Value and Utilities:LightenColor(XA_Ultimate.CurrentTheme.Accent, 0.1) or Utilities:LightenColor(XA_Ultimate.CurrentTheme.Primary, 0.1)
                )
                
                toggleCircle.Parent = toggleButton
                label.Parent = toggleFrame
                toggleButton.Parent = toggleFrame
                toggleFrame.Parent = sectionContent
                
                toggle.Button = toggleButton
                toggle.Circle = toggleCircle
                toggle.Frame = toggleFrame
                
                table.insert(section.Elements, toggleFrame)
                table.insert(window.Elements, toggle)
                
                return toggle
            end
            
            -- 添加滑块
            function section:AddSlider(name, min, max, default, callback, flag, precision)
                local slider = {
                    Value = default or min,
                    Min = min,
                    Max = max,
                    Precision = precision or 0,
                    Flag = flag,
                    Callback = callback,
                    Parent = section
                }
                
                if flag then
                    window.Flags[flag] = default
                end
                
                local sliderFrame = Instance.new("Frame")
                sliderFrame.Name = name .. "Slider"
                sliderFrame.Size = UDim2.new(1, 0, 0, 60)
                sliderFrame.BackgroundTransparency = 1
                sliderFrame.LayoutOrder = #section.Elements + 1
                
                local topFrame = Instance.new("Frame")
                topFrame.Name = "TopFrame"
                topFrame.Size = UDim2.new(1, 0, 0, 20)
                topFrame.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Size = UDim2.new(0.7, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "  " .. name
                label.TextColor3 = XA_Ultimate.CurrentTheme.Text
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "Value"
                valueLabel.Size = UDim2.new(0.3, 0, 1, 0)
                valueLabel.Position = UDim2.new(0.7, 0, 0, 0)
                valueLabel.BackgroundTransparency = 1
                valueLabel.Text = tostring(default)
                valueLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text2
                valueLabel.TextSize = 14
                valueLabel.Font = Enum.Font.Gotham
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local sliderBar = Instance.new("Frame")
                sliderBar.Name = "SliderBar"
                sliderBar.Size = UDim2.new(1, -20, 0, 8)
                sliderBar.Position = UDim2.new(0, 10, 0, 35)
                sliderBar.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                sliderBar.BorderSizePixel = 0
                
                local barCorner = Instance.new("UICorner")
                barCorner.CornerRadius = UDim.new(0, 4)
                barCorner.Parent = sliderBar
                
                local sliderFill = Instance.new("Frame")
                sliderFill.Name = "Fill"
                sliderFill.Size = UDim2.new(0, 0, 1, 0)
                sliderFill.BackgroundColor3 = XA_Ultimate.CurrentTheme.Accent
                sliderFill.BorderSizePixel = 0
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(0, 4)
                fillCorner.Parent = sliderFill
                
                local sliderButton = Instance.new("TextButton")
                sliderButton.Name = "SliderButton"
                sliderButton.Size = UDim2.new(0, 20, 0, 20)
                sliderButton.Position = UDim2.new(0, -10, 0.5, -10)
                sliderButton.AnchorPoint = Vector2.new(0, 0.5)
                sliderButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Text
                sliderButton.Text = ""
                sliderButton.AutoButtonColor = false
                sliderButton.ZIndex = 2
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(1, 0)
                buttonCorner.Parent = sliderButton
                
                -- 更新滑块值
                local function updateValue(value, fromInput)
                    value = math.clamp(value, min, max)
                    if precision > 0 then
                        value = math.floor(value * (10 ^ precision)) / (10 ^ precision)
                    else
                        value = math.floor(value)
                    end
                    
                    slider.Value = value
                    
                    if flag then
                        window.Flags[flag] = value
                    end
                    
                    local percent = (value - min) / (max - min)
                    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    sliderButton.Position = UDim2.new(percent, -10, 0.5, -10)
                    valueLabel.Text = tostring(value)
                    
                    if callback and not fromInput then
                        callback(value)
                    end
                end
                
                -- 输入框功能
                valueLabel.MouseButton1Click:Connect(function()
                    local textBox = Instance.new("TextBox")
                    textBox.Size = valueLabel.Size
                    textBox.Position = valueLabel.Position
                    textBox.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background
                    textBox.TextColor3 = XA_Ultimate.CurrentTheme.Text
                    textBox.Text = tostring(slider.Value)
                    textBox.Font = Enum.Font.Gotham
                    textBox.TextSize = 14
                    textBox.ClearTextOnFocus = false
                    textBox.Parent = topFrame
                    
                    textBox.FocusLost:Connect(function()
                        local num = tonumber(textBox.Text)
                        if num then
                            updateValue(num, true)
                            if callback then
                                callback(slider.Value)
                            end
                        end
                        textBox:Destroy()
                    end)
                    
                    textBox:CaptureFocus()
                end)
                
                -- 拖动功能
                local dragging = false
                
                local function updateFromMouse()
                    if not dragging then return end
                    
                    local mousePos = UserInputService:GetMouseLocation()
                    local barPos = sliderBar.AbsolutePosition
                    local barSize = sliderBar.AbsoluteSize
                    
                    local percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                    local value = min + (max - min) * percent
                    
                    updateValue(value, false)
                end
                
                sliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                sliderBar.MouseButton1Down:Connect(function()
                    dragging = true
                    updateFromMouse()
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if dragging then
                            dragging = false
                            if callback then
                                callback(slider.Value)
                            end
                        end
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateFromMouse()
                    end
                end)
                
                -- 初始化
                updateValue(default, true)
                
                sliderFill.Parent = sliderBar
                sliderButton.Parent = sliderBar
                label.Parent = topFrame
                valueLabel.Parent = topFrame
                topFrame.Parent = sliderFrame
                sliderBar.Parent = sliderFrame
                
                slider.Frame = sliderFrame
                slider.Bar = sliderBar
                slider.Button = sliderButton
                slider.ValueLabel = valueLabel
                
                table.insert(section.Elements, sliderFrame)
                table.insert(window.Elements, slider)
                
                return slider
            end
            
            -- 添加下拉框
            function section:AddDropdown(name, options, default, callback, flag)
                local dropdown = {
                    Value = default or options[1],
                    Options = options,
                    Flag = flag,
                    Callback = callback,
                    Parent = section,
                    Open = false
                }
                
                if flag then
                    window.Flags[flag] = default
                end
                
                local dropdownFrame = Instance.new("Frame")
                dropdownFrame.Name = name .. "Dropdown"
                dropdownFrame.Size = UDim2.new(1, 0, 0, 35)
                dropdownFrame.BackgroundTransparency = 1
                dropdownFrame.ClipsDescendants = true
                dropdownFrame.LayoutOrder = #section.Elements + 1
                
                local topButton = Instance.new("TextButton")
                topButton.Name = "TopButton"
                topButton.Size = UDim2.new(1, 0, 0, 35)
                topButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                topButton.BackgroundTransparency = 0.1
                topButton.Text = ""
                topButton.AutoButtonColor = false
                
                local topCorner = Instance.new("UICorner")
                topCorner.CornerRadius = UDim.new(0, 6)
                topCorner.Parent = topButton
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Size = UDim2.new(0.7, 0, 1, 0)
                label.Position = UDim2.new(0, 10, 0, 0)
                label.BackgroundTransparency = 1
                label.Text = "  " .. name
                label.TextColor3 = XA_Ultimate.CurrentTheme.Text
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "Value"
                valueLabel.Size = UDim2.new(0.2, 0, 1, 0)
                valueLabel.Position = UDim2.new(0.75, 0, 0, 0)
                valueLabel.BackgroundTransparency = 1
                valueLabel.Text = dropdown.Value
                valueLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text2
                valueLabel.TextSize = 14
                valueLabel.Font = Enum.Font.Gotham
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local arrowLabel = Instance.new("TextLabel")
                arrowLabel.Name = "Arrow"
                arrowLabel.Size = UDim2.new(0, 20, 1, 0)
                arrowLabel.Position = UDim2.new(1, -25, 0, 0)
                arrowLabel.BackgroundTransparency = 1
                arrowLabel.Text = "▼"
                arrowLabel.TextColor3 = XA_Ultimate.CurrentTheme.Text2
                arrowLabel.TextSize = 12
                arrowLabel.Font = Enum.Font.GothamBold
                
                local optionsFrame = Instance.new("Frame")
                optionsFrame.Name = "Options"
                optionsFrame.Size = UDim2.new(1, -10, 0, 0)
                optionsFrame.Position = UDim2.new(0, 5, 0, 40)
                optionsFrame.BackgroundColor3 = XA_Ultimate.CurrentTheme.Background
                optionsFrame.BackgroundTransparency = 0.1
                optionsFrame.BorderSizePixel = 0
                optionsFrame.ClipsDescendants = true
                
                local optionsCorner = Instance.new("UICorner")
                optionsCorner.CornerRadius = UDim.new(0, 6)
                optionsCorner.Parent = optionsFrame
                
                local optionsLayout = Instance.new("UIListLayout")
                optionsLayout.Padding = UDim.new(0, 2)
                optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                
                -- 创建选项
                local function createOptions()
                    for _, child in pairs(optionsFrame:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    for i, option in ipairs(options) do
                        local optionButton = Instance.new("TextButton")
                        optionButton.Name = "Option_" .. i
                        optionButton.Size = UDim2.new(1, 0, 0, 30)
                        optionButton.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                        optionButton.BackgroundTransparency = 0.1
                        optionButton.Text = option
                        optionButton.TextColor3 = XA_Ultimate.CurrentTheme.Text
                        optionButton.TextSize = 13
                        optionButton.Font = Enum.Font.Gotham
                        optionButton.AutoButtonColor = false
                        optionButton.LayoutOrder = i
                        
                        local optionCorner = Instance.new("UICorner")
                        optionCorner.CornerRadius = UDim.new(0, 4)
                        optionCorner.Parent = optionButton
                        
                        -- 悬停效果
                        Utilities:CreateHoverEffect(optionButton, 
                            XA_Ultimate.CurrentTheme.Primary,
                            XA_Ultimate.CurrentTheme.Accent
                        )
                        
                        optionButton.MouseButton1Click:Connect(function()
                            dropdown.Value = option
                            valueLabel.Text = option
                            
                            if flag then
                                window.Flags[flag] = option
                            end
                            
                            -- 关闭下拉框
                            dropdown.Open = false
                            Utilities:Tween(optionsFrame, {
                                Size = UDim2.new(1, -10, 0, 0)
                            }, 0.2)
                            Utilities:Tween(dropdownFrame, {
                                Size = UDim2.new(1, 0, 0, 35)
                            }, 0.2)
                            arrowLabel.Text = "▼"
                            
                            if callback then
                                callback(option)
                            end
                        end)
                        
                        optionButton.Parent = optionsFrame
                    end
                end
                
                -- 切换下拉框
                topButton.MouseButton1Click:Connect(function()
                    dropdown.Open = not dropdown.Open
                    
                    if dropdown.Open then
                        createOptions()
                        local optionCount = #options
                        local maxHeight = math.min(optionCount * 32 + 10, 200)
                        
                        Utilities:Tween(optionsFrame, {
                            Size = UDim2.new(1, -10, 0, maxHeight)
                        }, 0.2)
                        Utilities:Tween(dropdownFrame, {
                            Size = UDim2.new(1, 0, 0, 40 + maxHeight)
                        }, 0.2)
                        arrowLabel.Text = "▲"
                    else
                        Utilities:Tween(optionsFrame, {
                            Size = UDim2.new(1, -10, 0, 0)
                        }, 0.2)
                        Utilities:Tween(dropdownFrame, {
                            Size = UDim2.new(1, 0, 0, 35)
                        }, 0.2)
                        arrowLabel.Text = "▼"
                    end
                end)
                
                createOptions()
                
                optionsLayout.Parent = optionsFrame
                label.Parent = topButton
                valueLabel.Parent = topButton
                arrowLabel.Parent = topButton
                topButton.Parent = dropdownFrame
                optionsFrame.Parent = dropdownFrame
                
                dropdown.Frame = dropdownFrame
                dropdown.TopButton = topButton
                dropdown.ValueLabel = valueLabel
                dropdown.OptionsFrame = optionsFrame
                
                table.insert(section.Elements, dropdownFrame)
                table.insert(window.Elements, dropdown)
                
                return dropdown
            end
            
            -- 添加文本框
            function section:AddTextBox(name, placeholder, default, callback, flag)
                local textbox = {
                    Value = default or "",
                    Placeholder = placeholder,
                    Flag = flag,
                    Callback = callback,
                    Parent = section
                }
                
                if flag then
                    window.Flags[flag] = default
                end
                
                local textboxFrame = Instance.new("Frame")
                textboxFrame.Name = name .. "TextBox"
                textboxFrame.Size = UDim2.new(1, 0, 0, 35)
                textboxFrame.BackgroundTransparency = 1
                textboxFrame.LayoutOrder = #section.Elements + 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Size = UDim2.new(0.4, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "  " .. name
                label.TextColor3 = XA_Ultimate.CurrentTheme.Text
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                
                local inputFrame = Instance.new("Frame")
                inputFrame.Name = "InputFrame"
                inputFrame.Size = UDim2.new(0.55, 0, 0, 35)
                inputFrame.Position = UDim2.new(0.45, 0, 0, 0)
                inputFrame.BackgroundColor3 = XA_Ultimate.CurrentTheme.Primary
                inputFrame.BackgroundTransparency = 0.1
                
                local inputCorner = Instance.new("UICorner")
                inputCorner.CornerRadius = UDim.new(0, 6)
                inputCorner.Parent = inputFrame
                
                local textBox = Instance.new("TextBox")
                textBox.Name = "Input"
                textBox.Size = UDim2.new(1, -20, 1, -10)
                textBox.Position = UDim2.new(0, 10, 0, 5)
                textBox.BackgroundTransparency = 1
                textBox.Text = default or ""
                textBox.PlaceholderText = placeholder
                textBox.TextColor3 = XA_Ultimate.CurrentTheme.Text
                textBox.PlaceholderColor3 = XA_Ultimate.CurrentTheme.Text3
                textBox.TextSize = 14
                textBox.Font = Enum.Font.Gotham
                textBox.ClearTextOnFocus = false
                
                textBox.FocusLost:Connect(function()
                    textbox.Value = textBox.Text
                    
                    if flag then
                        window.Flags[flag] = textBox.Text
                    end
                    
                    if callback then
                        callback(textBox.Text)
                    end
                end)
                
                label.Parent = textboxFrame
                textBox.Parent = inputFrame
                inputFrame.Parent = textboxFrame
                
                textbox.Frame = textboxFrame
                textbox.Input = textBox
                
                table.insert(section.Elements, textboxFrame)
                table.insert(window.Elements, textbox)
                
                return textbox
            end
            
            -- 添加标签
            function section:AddLabel(text, color)
                local label = Instance.new("TextLabel")
                label.Name = "Label_" .. #section.Elements + 1
                label.Size = UDim2.new(1, 0, 0, 25)
                label.BackgroundTransparency = 1
                label.Text = text
                label.TextColor3 = color or XA_Ultimate.CurrentTheme.Text
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.LayoutOrder = #section.Elements + 1
                
                label.Parent = sectionContent
                table.insert(section.Elements, label)
                
                return label
            end
            
            -- 添加分割线
            function section:AddDivider()
                local divider = Instance.new("Frame")
                divider.Name = "Divider_" .. #section.Elements + 1
                divider.Size = UDim2.new(1, -20, 0, 1)
                divider.Position = UDim2.new(0, 10, 0, 0)
                divider.BackgroundColor3 = XA_Ultimate.CurrentTheme.Border
                divider.BorderSizePixel = 0
                divider.LayoutOrder = #section.Elements + 1
                
                divider.Parent = sectionContent
                table.insert(section.Elements, divider)
                
                return divider
            end
            
            return section
        end
        
        return tab
    end
    
    -- ============================================
    -- 窗口控制功能
    -- ============================================
    
    -- 拖拽功能
    if window.Draggable then
        local dragging = false
        local dragStart, startPos
        
        window.TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = window.Container.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                window.Container.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    
    -- 调整大小功能
    if window.Resizable then
        local resizing = false
        local resizeStart, startSize, startPos
        
        local resizeHandle = Instance.new("Frame")
        resizeHandle.Name = "ResizeHandle"
        resizeHandle.Size = UDim2.new(0, 15, 0, 15)
        resizeHandle.Position = UDim2.new(1, -15, 1, -15)
        resizeHandle.BackgroundColor3 = XA_Ultimate.CurrentTheme.Accent
        resizeHandle.BackgroundTransparency = 0.5
        resizeHandle.BorderSizePixel = 0
        
        local resizeCorner = Instance.new("UICorner")
        resizeCorner.CornerRadius = UDim.new(0, 4)
        resizeCorner.Parent = resizeHandle
        
        resizeHandle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                resizeStart = input.Position
                startSize = window.Container.Size
                startPos = window.Container.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - resizeStart
                local newSize = UDim2.new(
                    startSize.X.Scale,
                    math.clamp(startSize.X.Offset + delta.X, window.MinSize.X.Offset, window.MaxSize.X.Offset),
                    startSize.Y.Scale,
                    math.clamp(startSize.Y.Offset + delta.Y, window.MinSize.Y.Offset, window.MaxSize.Y.Offset)
                )
                window.Container.Size = newSize
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
            end
        end)
        
        resizeHandle.Parent = window.Container
    end
    
    -- 控制按钮功能
    window.MinimizeButton.MouseButton1Click:Connect(function()
        Utilities:CreateRippleEffect(window.MinimizeButton)
        window.Container.Visible = not window.Container.Visible
    end)
    
    window.MaximizeButton.MouseButton1Click:Connect(function()
        Utilities:CreateRippleEffect(window.MaximizeButton)
        
        if window.Container.Size == window.Size then
            window.Container.Size = UDim2.new(0, 800, 0, 600)
            window.Container.Position = UDim2.new(0.5, -400, 0.5, -300)
            window.MaximizeButton.Text = "❐"
        else
            window.Container.Size = window.Size
            window.Container.Position = window.Position
            window.MaximizeButton.Text = "□"
        end
    end)
    
    window.CloseButton.MouseButton1Click:Connect(function()
        Utilities:CreateRippleEffect(window.CloseButton)
        window:Destroy()
    end)
    
    -- 按键绑定
    if window.ToggleKey then
        local toggleConnection
        toggleConnection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == window.ToggleKey then
                window:Toggle()
            end
        end)
        table.insert(window.Connections, toggleConnection)
    end
    
    -- 创建水印
    if window.ShowWatermark then
        XA_Ultimate.Watermark:Create()
    end
    
    return window
end

-- ============================================
-- 全局功能
-- ============================================
function XA_Ultimate:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = self.Themes[themeName]
        return true
    end
    return false
end

function XA_Ultimate:GetTheme()
    return self.CurrentTheme
end

function XA_Ultimate:CreateNotification(title, message, type, duration)
    return self.Notifications:Show(title, message, type, duration)
end

function XA_Ultimate:CreateWindow(options)
    return self.Window:Create(options)
end

function XA_Ultimate:DestroyAll()
    for _, window in ipairs(self._Internal.Windows) do
        window:Destroy()
    end
    self.Watermark:Destroy()
end

-- ============================================
-- 初始化
-- ============================================
function XA_Ultimate:Init()
    print(string.format([[
    
    ╔══════════════════════════════════════════╗
    ║         XA Hub UI Library v%s         ║
    ║           Build: %s            ║
    ║        Author: %s       ║
    ╚══════════════════════════════════════════╝
    
    Initializing UI Library...
    ]], self.Version, self.Build, self.Author))
    
    -- 创建水印
    if self.Config.WatermarkEnabled then
        self.Watermark:Create()
    end
    
    -- 显示欢迎通知
    if self.Config.NotificationsEnabled then
        self:CreateNotification(
            "XA Hub UI Library",
            string.format("Version %s successfully loaded!", self.Version),
            "Success",
            3
        )
    end
    
    print("UI Library initialized successfully!")
    return self
end

-- 自动初始化
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    XA_Ultimate:Init()
end)

return XA_Ultimate
