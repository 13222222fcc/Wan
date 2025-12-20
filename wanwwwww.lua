-- VOMO_ Ninja Injector v2.1
-- 使用 jmlibrary1.lua UI库
-- 包含星星动画、子标签页和加载进度条

-- 初始化检查
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 加载UI库
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/dingding123hhh/hun/main/jmlibrary1.lua'))()

-- 全局状态
local VOMO_ = {
    Config = { Key = "1495" },
    Fly = false,
    ESP_Enabled = false,
    SubTabs = {},
    MainWindow = nil,
    FlySpeed = 50,
    SpeedValue = 16,
    RotationSpeed = 30,
    RotationEnabled = false,
    BulletTrack = false,
    Accuracy = 100,
    InfiniteStamina = false,
    StaminaValue = 100000
}

-- ==================== 开场动画序列 ====================
local function EnhancedIntroAnimation()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VOMO_Intro"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0
    Background.Parent = ScreenGui
    
    -- 星星效果容器
    local StarContainer = Instance.new("Frame")
    StarContainer.Size = UDim2.new(1, 0, 1, 0)
    StarContainer.BackgroundTransparency = 1
    StarContainer.Parent = Background
    
    local function createTrailStar(startPos, endPos)
        local star = Instance.new("ImageLabel")
        star.Image = "rbxassetid://9924332694"
        star.Size = UDim2.new(0, 20, 0, 20)
        star.Position = startPos
        star.BackgroundTransparency = 1
        star.ImageTransparency = 0.8
        star.ImageColor3 = Color3.fromRGB(139, 0, 255)
        star.Parent = StarContainer
        
        spawn(function()
            TweenService:Create(star, TweenInfo.new(0.4), {
                Position = endPos,
                ImageTransparency = 1,
                Rotation = 180,
                Size = UDim2.new(0, 8, 0, 8)
            }):Play()
            wait(0.5)
            star:Destroy()
        end)
    end
    
    -- FT文字动画
    local FTLabel = Instance.new("TextLabel")
    FTLabel.Size = UDim2.new(0, 200, 0, 80)
    FTLabel.Position = UDim2.new(0, -200, 0.5, -40)
    FTLabel.BackgroundTransparency = 1
    FTLabel.Text = "FT"
    FTLabel.TextColor3 = Color3.fromRGB(139, 0, 255)
    FTLabel.TextSize = 72
    FTLabel.Font = Enum.Font.GothamBold
    FTLabel.TextStrokeTransparency = 0.5
    FTLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    FTLabel.Parent = Background
    
    -- 第一阶段：左到中
    local moveToCenter = TweenService:Create(FTLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0.5, -100, 0.5, -40)
    })
    
    moveToCenter:Play()
    
    -- 创建追踪星星
    spawn(function()
        while FTLabel.Position.X.Scale < 0.5 do
            local xPos = FTLabel.Position.X.Scale + 0.1
            createTrailStar(
                FTLabel.Position,
                UDim2.new(xPos, math.random(-20, 20), 
                         FTLabel.Position.Y.Scale, math.random(-20, 20))
            )
            wait(0.1)
        end
    end)
    
    moveToCenter.Completed:Wait()
    
    -- 第二阶段：停顿并添加更多星星
    wait(0.3)
    
    for i = 1, 15 do
        createTrailStar(
            FTLabel.Position,
            UDim2.new(
                math.random(40, 60) / 100,
                math.random(-100, 100),
                math.random(40, 60) / 100,
                math.random(-100, 100)
            )
        )
    end
    
    wait(0.5)
    
    -- 第三阶段：中到右
    local moveToRight = TweenService:Create(FTLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint), {
        Position = UDim2.new(1, 50, 0.5, -40)
    })
    
    moveToRight:Play()
    
    -- 右侧移动星星
    spawn(function()
        while FTLabel.Position.X.Scale < 1 do
            createTrailStar(
                FTLabel.Position,
                UDim2.new(
                    FTLabel.Position.X.Scale + 0.15,
                    math.random(20, 50),
                    FTLabel.Position.Y.Scale,
                    math.random(-30, 30)
                )
            )
            wait(0.08)
        end
    end)
    
    moveToRight.Completed:Wait()
    
    -- 显示卡密输入界面
    showKeyInputInterface(Background)
    
    return ScreenGui
end

-- ==================== 卡密输入界面 ====================
local function showKeyInputInterface(parent)
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(0, 400, 0, 220)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    KeyFrame.BackgroundTransparency = 0.3
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = KeyFrame
    
    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Text = "请输入卡密"
    KeyLabel.Size = UDim2.new(1, 0, 0, 40)
    KeyLabel.Position = UDim2.new(0, 0, 0, 20)
    KeyLabel.BackgroundTransparency = 1
    KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyLabel.Font = Enum.Font.GothamSemibold
    KeyLabel.TextSize = 28
    KeyLabel.Parent = KeyFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0, 300, 0, 45)
    KeyBox.Position = UDim2.new(0.5, -150, 0.5, -22.5)
    KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KeyBox.Text = ""
    KeyBox.PlaceholderText = "输入卡密"
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.TextSize = 20
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = KeyFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = KeyBox
    
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Size = UDim2.new(0, 120, 0, 45)
    SubmitButton.Position = UDim2.new(0.5, -60, 0.8, -22.5)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
    SubmitButton.Text = "验证卡密"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 18
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Parent = KeyFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = SubmitButton
    
    SubmitButton.MouseButton1Click:Connect(function()
        if KeyBox.Text == VOMO_.Config.Key then
            -- 卡密正确，显示加载界面
            KeyFrame:Destroy()
            showLoadingScreen(parent)
        else
            -- 卡密错误
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "卡密错误",
                Text = "卡密错误，请在制作者那里获取",
                Duration = 5
            })
            
            wait(2)
            LocalPlayer:Kick("卡密错误，请在制作者那里获取")
        end
    end)
end

-- ==================== 加载屏幕界面 ====================
local function showLoadingScreen(parent)
    -- 黑色半透明背景框
    local LoadFrame = Instance.new("Frame")
    LoadFrame.Size = UDim2.new(0, 450, 0, 250)
    LoadFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
    LoadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LoadFrame.BackgroundTransparency = 0.3
    LoadFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    LoadFrame.BorderSizePixel = 2
    LoadFrame.Parent = parent
    
    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 12)
    LoadCorner.Parent = LoadFrame
    
    -- FT TF方框
    local FTBox = Instance.new("Frame")
    FTBox.Size = UDim2.new(0, 60, 0, 60)
    FTBox.Position = UDim2.new(0, 20, 0, 20)
    FTBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FTBox.BorderSizePixel = 0
    FTBox.Parent = LoadFrame
    
    local FTCorner = Instance.new("UICorner")
    FTCorner.CornerRadius = UDim.new(0, 6)
    FTCorner.Parent = FTBox
    
    local FTText = Instance.new("TextLabel")
    FTText.Size = UDim2.new(1, 0, 1, 0)
    FTText.BackgroundTransparency = 1
    FTText.Text = "FT\nTF"
    FTText.TextColor3 = Color3.fromRGB(0, 0, 0)
    FTText.TextSize = 18
    FTText.Font = Enum.Font.GothamBold
    FTText.TextYAlignment = Enum.TextYAlignment.Center
    FTText.TextXAlignment = Enum.TextXAlignment.Center
    FTText.Parent = FTBox
    
    -- 进度条背景
    local ProgressBg = Instance.new("Frame")
    ProgressBg.Size = UDim2.new(0, 350, 0, 30)
    ProgressBg.Position = UDim2.new(0.5, -175, 0.7, -15)
    ProgressBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ProgressBg.BorderSizePixel = 0
    ProgressBg.Parent = LoadFrame
    
    local ProgressBgCorner = Instance.new("UICorner")
    ProgressBgCorner.CornerRadius = UDim.new(0, 15)
    ProgressBgCorner.Parent = ProgressBg
    
    -- 进度条填充
    local ProgressFill = Instance.new("Frame")
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBg
    
    local ProgressFillCorner = Instance.new("UICorner")
    ProgressFillCorner.CornerRadius = UDim.new(0, 15)
    ProgressFillCorner.Parent = ProgressFill
    
    -- 进度文本
    local ProgressText = Instance.new("TextLabel")
    ProgressText.Size = UDim2.new(1, 0, 0, 40)
    ProgressText.Position = UDim2.new(0, 0, 0.5, -40)
    ProgressText.BackgroundTransparency = 1
    ProgressText.Text = "正在加载 VOMO_ Injector..."
    ProgressText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProgressText.TextSize = 20
    ProgressText.Font = Enum.Font.GothamSemibold
    ProgressText.Parent = LoadFrame
    
    -- 百分比文本
    local PercentText = Instance.new("TextLabel")
    PercentText.Size = UDim2.new(0, 100, 0, 30)
    PercentText.Position = UDim2.new(0.5, -50, 0.8, 0)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "0%"
    PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
    PercentText.TextSize = 22
    PercentText.Font = Enum.Font.GothamBold
    PercentText.Parent = LoadFrame
    
    -- 进度条动画（3秒）
    local progressTween = TweenService:Create(ProgressFill, TweenInfo.new(3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(1, 0, 1, 0)
    })
    
    progressTween:Play()
    
    -- 更新百分比
    spawn(function()
        local startTime = tick()
        while tick() - startTime < 3 do
            local progress = (tick() - startTime) / 3
            PercentText.Text = string.format("%d%%", math.floor(progress * 100))
            wait(0.05)
        end
        PercentText.Text = "100%"
    end)
    
    progressTween.Completed:Wait()
    wait(0.5)
    
    -- 淡出所有内容
    local fadeTween = TweenService:Create(parent, TweenInfo.new(1), {
        BackgroundTransparency = 1
    })
    
    fadeTween:Play()
    
    -- 等待淡出完成后加载主UI
    fadeTween.Completed:Wait()
    
    -- 销毁开场UI，加载主界面
    parent.Parent:Destroy()
    loadMainUI()
end

-- ==================== 主UI界面 ====================
local function loadMainUI()
    -- 创建主窗口
    VOMO_.MainWindow = library.new("VOMO_ 忍者注入器", "dark")
    
    -- ========== 标签页1: 信息 ==========
    local Tab1 = VOMO_.MainWindow:Tab("信息", "rbxassetid://4483362458")
    
    -- 主信息区
    local InfoSection = Tab1:Section("服务器信息")
    InfoSection:Label("玩家名字: " .. LocalPlayer.Name)
    InfoSection:Label("服务器ID: " .. game.JobId)
    InfoSection:Label("服务器名称: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    
    -- ========== 标签页2: 玩家 ==========
    local Tab2 = VOMO_.MainWindow:Tab("玩家", "rbxassetid://4483362458")
    
    -- 子标签系统：透视功能
    local ESPSubTab = Tab2:Section("透视功能")
    VOMO_.SubTabs["ESP"] = ESPSubTab
    
    ESPSubTab:Toggle("玩家透视", false, function(value)
        VOMO_.ESP_Enabled = value
        if value then
            enableESP()
        else
            disableESP()
        end
    end)
    
    ESPSubTab:Dropdown("透视颜色", {"绿色", "红色", "彩色", "灰色"}, "绿色", function(value)
        updateESPColor(value)
    end)
    
    ESPSubTab:Toggle("透视玩家名", false, function(value)
        updateESPNames(value)
    end)
    
    ESPSubTab:Toggle("玩家穿墙", false, function(value)
        VOMO_.WallBang = value
        if value then
            enableWallBang()
        else
            disableWallBang()
        end
    end)
    
    ESPSubTab:Button("甩飞所有人", function()
        throwAllPlayers()
    end)
    
    -- 子标签系统：移动功能
    local MoveSubTab = Tab2:Section("移动功能")
    VOMO_.SubTabs["Movement"] = MoveSubTab
    
    MoveSubTab:Toggle("旋转", false, function(value)
        VOMO_.RotationEnabled = value
        if value then
            startRotation()
        else
            stopRotation()
        end
    end)
    
    MoveSubTab:Slider("旋转速度", 1, 100, 30, true, function(value)
        VOMO_.RotationSpeed = value
    end)
    
    -- ========== 标签页3: 全局通用 ==========
    local Tab3 = VOMO_.MainWindow:Tab("全局通用", "rbxassetid://4483362458")
    
    -- 速度设置
    local SpeedSection = Tab3:Section("速度设置")
    
    SpeedSection:Toggle("启用速度修改", false, function(value)
        VOMO_.SpeedEnabled = value
        if value then
            setPlayerSpeed(VOMO_.SpeedValue)
        else
            resetPlayerSpeed()
        end
    end)
    
    SpeedSection:Slider("玩家速度", 16, 200, 16, true, function(value)
        VOMO_.SpeedValue = value
        if VOMO_.SpeedEnabled then
            setPlayerSpeed(value)
        end
    end)
    
    -- 飞行功能
    local FlySection = Tab3:Section("飞行功能")
    
    FlySection:Button("飞行控制", function()
        createFlyControlUI()
    end)
    
    -- 其他功能
    local OtherSection = Tab3:Section("其他功能")
    
    OtherSection:Toggle("无限体力", false, function(value)
        VOMO_.InfiniteStamina = value
        if value then
            enableInfiniteStamina()
        else
            disableInfiniteStamina()
        end
    end)
    
    -- ========== 标签页4: 子弹追踪 ==========
    local Tab4 = VOMO_.MainWindow:Tab("子弹追踪", "rbxassetid://4483362458")
    
    local BulletSection = Tab4:Section("子弹设置")
    
    BulletSection:Toggle("子弹长眼睛", false, function(value)
        VOMO_.BulletTrack = value
        if value then
            enableBulletTrack()
        else
            disableBulletTrack()
        end
    end)
    
    BulletSection:Slider("命中率", 0, 100, 100, true, function(value)
        VOMO_.Accuracy = value
    end)
    
    BulletSection:Toggle("子弹穿墙", false, function(value)
        VOMO_.WallBang = value
    end)
    
    BulletSection:Toggle("透视敌人", false, function(value)
        if value then
            enableEnemyESP()
        else
            disableEnemyESP()
        end
    end)
    
    -- ========== 功能实现函数 ==========
    function enableESP()
        print("ESP已启用")
        -- 实现ESP逻辑
    end
    
    function disableESP()
        print("ESP已禁用")
        -- 清理ESP
    end
    
    function updateESPColor(color)
        print("透视颜色更改为: " .. color)
    end
    
    function updateESPNames(show)
        print("显示玩家名: " .. tostring(show))
    end
    
    function enableWallBang()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(11)
            end
        end
    end
    
    function disableWallBang()
        -- 恢复正常碰撞
    end
    
    function throwAllPlayers()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Velocity = Vector3.new(
                        math.random(-500, 500),
                        math.random(500, 1000),
                        math.random(-500, 500)
                    )
                end
            end
        end
        print("已甩飞所有玩家")
    end
    
    function startRotation()
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
    
    function stopRotation()
        -- 停止旋转
    end
    
    function setPlayerSpeed(speed)
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end
    
    function resetPlayerSpeed()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
    
    function createFlyControlUI()
        -- 创建飞行控制UI
        local FlyGUI = Instance.new("ScreenGui")
        FlyGUI.Parent = game:GetService("CoreGui")
        
        local FlyFrame = Instance.new("Frame")
        FlyFrame.Size = UDim2.new(0, 250, 0, 180)
        FlyFrame.Position = UDim2.new(0.5, -125, 0.7, -90)
        FlyFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        FlyFrame.BackgroundTransparency = 0.1
        FlyFrame.Parent = FlyGUI
        
        -- 飞行控制逻辑...
        print("飞行控制UI已创建")
    end
    
    function enableInfiniteStamina()
        spawn(function()
            while VOMO_.InfiniteStamina do
                local staminaBar = findStaminaBar()
                if staminaBar then
                    staminaBar.Value = VOMO_.StaminaValue
                end
                wait(0.1)
            end
        end)
    end
    
    function disableInfiniteStamina()
        -- 停止修改体力
    end
    
    function findStaminaBar()
        local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if gui then
            for _, obj in pairs(gui:GetDescendants()) do
                if (obj.Name:lower():find("stamina") or obj.Name:lower():find("energy")) then
                    return obj
                end
            end
        end
        return nil
    end
    
    function enableBulletTrack()
        print("子弹追踪已启用")
    end
    
    function disableBulletTrack()
        print("子弹追踪已禁用")
    end
    
    function enableEnemyESP()
        print("敌人透视已启用")
    end
    
    function disableEnemyESP()
        print("敌人透视已禁用")
    end
end

-- ==================== 键盘快捷键 ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightControl then
            -- 隐藏/显示UI
            if VOMO_.MainWindow then
                VOMO_.MainWindow:toggle()
            end
        elseif input.KeyCode == Enum.KeyCode.Delete then
            -- 紧急停止
            VOMO_.Fly = false
            VOMO_.ESP_Enabled = false
            VOMO_.SpeedEnabled = false
            VOMO_.RotationEnabled = false
            VOMO_.BulletTrack = false
            VOMO_.InfiniteStamina = false
        end
    end
end)

-- ==================== 启动脚本 ====================
EnhancedIntroAnimation()
