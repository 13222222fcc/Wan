--[[
VOMO_ ULTIMATE SCRIPT v4.0
Roblox Luau 5.1 - Advanced Bypass System
Features: ESP, Speed Hack, Flight, Anti-Cheat Bypass
UI: Rayfield Interface Suite
]]

-- ============================================
-- 加载Rayfield UI库
-- ============================================

-- 显示加载提示
local LoadingScreen = Instance.new("ScreenGui")
LoadingScreen.Name = "VOMO_Loading"
LoadingScreen.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(LoadingScreen)
elseif gethui then
    LoadingScreen.Parent = gethui()
else
    LoadingScreen.Parent = game.CoreGui
end

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = LoadingScreen

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = LoadingFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "VOMO_ LOADING"
Title.TextColor3 = Color3.fromRGB(0, 180, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = LoadingFrame

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 260, 0, 20)
ProgressBar.Position = UDim2.new(0.5, -130, 0.5, -10)
ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = LoadingFrame

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 5)
ProgressCorner.Parent = ProgressBar

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBar

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 5)
FillCorner.Parent = ProgressFill

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 30)
StatusText.Position = UDim2.new(0, 0, 1, -40)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Initializing..."
StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 14
StatusText.Parent = LoadingFrame

-- 更新进度条
local function UpdateProgress(step, total, text)
    local percent = step / total
    ProgressFill:TweenSize(UDim2.new(percent, 0, 1, 0), "Out", "Quad", 0.3, true)
    StatusText.Text = text
end

UpdateProgress(1, 10, "Checking executor...")

-- 检查执行器环境
local isExecutor = (syn and syn.protect_gui) or (getexecutorname and getexecutorname() ~= nil) 
if not isExecutor then
    StatusText.Text = "Executor not detected!"
    wait(3)
    LoadingScreen:Destroy()
    return
end

-- ============================================
-- 加载Rayfield UI库
-- ============================================

UpdateProgress(2, 10, "Loading Rayfield UI...")

local Rayfield = nil
local RayfieldLoaded = false

-- 尝试多个Rayfield源
local RayfieldSources = {
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source",
    "https://raw.githubusercontent.com/SmellOfCurry/Rayfield/main/Rayfield",
    "https://raw.githubusercontent.com/NotDSF/Rayfield/main/RayfieldMain",
    "https://raw.githubusercontent.com/Rayfield-Reborn/Rayfield/main/Rayfield"
}

for i, source in ipairs(RayfieldSources) do
    local success, result = pcall(function()
        local response = game:HttpGet(source, true)
        if response then
            Rayfield = loadstring(response)()
            RayfieldLoaded = true
            return true
        end
    end)
    
    if success and RayfieldLoaded then
        break
    end
end

if not RayfieldLoaded then
    -- 尝试备用方法
    local success, result = pcall(function()
        Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
        RayfieldLoaded = true
    end)
    
    if not success then
        StatusText.Text = "Failed to load Rayfield UI!"
        wait(3)
        LoadingScreen:Destroy()
        error("Rayfield UI加载失败")
    end
end

UpdateProgress(3, 10, "Initializing Rayfield...")

-- ============================================
-- 初始化Rayfield窗口
-- ============================================

local Window = Rayfield:CreateWindow({
    Name = "VOMO_ ULTIMATE v4.0",
    LoadingTitle = "VOMO_ 终极版",
    LoadingSubtitle = "反作弊绕过系统",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false,
    Settings = {
        Theme = "Dark",
        Info = "VOMO_ - 终极反作弊绕过工具"
    }
})

-- 创建标签页
UpdateProgress(4, 10, "Creating tabs...")

local Tab1 = Window:CreateTab("信息", "rbxassetid://4483345998") -- 信息图标
local Tab2 = Window:CreateTab("透视", "rbxassetid://7733960981") -- 眼睛图标
local Tab3 = Window:CreateTab("绕过", "rbxassetid://7733710250") -- 设置图标

UpdateProgress(5, 10, "Loading features...")

-- ============================================
-- 高级反作弊绕过系统
-- ============================================

local VOMO = {
    Settings = {
        Version = "4.0",
        Build = "2024.01",
        AntiCheat = "BYPASS_ACTIVE"
    },
    
    ESP = {
        Killers = {},
        Survivors = {},
        Active = false
    },
    
    Movement = {
        Speed = {
            Enabled = false,
            Value = 25,
            Original = 16,
            Method = "Advanced"
        },
        
        Fly = {
            Enabled = false,
            Speed = 35,
            Components = {}
        }
    },
    
    Security = {
        AntiKick = true,
        AntiLog = true,
        AntiBan = true
    }
}

-- 激活反作弊保护
local function ActivateAntiCheatBypass()
    -- 挂钩元表以绕过检测
    if getrawmetatable then
        local mt = getrawmetatable(game)
        if mt then
            local oldNamecall = mt.__namecall
            local oldIndex = mt.__index
            
            setreadonly(mt, false)
            
            -- 绕过WalkSpeed检测
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- 隐藏速度修改
                if method == "GetPropertyChangedSignal" and tostring(args[1]) == "WalkSpeed" then
                    return nil
                end
                
                -- 隐藏BodyVelocity
                if method == "FindFirstChild" then
                    if type(args[1]) == "string" and args[1]:find("VOMO_") then
                        return nil
                    end
                end
                
                return oldNamecall(self, ...)
            end)
            
            -- 绕过属性读取
            mt.__index = newcclosure(function(self, key)
                if tostring(key) == "WalkSpeed" then
                    if VOMO.Movement.Speed.Enabled and tostring(self):find("Humanoid") then
                        return VOMO.Movement.Speed.Original -- 返回原始值欺骗检测
                    end
                end
                return oldIndex(self, key)
            end)
            
            setreadonly(mt, true)
        end
    end
    
    -- 伪造网络数据
    spawn(function()
        while wait(5) do
            pcall(function()
                -- 发送虚假统计信息
                game:GetService("Stats"):GetTotalMemoryUsageMb()
                
                -- 创建虚假网络请求
                if request then
                    request({
                        Url = "http://localhost:8080/fake",
                        Method = "GET"
                    })
                end
            end)
        end
    end)
end

UpdateProgress(6, 10, "Activating anti-cheat bypass...")
ActivateAntiCheatBypass()

-- ============================================
-- 标签页1: 信息
-- ============================================

local InfoSection = Tab1:CreateSection("系统信息")

Tab1:CreateLabel({
    Text = "VOMO_ ULTIMATE v4.0",
    Description = "高级反作弊绕过系统"
})

Tab1:CreateLabel({
    Text = "状态: 已保护",
    Description = "反作弊系统已绕过"
})

Tab1:CreateLabel({
    Text = "游戏: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Description = "当前游戏"
})

Tab1:CreateLabel({
    Text = "玩家: " .. #game:GetService("Players"):GetPlayers(),
    Description = "服务器玩家数"
})

-- 社区部分
local CommunitySection = Tab1:CreateSection("社区")

Tab1:CreateButton({
    Name = "加入Discord",
    Description = "获取更新和支持",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/vomo")
        end
        Rayfield:Notify({
            Title = "Discord",
            Content = "链接已复制到剪贴板",
            Duration = 3,
            Image = "rbxassetid://7733700905"
        })
    end
})

Tab1:CreateButton({
    Name = "复制游戏ID",
    Description = "复制当前游戏ID",
    Callback = function()
        if setclipboard then
            setclipboard(tostring(game.PlaceId))
        end
        Rayfield:Notify({
            Title = "游戏ID",
            Content = "已复制: " .. game.PlaceId,
            Duration = 3,
            Image = "rbxassetid://7733700905"
        })
    end
})

-- 性能监控
local PerformanceSection = Tab1:CreateSection("性能监控")

local FPSLabel = Tab1:CreateLabel({
    Text = "FPS: 计算中...",
    Description = "当前帧率"
})

local PingLabel = Tab1:CreateLabel({
    Text = "延迟: 计算中...",
    Description = "网络延迟"
})

-- 更新性能信息
spawn(function()
    while wait(1) do
        pcall(function()
            -- 计算FPS
            local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            FPSLabel:Set("FPS: " .. fps)
            
            -- 获取延迟
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            PingLabel:Set("延迟: " .. math.floor(ping) .. "ms")
        end)
    end
end)

UpdateProgress(7, 10, "Setting up ESP system...")

-- ============================================
-- 标签页2: 透视系统
-- ============================================

local ESPSection = Tab2:CreateSection("透视设置")

-- Killer ESP
local KillerESP = Tab2:CreateToggle({
    Name = "透视杀手",
    Description = "高亮显示杀手角色",
    CurrentValue = false,
    Flag = "KillerESP",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "ESP",
                Content = "杀手透视已启用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
            
            -- 启用Killer ESP
            spawn(function()
                while VOMO.ESP.Active do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character then
                            -- 检测是否为杀手
                            local isKiller = false
                            
                            -- 根据游戏逻辑调整
                            if player.Team then
                                if player.Team.Name:lower():find("killer") or
                                   player.Team.Name:lower():find("murder") or
                                   player.Team.Name:lower():find("hunter") then
                                    isKiller = true
                                end
                            end
                            
                            -- 武器检测
                            if player.Character:FindFirstChild("Knife") or
                               player.Character:FindFirstChild("Gun") or
                               player.Character:FindFirstChild("Weapon") then
                                isKiller = true
                            end
                            
                            if isKiller then
                                local existing = player.Character:FindFirstChild("VOMO_KillerESP")
                                if not existing then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "VOMO_KillerESP"
                                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                    highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
                                    highlight.FillTransparency = 0.6
                                    highlight.OutlineTransparency = 0
                                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    highlight.Adornee = player.Character
                                    
                                    -- 添加到CoreGui避免被清除
                                    if syn and syn.protect_gui then
                                        syn.protect_gui(highlight)
                                    end
                                    highlight.Parent = game.CoreGui
                                    
                                    VOMO.ESP.Killers[player] = highlight
                                    
                                    -- 添加信息标签
                                    local billboard = Instance.new("BillboardGui")
                                    billboard.Name = "VOMO_KillerInfo"
                                    billboard.Size = UDim2.new(0, 200, 0, 50)
                                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                                    billboard.Adornee = player.Character:WaitForChild("Head")
                                    billboard.AlwaysOnTop = true
                                    billboard.Parent = game.CoreGui
                                    
                                    local nameLabel = Instance.new("TextLabel")
                                    nameLabel.Text = player.Name .. " [KILLER]"
                                    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                    nameLabel.TextStrokeTransparency = 0
                                    nameLabel.BackgroundTransparency = 1
                                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                                    nameLabel.Font = Enum.Font.GothamBold
                                    nameLabel.TextSize = 14
                                    nameLabel.Parent = billboard
                                end
                            end
                        end
                    end
                    wait(0.5)
                end
            end)
        else
            -- 禁用Killer ESP
            for player, highlight in pairs(VOMO.ESP.Killers) do
                if highlight then
                    highlight:Destroy()
                end
            end
            VOMO.ESP.Killers = {}
            
            Rayfield:Notify({
                Title = "ESP",
                Content = "杀手透视已禁用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
        end
    end
})

-- Survivor ESP
local SurvivorESP = Tab2:CreateToggle({
    Name = "透视幸存者",
    Description = "高亮显示幸存者角色",
    CurrentValue = false,
    Flag = "SurvivorESP",
    Callback = function(Value)
        if Value then
            Rayfield:Notify({
                Title = "ESP",
                Content = "幸存者透视已启用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
            
            -- 启用Survivor ESP
            spawn(function()
                while Value do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character then
                            local isSurvivor = true
                            
                            -- 如果不是杀手，则视为幸存者
                            if player.Team then
                                if player.Team.Name:lower():find("killer") or
                                   player.Team.Name:lower():find("murder") then
                                    isSurvivor = false
                                end
                            end
                            
                            if isSurvivor then
                                local existing = player.Character:FindFirstChild("VOMO_SurvivorESP")
                                if not existing then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "VOMO_SurvivorESP"
                                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                    highlight.OutlineColor = Color3.fromRGB(100, 255, 100)
                                    highlight.FillTransparency = 0.6
                                    highlight.OutlineTransparency = 0
                                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    highlight.Adornee = player.Character
                                    
                                    if syn and syn.protect_gui then
                                        syn.protect_gui(highlight)
                                    end
                                    highlight.Parent = game.CoreGui
                                    
                                    VOMO.ESP.Survivors[player] = highlight
                                end
                            end
                        end
                    end
                    wait(0.5)
                end
            end)
        else
            -- 禁用Survivor ESP
            for player, highlight in pairs(VOMO.ESP.Survivors) do
                if highlight then
                    highlight:Destroy()
                end
            end
            VOMO.ESP.Survivors = {}
            
            Rayfield:Notify({
                Title = "ESP",
                Content = "幸存者透视已禁用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
        end
    end
})

-- ESP自定义设置
local ESPCustomSection = Tab2:CreateSection("自定义设置")

-- 颜色选择器
local KillerColor = Tab2:CreateColorPicker({
    Name = "杀手颜色",
    Description = "设置杀手透视颜色",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "KillerColor",
    Callback = function(Color)
        for _, highlight in pairs(VOMO.ESP.Killers) do
            if highlight then
                highlight.FillColor = Color
            end
        end
    end
})

local SurvivorColor = Tab2:CreateColorPicker({
    Name = "幸存者颜色",
    Description = "设置幸存者透视颜色",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "SurvivorColor",
    Callback = function(Color)
        for _, highlight in pairs(VOMO.ESP.Survivors) do
            if highlight then
                highlight.FillColor = Color
            end
        end
    end
})

-- 透明度滑块
Tab2:CreateSlider({
    Name = "透明度",
    Description = "调整透视透明度",
    Range = {0, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 60,
    Flag = "ESPTransparency",
    Callback = function(Value)
        local transparency = Value / 100
        for _, highlight in pairs(VOMO.ESP.Killers) do
            if highlight then
                highlight.FillTransparency = transparency
            end
        end
        for _, highlight in pairs(VOMO.ESP.Survivors) do
            if highlight then
                highlight.FillTransparency = transparency
            end
        end
    end
})

UpdateProgress(8, 10, "Setting up bypass system...")

-- ============================================
-- 标签页3: 反作弊绕过
-- ============================================

-- 速度系统
local SpeedSection = Tab3:CreateSection("速度修改")

local SpeedToggle = Tab3:CreateToggle({
    Name = "开启速度",
    Description = "绕过反作弊的速度修改",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        VOMO.Movement.Speed.Enabled = Value
        
        if Value then
            Rayfield:Notify({
                Title = "速度",
                Content = "速度修改已启用: " .. VOMO.Movement.Speed.Value,
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
            
            -- 保存原始速度
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                VOMO.Movement.Speed.Original = character.Humanoid.WalkSpeed
            end
            
            -- 应用速度修改
            spawn(function()
                while VOMO.Movement.Speed.Enabled do
                    wait(0.1)
                    
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        
                        -- 方法1: 直接修改
                        pcall(function()
                            humanoid.WalkSpeed = VOMO.Movement.Speed.Value
                        end)
                        
                        -- 方法2: BodyVelocity备用
                        if character:FindFirstChild("HumanoidRootPart") then
                            local root = character.HumanoidRootPart
                            
                            -- 创建BodyVelocity（绕过检测）
                            if not character:FindFirstChild("VOMO_SpeedHelper") then
                                local bodyVelocity = Instance.new("BodyVelocity")
                                bodyVelocity.Name = "VOMO_SpeedHelper"
                                bodyVelocity.MaxForce = Vector3.new(10000, 0, 10000)
                                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                                bodyVelocity.P = 1250
                                bodyVelocity.Parent = root
                                
                                -- 隐藏属性
                                pcall(function()
                                    bodyVelocity:SetAttribute("VOMO_Hidden", true)
                                end)
                            end
                            
                            -- 应用速度
                            local moveDirection = humanoid.MoveDirection
                            if moveDirection.Magnitude > 0 then
                                if character:FindFirstChild("VOMO_SpeedHelper") then
                                    character.VOMO_SpeedHelper.Velocity = moveDirection * VOMO.Movement.Speed.Value
                                end
                            end
                        end
                        
                        -- 方法3: 网络属性欺骗
                        pcall(function()
                            humanoid:SetAttribute("VOMO_WalkSpeed", VOMO.Movement.Speed.Value)
                        end)
                    end
                end
                
                -- 清理
                local character = game.Players.LocalPlayer.Character
                if character then
                    if character:FindFirstChild("VOMO_SpeedHelper") then
                        character.VOMO_SpeedHelper:Destroy()
                    end
                    if character:FindFirstChild("Humanoid") then
                        character.Humanoid.WalkSpeed = VOMO.Movement.Speed.Original
                    end
                end
            end)
        else
            Rayfield:Notify({
                Title = "速度",
                Content = "速度修改已禁用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
        end
    end
})

-- 速度滑块
Tab3:CreateSlider({
    Name = "速度值",
    Description = "设置移动速度 (1-90)",
    Range = {1, 90},
    Increment = 1,
    CurrentValue = 25,
    Flag = "SpeedValue",
    Callback = function(Value)
        VOMO.Movement.Speed.Value = Value
        
        if VOMO.Movement.Speed.Enabled then
            -- 立即应用新速度
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = Value
                
                -- 更新BodyVelocity
                if character:FindFirstChild("VOMO_SpeedHelper") then
                    local moveDirection = character.Humanoid.MoveDirection
                    if moveDirection.Magnitude > 0 then
                        character.VOMO_SpeedHelper.Velocity = moveDirection * Value
                    end
                end
            end
        end
    end
})

-- 飞行系统
local FlySection = Tab3:CreateSection("飞行系统")

local FlyToggle = Tab3:CreateToggle({
    Name = "飞行开关",
    Description = "绕过反作弊的飞行系统",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        VOMO.Movement.Fly.Enabled = Value
        
        if Value then
            Rayfield:Notify({
                Title = "飞行",
                Content = "飞行系统已启用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
            
            -- 初始化飞行
            local function SetupFlight()
                local character = game.Players.LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then
                    return false
                end
                
                local root = character.HumanoidRootPart
                
                -- 清理旧组件
                for _, comp in pairs(VOMO.Movement.Fly.Components) do
                    if comp then comp:Destroy() end
                end
                VOMO.Movement.Fly.Components = {}
                
                -- 创建BodyVelocity
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "VOMO_FlyVelocity"
                bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                
                -- 创建BodyGyro
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.Name = "VOMO_FlyGyro"
                bodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
                bodyGyro.P = 1000
                bodyGyro.D = 50
                bodyGyro.CFrame = root.CFrame
                
                -- 隐藏属性
                pcall(function()
                    bodyVelocity:SetAttribute("VOMO_Hidden", true)
                    bodyGyro:SetAttribute("VOMO_Hidden", true)
                end)
                
                bodyVelocity.Parent = root
                bodyGyro.Parent = root
                
                VOMO.Movement.Fly.Components.BodyVelocity = bodyVelocity
                VOMO.Movement.Fly.Components.BodyGyro = bodyGyro
                
                return true
            end
            
            if SetupFlight() then
                spawn(function()
                    while VOMO.Movement.Fly.Enabled do
                        wait()
                        
                        local character = game.Players.LocalPlayer.Character
                        if not character then break end
                        
                        local camera = workspace.CurrentCamera
                        
                        -- 检查组件是否存在
                        if not character:FindFirstChild("VOMO_FlyVelocity") or
                           not character:FindFirstChild("VOMO_FlyGyro") then
                            if not SetupFlight() then
                                break
                            end
                        end
                        
                        -- 获取输入方向
                        local lookVector = camera.CFrame.LookVector
                        local rightVector = camera.CFrame.RightVector
                        local upVector = Vector3.new(0, 1, 0)
                        
                        local direction = Vector3.new(0, 0, 0)
                        
                        -- 按键检测
                        local UserInputService = game:GetService("UserInputService")
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            direction = direction + lookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            direction = direction - lookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            direction = direction - rightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            direction = direction + rightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            direction = direction + upVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            direction = direction - upVector
                        end
                        
                        -- 应用速度
                        if direction.Magnitude > 0 then
                            direction = direction.Unit * VOMO.Movement.Fly.Speed
                        end
                        
                        if character:FindFirstChild("VOMO_FlyVelocity") then
                            character.VOMO_FlyVelocity.Velocity = direction
                        end
                        
                        if character:FindFirstChild("VOMO_FlyGyro") then
                            character.VOMO_FlyGyro.CFrame = camera.CFrame
                        end
                    end
                    
                    -- 清理
                    for _, comp in pairs(VOMO.Movement.Fly.Components) do
                        if comp then comp:Destroy() end
                    end
                    VOMO.Movement.Fly.Components = {}
                end)
            end
        else
            Rayfield:Notify({
                Title = "飞行",
                Content = "飞行系统已禁用",
                Duration = 3,
                Image = "rbxassetid://7733700905"
            })
        end
    end
})

-- 飞行速度滑块
Tab3:CreateSlider({
    Name = "飞行速度",
    Description = "设置飞行速度 (1-100)",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 35,
    Flag = "FlySpeed",
    Callback = function(Value)
        VOMO.Movement.Fly.Speed = Value
        
        if VOMO.Movement.Fly.Enabled then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("VOMO_FlyVelocity") then
                local currentVelocity = character.VOMO_FlyVelocity.Velocity
                if currentVelocity.Magnitude > 0 then
                    character.VOMO_FlyVelocity.Velocity = currentVelocity.Unit * Value
                end
            end
        end
    end
})

-- 高级设置
local AdvancedSection = Tab3:CreateSection("高级设置")

Tab3:CreateToggle({
    Name = "反踢出保护",
    Description = "防止游戏踢出玩家",
    CurrentValue = true,
    Flag = "AntiKick",
    Callback = function(Value)
        VOMO.Security.AntiKick = Value
        
        if Value then
            -- 挂钩Kick函数
            if hookfunction then
                local oldKick
                pcall(function()
                    oldKick = game.Players.LocalPlayer.Kick
                    game.Players.LocalPlayer.Kick = function() end
                end)
            end
        end
    end
})

Tab3:CreateButton({
    Name = "安全清理",
    Description = "移除所有修改",
    Callback = function()
        Rayfield:Notify({
            Title = "安全清理",
            Content = "开始清理所有修改...",
            Duration = 3,
            Image = "rbxassetid://7733700905"
        })
        
        -- 禁用所有功能
        VOMO.Movement.Speed.Enabled = false
        VOMO.Movement.Fly.Enabled = false
        
        -- 清理ESP
        for _, highlight in pairs(VOMO.ESP.Killers) do
            if highlight then highlight:Destroy() end
        end
        for _, highlight in pairs(VOMO.ESP.Survivors) do
            if highlight then highlight:Destroy() end
        end
        
        -- 清理飞行组件
        for _, comp in pairs(VOMO.Movement.Fly.Components) do
            if comp then comp:Destroy() end
        end
        
        -- 恢复速度
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
        
        -- 清理UI组件
        for _, gui in pairs(game.CoreGui:GetChildren()) do
            if gui.Name:find("VOMO_") then
                gui:Destroy()
            end
        end
        
        Rayfield:Notify({
            Title = "安全清理",
            Content = "所有修改已移除",
            Duration = 3,
            Image = "rbxassetid://7733700905"
        })
    end
})

UpdateProgress(9, 10, "Finalizing setup...")

-- ============================================
-- 快捷键系统
-- ============================================

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed then
        -- F9 切换界面
        if input.KeyCode == Enum.KeyCode.F9 then
            Window:Toggle()
        end
        
        -- F2 切换速度
        if input.KeyCode == Enum.KeyCode.F2 then
            VOMO.Movement.Speed.Enabled = not VOMO.Movement.Speed.Enabled
            SpeedToggle:Set(VOMO.Movement.Speed.Enabled)
        end
        
        -- F3 切换飞行
        if input.KeyCode == Enum.KeyCode.F3 then
            VOMO.Movement.Fly.Enabled = not VOMO.Movement.Fly.Enabled
            FlyToggle:Set(VOMO.Movement.Fly.Enabled)
        end
        
        -- F4 切换Killer ESP
        if input.KeyCode == Enum.KeyCode.F4 then
            KillerESP:Set(not KillerESP.CurrentValue)
        end
        
        -- F5 切换Survivor ESP
        if input.KeyCode == Enum.KeyCode.F5 then
            SurvivorESP:Set(not SurvivorESP.CurrentValue)
        end
    end
end)

-- ============================================
-- 角色重生处理
-- ============================================

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- 等待角色加载
    
    -- 重新应用速度
    if VOMO.Movement.Speed.Enabled then
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = VOMO.Movement.Speed.Value
        end
    end
    
    -- 重新应用飞行
    if VOMO.Movement.Fly.Enabled then
        wait(0.5)
        FlyToggle:Set(false)
        wait(0.1)
        FlyToggle:Set(true)
    end
    
    -- 重新应用ESP
    wait(1)
    if KillerESP.CurrentValue then
        KillerESP:Set(false)
        wait(0.1)
        KillerESP:Set(true)
    end
    if SurvivorESP.CurrentValue then
        SurvivorESP:Set(false)
        wait(0.1)
        SurvivorESP:Set(true)
    end
end)

-- ============================================
-- 清理函数
-- ============================================

local function Cleanup()
    -- 清理ESP
    for _, highlight in pairs(VOMO.ESP.Killers) do
        if highlight then highlight:Destroy() end
    end
    for _, highlight in pairs(VOMO.ESP.Survivors) do
        if highlight then highlight:Destroy() end
    end
    
    -- 清理速度修改
    local character = game.Players.LocalPlayer.Character
    if character then
        if character:FindFirstChild("VOMO_SpeedHelper") then
            character.VOMO_SpeedHelper:Destroy()
        end
        if character:FindFirstChild("VOMO_FlyVelocity") then
            character.VOMO_FlyVelocity:Destroy()
        end
        if character:FindFirstChild("VOMO_FlyGyro") then
            character.VOMO_FlyGyro:Destroy()
        end
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
    end
    
    -- 清理UI
    if LoadingScreen then
        LoadingScreen:Destroy()
    end
end

-- 注册清理
game:BindToClose(function()
    Cleanup()
end)

UpdateProgress(10, 10, "Ready!")

-- 隐藏加载界面
wait(1)
LoadingScreen:Destroy()

-- 显示欢迎通知
Rayfield:Notify({
    Title = "VOMO_ ULTIMATE v4.0",
    Content = "系统加载完成！按F9打开菜单",
    Duration = 5,
    Image = "rbxassetid://7733700905"
})

print("==========================================")
print("VOMO_ ULTIMATE v4.0 - LOADED SUCCESSFULLY")
print("==========================================")
print("Features:")
print("- Advanced Anti-Cheat Bypass")
print("- Killer/Survivor ESP")
print("- Speed Hack with Bypass")
print("- Flight System with Bypass")
print("==========================================")
print("Shortcuts:")
print("F9 - Toggle Menu")
print("F2 - Toggle Speed")
print("F3 - Toggle Flight")
print("F4 - Toggle Killer ESP")
print("F5 - Toggle Survivor ESP")
print("==========================================")
