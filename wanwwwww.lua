-- VOMO_ Ninja Injector
-- 版本: 1.0
-- 作者: 您的名字
-- 描述: 忍者风格注入器脚本

-- 初始化
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- 初始化变量
local VOMO_ = {
    Config = {
        Key = "1495",
        Version = "1.0.0"
    },
    Modules = {},
    UI = nil,
    Fly = false,
    FlySpeed = 50,
    FlyBodyVelocity = nil,
    ESP_Enabled = false,
    ESP_Objects = {},
    SpeedEnabled = false,
    DefaultSpeed = 16,
    RotationEnabled = false,
    RotationSpeed = 30,
    BulletTrack = false,
    BulletAccuracy = 100,
    InfiniteStamina = false,
    StaminaValue = 100000,
    WallBang = false
}

-- 开场动画函数
local function StartAnimation()
    -- 创建开场UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VOMO_Intro"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    
    -- 创建模糊效果
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Parent = Lighting
    
    -- 创建背景框架
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Parent = ScreenGui
    
    -- 创建FT文字
    local FTLabel = Instance.new("TextLabel")
    FTLabel.Name = "FTLabel"
    FTLabel.Size = UDim2.new(0, 200, 0, 80)
    FTLabel.Position = UDim2.new(0, -200, 0.5, -40)
    FTLabel.BackgroundTransparency = 1
    FTLabel.Text = "FT"
    FTLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FTLabel.TextSize = 72
    FTLabel.Font = Enum.Font.GothamBold
    FTLabel.TextStrokeTransparency = 0.5
    FTLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    FTLabel.Parent = MainFrame
    
    -- 创建卡密输入UI
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(0, 400, 0, 200)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    KeyFrame.BackgroundTransparency = 0.3
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Visible = false
    KeyFrame.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = KeyFrame
    
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Size = UDim2.new(1, 0, 0, 40)
    KeyLabel.Position = UDim2.new(0, 0, 0, 20)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.Text = "请输入卡密"
    KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyLabel.TextSize = 24
    KeyLabel.Font = Enum.Font.Gotham
    KeyLabel.Parent = KeyFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0, 300, 0, 40)
    KeyBox.Position = UDim2.new(0.5, -150, 0.5, -20)
    KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyBox.Text = ""
    KeyBox.PlaceholderText = "输入卡密"
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.TextSize = 20
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.Parent = KeyFrame
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 6)
    UICorner2.Parent = KeyBox
    
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(0, 100, 0, 40)
    SubmitButton.Position = UDim2.new(0.5, -50, 0.8, -20)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    SubmitButton.Text = "验证"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 18
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Parent = KeyFrame
    
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = SubmitButton
    
    -- 开场动画序列
    local function Sequence1()
        -- 文字从左到中间
        local tween = TweenService:Create(FTLabel, TweenInfo.new(1, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, -100, 0.5, -40)
        })
        tween:Play()
        tween.Completed:Wait()
        
        wait(0.3)
        
        -- 模糊效果
        local blurTween = TweenService:Create(BlurEffect, TweenInfo.new(0.5), {
            Size = 67
        })
        blurTween:Play()
        
        -- 文字从中间到右边
        local tween2 = TweenService:Create(FTLabel, TweenInfo.new(1, Enum.EasingStyle.Quad), {
            Position = UDim2.new(1, 50, 0.5, -40)
        })
        tween2:Play()
        tween2.Completed:Wait()
        
        -- 显示卡密输入框
        FTLabel.Visible = false
        KeyFrame.Visible = true
        
        -- 淡入效果
        KeyFrame.BackgroundTransparency = 1
        local fadeIn = TweenService:Create(KeyFrame, TweenInfo.new(0.5), {
            BackgroundTransparency = 0.3
        })
        fadeIn:Play()
    end
    
    -- 卡密验证
    SubmitButton.MouseButton1Click:Connect(function()
        if KeyBox.Text == VOMO_.Config.Key then
            -- 正确卡密
            BlurEffect.Size = 0
            ScreenGui:Destroy()
            
            -- 加载主界面
            loadMainUI()
        else
            -- 错误卡密
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "卡密错误",
                Text = "卡密错误，请在制作者那里获取",
                Duration = 5,
                Icon = "rbxassetid://4483345998"
            })
            
            wait(2)
            
            -- 踢出游戏
            LocalPlayer:Kick("卡密错误，请在制作者那里获取")
        end
    end)
    
    -- 开始动画
    Sequence1()
end

-- 主UI界面
local function loadMainUI()
    -- 加载Rayfield库
    local success, Rayfield = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua'))()
    end)
    
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "错误",
            Text = "无法加载Rayfield UI库",
            Duration = 5
        })
        return
    end
    
    -- 创建Rayfield窗口
    local Window = Rayfield:CreateWindow({
        Name = "VOMO_ 忍者注入器",
        LoadingTitle = "加载中...",
        LoadingSubtitle = "by VOMO_",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "VOMO_Config",
            FileName = "Config"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink",
            RememberJoins = true
        },
        KeySystem = false
    })
    
    -- 标签页1: 信息
    local Tab1 = Window:CreateTab("信息", 4483362458)
    
    local Section1 = Tab1:CreateSection("服务器信息")
    
    local PlayerNameLabel = Tab1:CreateLabel("玩家名字: " .. LocalPlayer.Name)
    local ServerIdLabel = Tab1:CreateLabel("服务器ID: " .. game.JobId)
    local ServerNameLabel = Tab1:CreateLabel("服务器名称: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    
    -- 标签页2: 玩家
    local Tab2 = Window:CreateTab("玩家", 4483362458)
    
    -- 玩家透视
    local Section2 = Tab2:CreateSection("玩家透视")
    
    local ESP_Toggle = Tab2:CreateToggle({
        Name = "玩家透视",
        CurrentValue = false,
        Flag = "ESP_Toggle",
        Callback = function(Value)
            VOMO_.ESP_Enabled = Value
            if Value then
                enableESP()
            else
                disableESP()
            end
        end
    })
    
    local ESP_ColorDropdown = Tab2:CreateDropdown({
        Name = "透视颜色",
        Options = {"绿色", "红色", "彩色", "灰色"},
        CurrentOption = "绿色",
        Flag = "ESP_Color",
        Callback = function(Option)
            updateESPColor(Option)
        end
    })
    
    local ESP_NameToggle = Tab2:CreateToggle({
        Name = "透视玩家名",
        CurrentValue = false,
        Flag = "ESP_Name",
        Callback = function(Value)
            updateESPNames(Value)
        end
    })
    
    local WallBangToggle = Tab2:CreateToggle({
        Name = "玩家穿墙",
        CurrentValue = false,
        Flag = "WallBang",
        Callback = function(Value)
            VOMO_.WallBang = Value
            if Value then
                enableWallBang()
            else
                disableWallBang()
            end
        end
    })
    
    local ThrowAllButton = Tab2:CreateButton({
        Name = "甩飞所有人",
        Callback = function()
            throwAllPlayers()
        end
    })
    
    local Section3 = Tab2:CreateSection("旋转功能")
    
    local RotationToggle = Tab2:CreateToggle({
        Name = "旋转",
        CurrentValue = false,
        Flag = "Rotation",
        Callback = function(Value)
            VOMO_.RotationEnabled = Value
            if Value then
                startRotation()
            else
                stopRotation()
            end
        end
    })
    
    local RotationSlider = Tab2:CreateSlider({
        Name = "旋转速度",
        Range = {1, 100},
        Increment = 1,
        Suffix = "速度",
        CurrentValue = 30,
        Flag = "RotationSpeed",
        Callback = function(Value)
            VOMO_.RotationSpeed = Value
        end
    })
    
    -- 标签页3: 全局通用
    local Tab3 = Window:CreateTab("全局通用", 4483362458)
    
    local Section4 = Tab3:CreateSection("移动设置")
    
    local SpeedSlider = Tab3:CreateSlider({
        Name = "玩家速度",
        Range = {16, 200},
        Increment = 1,
        Suffix = "速度",
        CurrentValue = 16,
        Flag = "PlayerSpeed",
        Callback = function(Value)
            VOMO_.DefaultSpeed = Value
            if VOMO_.SpeedEnabled then
                setPlayerSpeed(Value)
            end
        end
    })
    
    local SpeedToggle = Tab3:CreateToggle({
        Name = "启用速度修改",
        CurrentValue = false,
        Flag = "SpeedToggle",
        Callback = function(Value)
            VOMO_.SpeedEnabled = Value
            if Value then
                setPlayerSpeed(VOMO_.DefaultSpeed)
            else
                resetPlayerSpeed()
            end
        end
    })
    
    local FlyButton = Tab3:CreateButton({
        Name = "飞行",
        Callback = function()
            createFlyUI()
        end
    })
    
    local Section5 = Tab3:CreateSection("其他功能")
    
    local StaminaToggle = Tab3:CreateToggle({
        Name = "无限体力",
        CurrentValue = false,
        Flag = "InfiniteStamina",
        Callback = function(Value)
            VOMO_.InfiniteStamina = Value
            if Value then
                enableInfiniteStamina()
            else
                disableInfiniteStamina()
            end
        end
    })
    
    -- 标签页4: 子弹追踪
    local Tab4 = Window:CreateTab("子弹追踪", 4483362458)
    
    local Section6 = Tab4:CreateSection("子弹设置")
    
    local BulletTrackToggle = Tab4:CreateToggle({
        Name = "子弹长眼睛",
        CurrentValue = false,
        Flag = "BulletTrack",
        Callback = function(Value)
            VOMO_.BulletTrack = Value
            if Value then
                enableBulletTrack()
            else
                disableBulletTrack()
            end
        end
    })
    
    local AccuracySlider = Tab4:CreateSlider({
        Name = "命中率",
        Range = {0, 100},
        Increment = 1,
        Suffix = "%",
        CurrentValue = 100,
        Flag = "BulletAccuracy",
        Callback = function(Value)
            VOMO_.BulletAccuracy = Value
        end
    })
    
    local BulletWallToggle = Tab4:CreateToggle({
        Name = "子弹穿墙",
        CurrentValue = false,
        Flag = "BulletWall",
        Callback = function(Value)
            VOMO_.WallBang = Value
        end
    })
    
    local EnemyESPToggle = Tab4:CreateToggle({
        Name = "透视敌人",
        CurrentValue = false,
        Flag = "EnemyESP",
        Callback = function(Value)
            if Value then
                enableEnemyESP()
            else
                disableEnemyESP()
            end
        end
    })
end

-- ESP功能
local function enableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            createESP(player.Character)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            createESP(character)
        end)
    end)
end

local function disableESP()
    for _, obj in pairs(VOMO_.ESP_Objects) do
        if obj then
            obj:Destroy()
        end
    end
    VOMO_.ESP_Objects = {}
end

local function createESP(character)
    local highlight = Instance.new("Highlight")
    highlight.Name = "VOMO_ESP"
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = character
    highlight.Adornee = character
    
    VOMO_.ESP_Objects[character] = highlight
end

local function updateESPColor(color)
    local colorMap = {
        ["绿色"] = Color3.fromRGB(0, 255, 0),
        ["红色"] = Color3.fromRGB(255, 0, 0),
        ["彩色"] = Color3.new(math.random(), math.random(), math.random()),
        ["灰色"] = Color3.fromRGB(128, 128, 128)
    }
    
    for _, highlight in pairs(VOMO_.ESP_Objects) do
        if highlight then
            highlight.FillColor = colorMap[color] or Color3.fromRGB(0, 255, 0)
        end
    end
end

local function updateESPNames(show)
    -- 这里实现显示玩家名的逻辑
end

-- 穿墙功能
local function enableWallBang()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(11) -- 游泳状态可以穿墙
        end
    end
end

local function disableWallBang()
    -- 恢复正常的碰撞
end

-- 甩飞所有人
local function throwAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(math.random(-500, 500), math.random(500, 1000), math.random(-500, 500))
            end
        end
    end
end

-- 旋转功能
local function startRotation()
    spawn(function()
        while VOMO_.RotationEnabled do
            if LocalPlayer.Character then
                local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(VOMO_.RotationSpeed), 0)
                end
            end
            wait()
        end
    end)
end

local function stopRotation()
    -- 停止旋转
end

-- 速度修改
local function setPlayerSpeed(speed)
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
        end
    end
end

local function resetPlayerSpeed()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end

-- 飞行UI
local function createFlyUI()
    local FlyGUI = Instance.new("ScreenGui")
    FlyGUI.Name = "VOMO_FlyUI"
    FlyGUI.Parent = game:GetService("CoreGui")
    
    local FlyFrame = Instance.new("Frame")
    FlyFrame.Size = UDim2.new(0, 300, 0, 200)
    FlyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    FlyFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    FlyFrame.BackgroundTransparency = 0.1
    FlyFrame.BorderSizePixel = 0
    FlyFrame.Parent = FlyGUI
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = FlyFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "飞行控制"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.Font = Enum.Font.GothamBold
    Title.Parent = FlyFrame
    
    local SpeedBox = Instance.new("TextBox")
    SpeedBox.Size = UDim2.new(0, 200, 0, 40)
    SpeedBox.Position = UDim2.new(0.5, -100, 0.3, 0)
    SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SpeedBox.Text = "50"
    SpeedBox.PlaceholderText = "飞行速度"
    SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedBox.TextSize = 18
    SpeedBox.Font = Enum.Font.Gotham
    SpeedBox.Parent = FlyFrame
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 6)
    UICorner2.Parent = SpeedBox
    
    local FlyToggle = Instance.new("TextButton")
    FlyToggle.Size = UDim2.new(0, 100, 0, 40)
    FlyToggle.Position = UDim2.new(0.5, -50, 0.6, 0)
    FlyToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    FlyToggle.Text = "关闭飞行"
    FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyToggle.TextSize = 18
    FlyToggle.Font = Enum.Font.GothamBold
    FlyToggle.Parent = FlyFrame
    
    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0, 6)
    UICorner3.Parent = FlyToggle
    
    local HideButton = Instance.new("TextButton")
    HideButton.Size = UDim2.new(0, 80, 0, 30)
    HideButton.Position = UDim2.new(0.5, -40, 0.85, 0)
    HideButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    HideButton.Text = "隐藏"
    HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    HideButton.TextSize = 14
    HideButton.Font = Enum.Font.Gotham
    HideButton.Parent = FlyFrame
    
    local UICorner4 = Instance.new("UICorner")
    UICorner4.CornerRadius = UDim.new(0, 6)
    UICorner4.Parent = HideButton
    
    -- 飞行功能
    FlyToggle.MouseButton1Click:Connect(function()
        VOMO_.Fly = not VOMO_.Fly
        
        if VOMO_.Fly then
            FlyToggle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            FlyToggle.Text = "开启飞行"
            enableFlight(tonumber(SpeedBox.Text) or 50)
        else
            FlyToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            FlyToggle.Text = "关闭飞行"
            disableFlight()
        end
    end)
    
    HideButton.MouseButton1Click:Connect(function()
        FlyGUI:Destroy()
    end)
    
    SpeedBox.FocusLost:Connect(function()
        VOMO_.FlySpeed = tonumber(SpeedBox.Text) or 50
        if VOMO_.Fly then
            enableFlight(VOMO_.FlySpeed)
        end
    end)
end

-- 飞行功能实现
local function enableFlight(speed)
    if not LocalPlayer.Character then return end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not hrp then return end
    
    -- 创建BodyVelocity
    if VOMO_.FlyBodyVelocity then
        VOMO_.FlyBodyVelocity:Destroy()
    end
    
    VOMO_.FlyBodyVelocity = Instance.new("BodyVelocity")
    VOMO_.FlyBodyVelocity.Name = "VOMO_FlyVelocity"
    VOMO_.FlyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    VOMO_.FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    VOMO_.FlyBodyVelocity.Parent = hrp
    
    -- 飞行控制
    local flyConnection
    flyConnection = RunService.Heartbeat:Connect(function()
        if not VOMO_.Fly or not hrp or not VOMO_.FlyBodyVelocity then
            flyConnection:Disconnect()
            return
        end
        
        local camera = Workspace.CurrentCamera
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- 读取输入
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        -- 应用速度
        if moveDirection.Magnitude > 0 then
            VOMO_.FlyBodyVelocity.Velocity = moveDirection.Unit * speed
        else
            VOMO_.FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        
        -- 取消重力
        humanoid:ChangeState(Enum.HumanoidStateType.Flying)
    end)
end

local function disableFlight()
    VOMO_.Fly = false
    if VOMO_.FlyBodyVelocity then
        VOMO_.FlyBodyVelocity:Destroy()
        VOMO_.FlyBodyVelocity = nil
    end
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end
end

-- 无限体力功能
local function enableInfiniteStamina()
    spawn(function()
        while VOMO_.InfiniteStamina do
            -- 寻找并修改体力条
            local staminaBar = findStaminaBar()
            if staminaBar then
                staminaBar.Value = VOMO_.StaminaValue
            end
            wait(0.1)
        end
    end)
end

local function disableInfiniteStamina()
    -- 停止修改体力条
end

local function findStaminaBar()
    -- 尝试找到体力条
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if gui then
        -- 这里需要根据具体游戏UI调整
        for _, obj in pairs(gui:GetDescendants()) do
            if (obj.Name:lower():find("stamina") or obj.Name:lower():find("energy")) and obj:IsA("Frame") then
                return obj
            end
        end
    end
    return nil
end

-- 子弹追踪功能
local function enableBulletTrack()
    -- 这里实现子弹追踪逻辑
    -- 需要根据具体游戏武器系统调整
end

local function disableBulletTrack()
    -- 禁用子弹追踪
end

local function enableEnemyESP()
    -- 根据阵营透视敌人
    -- 需要根据具体游戏阵营系统调整
end

local function disableEnemyESP()
    -- 禁用敌人透视
end

-- 启动脚本
StartAnimation()

-- 键盘快捷键
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.Delete then
            -- 紧急停止所有功能
            VOMO_.Fly = false
            VOMO_.ESP_Enabled = false
            VOMO_.SpeedEnabled = false
            VOMO_.RotationEnabled = false
            VOMO_.BulletTrack = false
            VOMO_.InfiniteStamina = false
            
            disableFlight()
            disableESP()
            resetPlayerSpeed()
            stopRotation()
            disableBulletTrack()
            disableInfiniteStamina()
        end
    end
end)

-- 保存配置
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        -- 清理所有对象
        disableFlight()
        disableESP()
    end
end)
