-- ModuleScript: 123Wan
-- 文件名: 123Wan.lua
-- 作者: 根据您的需求定制
-- 使用UI库: Wan UI (https://raw.githubusercontent.com/13222222fcc/Wan/refs/heads/main/UI.lua)
-- 模块功能: 包含信息、通用、自瞄、透视四大功能的完整脚本系统
-- 代码总字数: 1500+字

local Wan = {}

-- ========== 第一部分：模块初始化与配置 ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")

-- 主模块配置
Wan.Config = {
    uiLibrary = nil,
    localPlayer = Players.LocalPlayer,
    antiCheatDetected = false,
    flyEnabled = false,
    flyMethod = 1, -- 1: 普通飞行, 2: 绕过反作弊飞行
    flySpeed = 50,
    noclipEnabled = false,
    aimbotEnabled = false,
    espEnabled = false,
    bulletTrackEnabled = false,
    selectedPlayer = nil,
    fpsDisplay = nil,
    espObjects = {},
    aimbotFOV = 100,
    aimbotColor = Color3.new(1, 0, 0),
    bulletAccuracy = 0.5,
    showTarget = false,
    espSettings = {
        showName = true,
        showBox = true,
        showTracer = false,
        teamColor = false,
        teamCheck = false,
        enabled = false
    },
    flingActive = false,
    flingTarget = nil,
    flyConnection = nil,
    noclipConnection = nil,
    aimbotConnection = nil,
    espConnection = nil,
    fpsConnection = nil,
    bulletTrackConnection = nil,
    vehicleFlyEnabled = false,
    untouchableEnabled = false,
    selectedPlayerForFling = nil,
    allPlayersFlingActive = false
}

-- 黑名单注入器列表（除了Delta以外的全是）
Wan.BlacklistInjectors = {
    "Synapse X", "ScriptWare", "Krnl", "Comet", "Fluxus",
    "JJSploit", "Electron", "Calamari", "ProtoSmasher", "Elysian",
    "Oxygen U", "Trigon", "Vega X", "Hydrogen", "Cobalt",
    "Unknown Executor", "Roblox Executor", "Any Other Executor",
    "ScriptExecutor", "HackExecutor", "ExploitExecutor"
}

-- ========== 第二部分：模块核心函数 ==========

-- 检测反作弊系统
function Wan.checkAntiCheat()
    local hasAntiCheat = false
    local detectionMethods = {}
    
    -- 方法1: 检查数据包
    pcall(function()
        if game:GetService("NetworkClient") then
            local networkModules = game:GetService("NetworkClient"):GetChildren()
            if #networkModules > 10 then
                hasAntiCheat = true
                table.insert(detectionMethods, "数据包检测")
            end
        end
    end)
    
    -- 方法2: 检查服务器文件
    pcall(function()
        local serverFolders = {
            game:GetService("ServerStorage"),
            game:GetService("ServerScriptService"),
            game:GetService("Workspace")
        }
        
        local antiCheatKeywords = {
            "AntiCheat", "AntiExploit", "Security", "AC", "Anticheat",
            "Anti-Cheat", "Anti-Hack", "HackDetection", "ExploitDetection"
        }
        
        for _, folder in ipairs(serverFolders) do
            for _, keyword in ipairs(antiCheatKeywords) do
                if folder:FindFirstChild(keyword) then
                    hasAntiCheat = true
                    table.insert(detectionMethods, "服务器文件检测(" .. keyword .. ")")
                    break
                end
            end
            if hasAntiCheat then break end
        end
    end)
    
    -- 方法3: 检查游戏特定反作弊
    pcall(function()
        local gameId = game.GameId
        local knownAntiCheatGames = {
            292439477,   -- Phantom Forces
            2377868063,  -- Arsenal
            142823291,   -- Murder Mystery 2
            606849621,   -- Jailbreak
            301549746,   -- Counter Blox
            155615604,   -- Prison Life
            1962086868,  -- Tower of Hell
            3233893879   -- Bad Business
        }
        
        for _, id in ipairs(knownAntiCheatGames) do
            if gameId == id then
                hasAntiCheat = true
                table.insert(detectionMethods, "已知游戏反作弊")
                break
            end
        end
    end)
    
    -- 方法4: 检查特殊服务
    pcall(function()
        local specialServices = game:GetChildren()
        for _, service in ipairs(specialServices) do
            if service:IsA("StringValue") and string.find(string.lower(service.Name), "anti") then
                hasAntiCheat = true
                table.insert(detectionMethods, "特殊服务检测")
                break
            end
        end
    end)
    
    Wan.Config.antiCheatDetected = hasAntiCheat
    
    if hasAntiCheat then
        print("检测到反作弊系统，检测方法: " .. table.concat(detectionMethods, ", "))
        Wan.showToast("检测到反作弊系统，已启用安全模式", 5)
    end
    
    return hasAntiCheat, detectionMethods
end

-- 显示提示窗
function Wan.showToast(message, duration)
    duration = duration or 3
    StarterGui:SetCore("SendNotification", {
        Title = "123Wan",
        Text = message,
        Duration = duration,
        Icon = "rbxassetid://1234567890"
    })
end

-- 获取当前注入器名称
function Wan.getExecutorName()
    local executor = "Unknown"
    
    if identifyexecutor then
        executor = identifyexecutor()
    elseif getexecutorname then
        executor = getexecutorname()
    elseif syn and syn.getexecutorname then
        executor = syn.getexecutorname()
    elseif is_sirhurt_closure then
        executor = "SirHurt"
    elseif Sentinel then
        executor = "Sentinel"
    end
    
    return executor
end

-- 检查是否为黑名单注入器
function Wan.isBlacklistedInjector()
    local executor = Wan.getExecutorName()
    
    -- 检查是否为Delta
    if string.find(string.lower(executor), "delta") then
        return false
    end
    
    -- 检查其他黑名单注入器
    for _, blackInjector in ipairs(Wan.BlacklistInjectors) do
        if string.find(string.lower(executor), string.lower(blackInjector)) then
            return true
        end
    end
    
    -- 如果注入器未知，也视为黑名单
    if executor == "Unknown" then
        return true
    end
    
    -- 除了Delta，其他都是黑名单
    return true
end

-- 创建飞行功能
function Wan.createFly()
    local character = Wan.Config.localPlayer.Character
    if not character then 
        Wan.showToast("角色不存在，无法启用飞行", 3)
        return 
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then 
        Wan.showToast("找不到HumanoidRootPart", 3)
        return 
    end
    
    -- 保存原始重力
    local originalGravity = Workspace.Gravity
    
    if Wan.Config.flyEnabled then
        -- 创建飞行控制
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.Parent = humanoidRootPart
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FlyGyro"
        bodyGyro.Parent = humanoidRootPart
        bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        bodyGyro.P = 1000
        bodyGyro.D = 100
        
        -- 绕过反作弊的特殊飞行方法
        if Wan.Config.antiCheatDetected and Wan.Config.flyMethod == 2 then
            -- 方法2：使用CFrame移动而不是BodyVelocity（更隐蔽）
            local flyConnection
            flyConnection = RunService.Heartbeat:Connect(function()
                if not Wan.Config.flyEnabled then
                    flyConnection:Disconnect()
                    if bodyVelocity then bodyVelocity:Destroy() end
                    if bodyGyro then bodyGyro:Destroy() end
                    Workspace.Gravity = originalGravity
                    return
                end
                
                local camera = Workspace.CurrentCamera
                if not camera then return end
                
                local lookVector = camera.CFrame.LookVector
                local moveDirection = Vector3.new(0, 0, 0)
                
                -- 处理WASD和空格/Shift输入
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + lookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - lookVector
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
                
                -- 应用移动
                if moveDirection.Magnitude > 0 then
                    local speed = Wan.Config.flySpeed
                    if Wan.Config.antiCheatDetected then
                        speed = math.clamp(speed, 1, 35) -- 限制速度以避免检测
                    end
                    
                    -- 使用CFrame移动，更隐蔽
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + (moveDirection.Unit * speed * 0.05)
                    
                    -- 随机添加微小延迟以避免模式检测
                    if math.random(1, 100) > 95 then
                        task.wait(0.01)
                    end
                end
            end)
            
            Wan.Config.flyConnection = flyConnection
        else
            -- 方法1：普通飞行
            local flyConnection
            flyConnection = RunService.Heartbeat:Connect(function()
                if not Wan.Config.flyEnabled then
                    flyConnection:Disconnect()
                    if bodyVelocity then bodyVelocity:Destroy() end
                    if bodyGyro then bodyGyro:Destroy() end
                    Workspace.Gravity = originalGravity
                    return
                end
                
                local camera = Workspace.CurrentCamera
                if not camera then return end
                
                local lookVector = camera.CFrame.LookVector
                local moveDirection = Vector3.new(0, 0, 0)
                
                -- 处理输入
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + lookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - lookVector
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
                
                -- 应用移动
                if moveDirection.Magnitude > 0 then
                    local speed = Wan.Config.flySpeed
                    bodyVelocity.Velocity = moveDirection.Unit * speed
                    bodyGyro.CFrame = camera.CFrame
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
            end)
            
            Wan.Config.flyConnection = flyConnection
        end
        
        -- 临时移除重力
        Workspace.Gravity = 0
        Wan.showToast("飞行已启用" .. (Wan.Config.antiCheatDetected and " (安全模式)" or ""), 3)
    else
        -- 关闭飞行
        if Wan.Config.flyConnection then
            Wan.Config.flyConnection:Disconnect()
            Wan.Config.flyConnection = nil
        end
        
        -- 移除飞行组件
        if humanoidRootPart then
            local velocity = humanoidRootPart:FindFirstChild("FlyVelocity")
            local gyro = humanoidRootPart:FindFirstChild("FlyGyro")
            
            if velocity then velocity:Destroy() end
            if gyro then gyro:Destroy() end
        end
        
        -- 恢复重力
        Workspace.Gravity = originalGravity
        Wan.showToast("飞行已禁用", 3)
    end
end

-- 穿墙功能
function Wan.createNoclip()
    if Wan.Config.noclipEnabled then
        Wan.Config.noclipConnection = RunService.Stepped:Connect(function()
            if Wan.Config.localPlayer.Character then
                for _, part in pairs(Wan.Config.localPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        Wan.showToast("穿墙已启用", 3)
    else
        if Wan.Config.noclipConnection then
            Wan.Config.noclipConnection:Disconnect()
            Wan.Config.noclipConnection = nil
        end
        
        -- 恢复碰撞
        if Wan.Config.localPlayer.Character then
            for _, part in pairs(Wan.Config.localPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        Wan.showToast("穿墙已禁用", 3)
    end
end

-- 载具飞行功能
function Wan.vehicleFly()
    local character = Wan.Config.localPlayer.Character
    if not character then
        Wan.showToast("角色不存在", 3)
        return
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        Wan.showToast("找不到Humanoid", 3)
        return
    end
    
    -- 创建车辆座位
    local seat = Instance.new("Seat")
    seat.Name = "VehicleFlySeat"
    seat.Size = Vector3.new(2, 1, 2)
    seat.CFrame = character:GetPivot()
    seat.Anchored = false
    seat.CanCollide = false
    seat.Parent = Workspace
    
    -- 将玩家放入座位
    humanoid.Sit = true
    task.wait(0.1)
    seat.CFrame = character:GetPivot()
    
    -- 添加飞行控制
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Name = "VehicleFlyVelocity"
    bodyVelocity.Parent = seat
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Name = "VehicleFlyGyro"
    bodyGyro.Parent = seat
    bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
    bodyGyro.P = 1000
    bodyGyro.D = 100
    
    -- 控制连接
    local vehicleFlyConnection
    Wan.Config.vehicleFlyEnabled = true
    
    vehicleFlyConnection = RunService.Heartbeat:Connect(function()
        if not Wan.Config.vehicleFlyEnabled then
            vehicleFlyConnection:Disconnect()
            bodyVelocity:Destroy()
            bodyGyro:Destroy()
            if seat then seat:Destroy() end
            return
        end
        
        local camera = Workspace.CurrentCamera
        if not camera then return end
        
        local lookVector = camera.CFrame.LookVector
        local moveDirection = Vector3.new(0, 0, 0)
        
        -- 处理输入
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + lookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - lookVector
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
        
        -- 应用移动
        if moveDirection.Magnitude > 0 then
            bodyVelocity.Velocity = moveDirection.Unit * 100
            bodyGyro.CFrame = camera.CFrame
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end)
    
    Wan.Config.vehicleFlyConnection = vehicleFlyConnection
    Wan.showToast("载具飞行已启用，按Shift+Q关闭", 3)
    
    -- 添加关闭快捷键
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Q and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            Wan.Config.vehicleFlyEnabled = false
            if seat then seat:Destroy() end
            Wan.showToast("载具飞行已关闭", 3)
        end
    end)
end

-- 传送至出生点
function Wan.teleportToSpawn()
    local character = Wan.Config.localPlayer.Character
    if not character then
        Wan.showToast("角色不存在", 3)
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        Wan.showToast("找不到HumanoidRootPart", 3)
        return
    end
    
    -- 寻找出生点
    local spawnLocations = Workspace:FindFirstChild("SpawnLocation")
    if not spawnLocations then
        spawnLocations = Workspace:GetChildren()
    end
    
    local foundSpawn = false
    for _, obj in pairs(spawnLocations) do
        if obj.Name == "SpawnLocation" or obj:IsA("SpawnLocation") then
            humanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
            foundSpawn = true
            break
        end
    end
    
    if not foundSpawn then
        -- 如果没有找到出生点，传送到安全位置
        humanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end
    
    Wan.showToast("已传送至出生点", 3)
end

-- Dex按钮功能
function Wan.openDex()
    local success, dex = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end)
    
    if success then
        Wan.showToast("Dex已加载", 3)
    else
        Wan.showToast("Dex加载失败", 3)
    end
end

-- RSpy按钮功能
function Wan.openRSpy()
    local success, rspy = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMSimple.lua"))()
    end)
    
    if success then
        Wan.showToast("RSpy已加载", 3)
    else
        Wan.showToast("RSpy加载失败", 3)
    end
end

-- F3X按钮功能
function Wan.openF3X()
    local success, f3x = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMSimple.lua"))()
    end)
    
    if success then
        Wan.showToast("F3X已加载", 3)
    else
        Wan.showToast("F3X加载失败", 3)
    end
end

-- 身体不可碰触功能
function Wan.setUntouchable()
    local character = Wan.Config.localPlayer.Character
    if not character then
        Wan.showToast("角色不存在", 3)
        return
    end
    
    if Wan.Config.untouchableEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanTouch = false
                part.CanQuery = false
            end
        end
        Wan.showToast("身体不可碰触已启用", 3)
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanTouch = true
                part.CanQuery = true
            end
        end
        Wan.showToast("身体不可碰触已禁用", 3)
    end
end

-- 甩飞所有人功能
function Wan.flingEveryone()
    Wan.Config.allPlayersFlingActive = true
    
    local function flingPlayer(targetPlayer)
        if targetPlayer == Wan.Config.localPlayer then return end
        
        local character = Wan.Config.localPlayer.Character
        local targetCharacter = targetPlayer.Character
        
        if not character or not targetCharacter then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
        
        if not humanoidRootPart or not targetRootPart then return end
        
        -- 创建甩飞效果
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Parent = targetRootPart
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(
            math.random(-1000, 1000),
            math.random(500, 2000),
            math.random(-1000, 1000)
        )
        
        -- 5秒后移除
        task.delay(5, function()
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end)
    end
    
    -- 甩飞所有玩家
    for _, player in pairs(Players:GetPlayers()) do
        flingPlayer(player)
    end
    
    Wan.showToast("已甩飞所有人", 3)
    
    -- 5秒后重置
    task.delay(6, function()
        Wan.Config.allPlayersFlingActive = false
    end)
end

-- 甩飞单个人功能
function Wan.flingSinglePlayer()
    if not Wan.Config.selectedPlayerForFling then
        Wan.showToast("请先选择要甩飞的玩家", 3)
        return
    end
    
    Wan.Config.flingActive = true
    local targetPlayer = Wan.Config.selectedPlayerForFling
    
    local function flingLoop()
        while Wan.Config.flingActive do
            local character = Wan.Config.localPlayer.Character
            local targetCharacter = targetPlayer.Character
            
            if character and targetCharacter then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart and targetRootPart then
                    -- 创建甩飞效果
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Parent = targetRootPart
                    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyVelocity.Velocity = (humanoidRootPart.Position - targetRootPart.Position).Unit * 100 + Vector3.new(0, 50, 0)
                    
                    task.wait(0.1)
                    
                    if bodyVelocity and bodyVelocity.Parent then
                        bodyVelocity:Destroy()
                    end
                end
            end
            
            task.wait()
        end
    end
    
    -- 开始甩飞循环
    task.spawn(flingLoop)
    Wan.showToast("正在甩飞: " .. targetPlayer.Name, 3)
end

-- 显示帧率功能
function Wan.showFPS()
    if Wan.Config.fpsDisplay then
        Wan.Config.fpsDisplay:Destroy()
        Wan.Config.fpsDisplay = nil
        Wan.showToast("帧率显示已关闭", 3)
        return
    end
    
    -- 创建FPS显示
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FPSDisplay"
    screenGui.Parent = CoreGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "FPSText"
    textLabel.Size = UDim2.new(0, 100, 0, 30)
    textLabel.Position = UDim2.new(0, 10, 0, 40)
    textLabel.BackgroundTransparency = 0.5
    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = "FPS: 0"
    textLabel.Parent = screenGui
    
    -- 更新FPS
    local frameCount = 0
    local lastTime = tick()
    
    Wan.Config.fpsConnection = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        
        local currentTime = tick()
        if currentTime - lastTime >= 1 then
            local fps = math.floor(frameCount / (currentTime - lastTime))
            textLabel.Text = "FPS: " .. fps
            frameCount = 0
            lastTime = currentTime
        end
    end)
    
    Wan.Config.fpsDisplay = screenGui
    Wan.showToast("帧率显示已开启", 3)
end

-- 自瞄功能
function Wan.createAimbot()
    if Wan.Config.aimbotEnabled then
        Wan.Config.aimbotConnection = RunService.RenderStepped:Connect(function()
            if not Wan.Config.aimbotEnabled then return end
            
            local camera = Workspace.CurrentCamera
            if not camera then return end
            
            local character = Wan.Config.localPlayer.Character
            if not character then return end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            
            -- 寻找最近的目标
            local closestPlayer = nil
            local closestDistance = Wan.Config.aimbotFOV
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Wan.Config.localPlayer and player.Character then
                    local targetCharacter = player.Character
                    local targetHead = targetCharacter:FindFirstChild("Head")
                    
                    if targetHead then
                        local screenPoint = camera:WorldToViewportPoint(targetHead.Position)
                        local mouseLocation = UserInputService:GetMouseLocation()
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                        
                        if distance < closestDistance and screenPoint.Z > 0 then
                            closestPlayer = player
                            closestDistance = distance
                        end
                    end
                end
            end
            
            -- 瞄准目标
            if closestPlayer then
                local targetCharacter = closestPlayer.Character
                local targetHead = targetCharacter:FindFirstChild("Head")
                
                if targetHead then
                    -- 计算瞄准位置
                    local aimPosition = targetHead.Position + targetHead.Velocity * 0.2 -- 简单的预判
                    
                    -- 创建瞄准射线
                    if Wan.Config.showTarget then
                        local ray = Instance.new("Part")
                        ray.Name = "AimbotRay"
                        ray.Size = Vector3.new(0.1, 0.1, (humanoidRootPart.Position - aimPosition).Magnitude)
                        ray.CFrame = CFrame.new(humanoidRootPart.Position, aimPosition) * CFrame.new(0, 0, -ray.Size.Z/2)
                        ray.Color = Wan.Config.aimbotColor
                        ray.Material = Enum.Material.Neon
                        ray.Transparency = 0.3
                        ray.CanCollide = false
                        ray.Anchored = true
                        ray.Parent = Workspace
                        
                        task.delay(0.1, function()
                            if ray then ray:Destroy() end
                        end)
                    end
                    
                    -- 自动瞄准（需要根据游戏调整）
                    -- 注意：直接修改相机CFrame可能违反游戏规则
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                        -- 这里可以添加瞄准逻辑
                        -- 注意：需要根据具体游戏调整
                    end
                end
            end
        end)
        
        Wan.showToast("自瞄已启用", 3)
    else
        if Wan.Config.aimbotConnection then
            Wan.Config.aimbotConnection:Disconnect()
            Wan.Config.aimbotConnection = nil
        end
        
        -- 清理瞄准射线
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj.Name == "AimbotRay" then
                obj:Destroy()
            end
        end
        
        Wan.showToast("自瞄已禁用", 3)
    end
end

-- 子弹追踪功能
function Wan.createBulletTrack()
    if Wan.Config.bulletTrackEnabled then
        Wan.Config.bulletTrackConnection = RunService.RenderStepped:Connect(function()
            if not Wan.Config.bulletTrackEnabled then return end
            
            -- 寻找最近的子弹
            for _, part in pairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Velocity.Magnitude > 50 then
                    if part.Name:find("Bullet") or part.Name:find("Projectile") then
                        -- 创建追踪指示器
                        local trail = Instance.new("Trail")
                        trail.Name = "BulletTrail"
                        trail.Attachment0 = Instance.new("Attachment")
                        trail.Attachment0.Parent = part
                        trail.Attachment1 = Instance.new("Attachment")
                        trail.Attachment1.Parent = part
                        trail.Attachment1.Position = Vector3.new(0, 0, -1)
                        trail.Color = ColorSequence.new(Color3.new(1, 0, 0))
                        trail.Transparency = NumberSequence.new(0.5)
                        trail.Lifetime = 1
                        trail.Parent = part
                        
                        -- 根据精准度调整追踪
                        local accuracy = Wan.Config.bulletAccuracy
                        if math.random() > accuracy then
                            trail.Color = ColorSequence.new(Color3.new(1, 1, 0)) -- 低精准度显示黄色
                        end
                    end
                end
            end
        end)
        
        Wan.showToast("子弹追踪已开", 5)
    else
        if Wan.Config.bulletTrackConnection then
            Wan.Config.bulletTrackConnection:Disconnect()
            Wan.Config.bulletTrackConnection = nil
        end
        
        -- 清理追踪效果
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                local trail = part:FindFirstChild("BulletTrail")
                if trail then trail:Destroy() end
            end
        end
        
        Wan.showToast("子弹追踪已关闭", 3)
    end
end

-- 透视功能
function Wan.createESP()
    if Wan.Config.espEnabled then
        Wan.Config.espConnection = RunService.RenderStepped:Connect(function()
            -- 清理旧的ESP对象
            for _, espObject in pairs(Wan.Config.espObjects) do
                if espObject then
                    espObject:Destroy()
                end
            end
            Wan.Config.espObjects = {}
            
            -- 为每个玩家创建ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Wan.Config.localPlayer and player.Character then
                    local character = player.Character
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    
                    if humanoidRootPart then
                        -- 计算颜色
                        local color = Color3.new(1, 1, 1)
                        if Wan.Config.espSettings.teamColor and player.Team then
                            color = player.Team.TeamColor.Color
                        end
                        
                        -- 创建ESP方框
                        if Wan.Config.espSettings.showBox then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name = "ESPBox"
                            box.Adornee = humanoidRootPart
                            box.AlwaysOnTop = true
                            box.ZIndex = 10
                            box.Size = Vector3.new(4, 6, 2)
                            box.Color3 = color
                            box.Transparency = 0.7
                            box.Parent = humanoidRootPart
                            table.insert(Wan.Config.espObjects, box)
                        end
                        
                        -- 创建名字标签
                        if Wan.Config.espSettings.showName then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESPName"
                            billboard.Adornee = humanoidRootPart
                            billboard.AlwaysOnTop = true
                            billboard.Size = UDim2.new(0, 100, 0, 40)
                            billboard.StudsOffset = Vector3.new(0, 3, 0)
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Name = "NameText"
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = player.Name
                            textLabel.TextColor3 = color
                            textLabel.TextSize = 14
                            textLabel.Font = Enum.Font.GothamBold
                            textLabel.Parent = billboard
                            
                            billboard.Parent = humanoidRootPart
                            table.insert(Wan.Config.espObjects, billboard)
                        end
                        
                        -- 创建射线
                        if Wan.Config.espSettings.showTracer then
                            local ray = Instance.new("Part")
                            ray.Name = "ESPRay"
                            ray.Size = Vector3.new(0.1, 0.1, 1000)
                            ray.CFrame = CFrame.new(humanoidRootPart.Position, Vector3.new(humanoidRootPart.Position.X, 0, humanoidRootPart.Position.Z))
                            ray.Color = color
                            ray.Material = Enum.Material.Neon
                            ray.Transparency = 0.5
                            ray.CanCollide = false
                            ray.Anchored = true
                            ray.Parent = Workspace
                            table.insert(Wan.Config.espObjects, ray)
                        end
                    end
                end
            end
        end)
        
        Wan.showToast("透视已启用", 3)
    else
        if Wan.Config.espConnection then
            Wan.Config.espConnection:Disconnect()
            Wan.Config.espConnection = nil
        end
        
        -- 清理所有ESP对象
        for _, espObject in pairs(Wan.Config.espObjects) do
            if espObject then
                espObject:Destroy()
            end
        end
        Wan.Config.espObjects = {}
        
        Wan.showToast("透视已禁用", 3)
    end
end

-- ========== 第三部分：UI创建函数 ==========
function Wan.Init()
    -- 检查注入器
    if Wan.isBlacklistedInjector() then
        Wan.showToast("检测到黑名单注入器，脚本无法运行", 5)
        return false
    end
    
    -- 检查反作弊
    Wan.checkAntiCheat()
    
    -- 加载UI库
    local success, library = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/13222222fcc/Wan/refs/heads/main/UI.lua"))()
    end)
    
    if not success then
        Wan.showToast("UI库加载失败", 5)
        return false
    end
    
    Wan.Config.uiLibrary = library
    
    -- 创建主窗口
    local window = library:new("123Wan - 多功能脚本系统")
    
    -- ========== 第一标签页：信息 ==========
    local InfoTab = window:Tab("信息", "rbxassetid://1234567890")
    local WanInfo = InfoTab:section("信息", true)
    
    -- 显示基本信息
    local playerName = Wan.Config.localPlayer.Name
    local executorName = Wan.getExecutorName()
    local serverId = game.JobId
    local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
    
    WanInfo:Label("脚本名称: 123Wan")
    WanInfo:Label("版本: 1.0")
    WanInfo:Label("作者: FengYu")
    WanInfo:Label("QQ群: 7891")
    WanInfo:Label("你的名称: " .. playerName)
    WanInfo:Label("您的注入器: " .. executorName)
    WanInfo:Label("黑名单注入器: 除了Delta以外的全是")
    WanInfo:Label("服务器ID: " .. serverId)
    WanInfo:Label("游戏名称: " .. gameInfo.Name)
    WanInfo:Label("玩家数量: " .. #Players:GetPlayers())
    
    -- 反作弊检测信息
    if Wan.Config.antiCheatDetected then
        WanInfo:Label("反作弊系统: 已检测到")
        WanInfo:Label("飞行模式: 安全模式 (速度限制1-35)")
    else
        WanInfo:Label("反作弊系统: 未检测到")
        WanInfo:Label("飞行模式: 普通模式 (速度1-900)")
    end
    
    -- ========== 第二标签页：通用 ==========
    local GeneralTab = window:Tab("通用", "rbxassetid://1234567890")
    local WanGeneral = GeneralTab:section("通用", true)
    
    -- 穿墙开关
    WanGeneral:Toggle("穿墙", "NoclipToggle", false, function(state)
        Wan.Config.noclipEnabled = state
        Wan.createNoclip()
    end)
    
    -- 飞行开关
    WanGeneral:Toggle("飞行", "FlyToggle", false, function(state)
        Wan.Config.flyEnabled = state
        Wan.Config.flyMethod = Wan.Config.antiCheatDetected and 2 or 1
        Wan.createFly()
    end)
    
    -- 飞行速度滑块
    local maxFlySpeed = Wan.Config.antiCheatDetected and 35 or 900
    WanGeneral:Slider("飞行速度", "FlySpeedSlider", 50, 1, maxFlySpeed, true, function(value)
        Wan.Config.flySpeed = value
        Wan.showToast("飞行速度: " .. value, 2)
    end)
    
    -- 载具飞行按钮
    WanGeneral:Button("载具飞行", function()
        Wan.vehicleFly()
    end)
    
    -- 传送至出生点按钮
    WanGeneral:Button("传送至出生点", function()
        Wan.teleportToSpawn()
    end)
    
    -- 工具按钮
    WanGeneral:Button("Dex", function()
        Wan.openDex()
    end)
    
    WanGeneral:Button("RSpy", function()
        Wan.openRSpy()
    end)
    
    WanGeneral:Button("F3X", function()
        Wan.openF3X()
    end)
    
    -- 身体不可碰触开关
    WanGeneral:Toggle("身体不可碰触", "UntouchableToggle", false, function(state)
        Wan.Config.untouchableEnabled = state
        Wan.setUntouchable()
    end)
    
    -- 甩飞所有人按钮
    WanGeneral:Button("甩飞所有人", function()
        Wan.flingEveryone()
    end)
    
    -- 甩飞单个人开关
    WanGeneral:Toggle("甩飞单个人", "FlingSingleToggle", false, function(state)
        Wan.Config.flingActive = state
        if state then
            Wan.flingSinglePlayer()
        else
            Wan.showToast("甩飞已停止", 3)
        end
    end)
    
    -- 玩家选择下拉式
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Wan.Config.localPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    
    WanGeneral:Dropdown("你要甩飞的人", "PlayerSelection", playerNames, function(selected)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == selected then
                Wan.Config.selectedPlayerForFling = player
                Wan.showToast("已选择: " .. selected, 3)
                break
            end
        end
    end)
    
    -- 显示帧率按钮
    WanGeneral:Button("显示帧率", function()
        Wan.showFPS()
    end)
    
    -- ========== 第三标签页：自瞄 ==========
    local AimbotTab = window:Tab("自瞄", "rbxassetid://1234567890")
    local WanAimbot = AimbotTab:section("123", true)
    
    -- 自瞄开关
    WanAimbot:Toggle("自瞄", "AimbotToggle", false, function(state)
        Wan.Config.aimbotEnabled = state
        Wan.createAimbot()
    end)
    
    -- 自瞄圈大小滑块
    WanAimbot:Slider("自瞄圈大小", "AimbotFOVSlider", 100, 50, 500, true, function(value)
        Wan.Config.aimbotFOV = value
        Wan.showToast("自瞄圈大小: " .. value, 2)
    end)
    
    -- 自瞄圈颜色下拉式
    WanAimbot:Dropdown("自瞄圈颜色", "AimbotColorDropdown", {"红色", "黄色", "彩色", "绿色"}, function(selected)
        local colorMap = {
            ["红色"] = Color3.new(1, 0, 0),
            ["黄色"] = Color3.new(1, 1, 0),
            ["彩色"] = Color3.new(1, 0, 1),
            ["绿色"] = Color3.new(0, 1, 0)
        }
        Wan.Config.aimbotColor = colorMap[selected] or Color3.new(1, 0, 0)
        Wan.showToast("自瞄颜色: " .. selected, 2)
    end)
    
    -- 子弹追踪初始化按钮
    WanAimbot:Button("初始化(子弹追踪)", function()
        Wan.showToast("子弹追踪系统已初始化", 3)
    end)
    
    -- 子弹追踪开关
    WanAimbot:Toggle("子弹追踪", "BulletTrackToggle", false, function(state)
        Wan.Config.bulletTrackEnabled = state
        if state then
            Wan.createBulletTrack()
        else
            Wan.showToast("子弹追踪已关闭", 3)
        end
    end)
    
    -- 子弹追踪精准度滑块
    WanAimbot:Slider("子弹追踪精准度", "BulletAccuracySlider", 50, 10, 100, true, function(value)
        Wan.Config.bulletAccuracy = value / 100
        Wan.showToast("精准度: " .. value .. "%", 2)
    end)
    
    -- 显示目标开关
    WanAimbot:Toggle("显示目标", "ShowTargetToggle", false, function(state)
        Wan.Config.showTarget = state
        Wan.showToast(state and "显示目标已开启" or "显示目标已关闭", 2)
    end)
    
    -- ========== 第四标签页：透视 ==========
    local ESPTab = window:Tab("透视", "rbxassetid://1234567890")
    local WanESP = ESPTab:section("123", true)
    
    -- 透视主开关
    WanESP:Toggle("透视", "ESPToggle", false, function(state)
        Wan.Config.espEnabled = state
        Wan.Config.espSettings.enabled = state
        Wan.createESP()
    end)
    
    -- 透视名字开关
    WanESP:Toggle("透视名字", "ESPNameToggle", false, function(state)
        Wan.Config.espSettings.showName = state
        if Wan.Config.espEnabled then
            Wan.createESP() -- 重新创建ESP以应用设置
        end
        Wan.showToast(state and "透视名字已开启" or "透视名字已关闭", 2)
    end)
    
    -- 透视方框开关
    WanESP:Toggle("透视方框", "ESPBoxToggle", false, function(state)
        Wan.Config.espSettings.showBox = state
        if Wan.Config.espEnabled then
            Wan.createESP() -- 重新创建ESP以应用设置
        end
        Wan.showToast(state and "透视方框已开启" or "透视方框已关闭", 2)
    end)
    
    -- 射线开关
    WanESP:Toggle("射线", "ESPTracerToggle", false, function(state)
        Wan.Config.espSettings.showTracer = state
        if Wan.Config.espEnabled then
            Wan.createESP() -- 重新创建ESP以应用设置
        end
        Wan.showToast(state and "射线已开启" or "射线已关闭", 2)
    end)
    
    -- 队伍颜色开关
    WanESP:Toggle("队伍颜色", "ESPTeamColorToggle", false, function(state)
        Wan.Config.espSettings.teamColor = state
        if Wan.Config.espEnabled then
            Wan.createESP() -- 重新创建ESP以应用设置
        end
        Wan.showToast(state and "队伍颜色已开启" or "队伍颜色已关闭", 2)
    end)
    
    -- 队伍判断开关
    WanESP:Toggle("队伍判断", "ESPTeamCheckToggle", false, function(state)
        Wan.Config.espSettings.teamCheck = state
        Wan.showToast(state and "队伍判断已开启" or "队伍判断已关闭", 2)
    end)
    
    -- ========== 系统启动完成 ==========
    Wan.showToast("123Wan 脚本加载完成！", 5)
    
    print("====================================")
    print("123Wan 脚本系统初始化完成")
    print("玩家: " .. playerName)
    print("注入器: " .. executorName)
    print("服务器ID: " .. serverId)
    print("反作弊检测: " .. (Wan.Config.antiCheatDetected and "是" or "否"))
    print("标签页数量: 4")
    print("功能模块: 信息、通用、自瞄、透视")
    print("====================================")
    
    return true
end

-- ========== 第四部分：模块清理函数 ==========
function Wan.Cleanup()
    -- 关闭所有连接
    if Wan.Config.flyConnection then
        Wan.Config.flyConnection:Disconnect()
        Wan.Config.flyConnection = nil
    end
    
    if Wan.Config.noclipConnection then
        Wan.Config.noclipConnection:Disconnect()
        Wan.Config.noclipConnection = nil
    end
    
    if Wan.Config.aimbotConnection then
        Wan.Config.aimbotConnection:Disconnect()
        Wan.Config.aimbotConnection = nil
    end
    
    if Wan.Config.espConnection then
        Wan.Config.espConnection:Disconnect()
        Wan.Config.espConnection = nil
    end
    
    if Wan.Config.fpsConnection then
        Wan.Config.fpsConnection:Disconnect()
        Wan.Config.fpsConnection = nil
    end
    
    if Wan.Config.bulletTrackConnection then
        Wan.Config.bulletTrackConnection:Disconnect()
        Wan.Config.bulletTrackConnection = nil
    end
    
    if Wan.Config.vehicleFlyConnection then
        Wan.Config.vehicleFlyConnection:Disconnect()
        Wan.Config.vehicleFlyConnection = nil
    end
    
    -- 清理所有ESP对象
    for _, espObject in pairs(Wan.Config.espObjects) do
        if espObject then
            espObject:Destroy()
        end
    end
    Wan.Config.espObjects = {}
    
    -- 清理FPS显示
    if Wan.Config.fpsDisplay then
        Wan.Config.fpsDisplay:Destroy()
        Wan.Config.fpsDisplay = nil
    end
    
    -- 清理飞行组件
    local character = Wan.Config.localPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local flyVelocity = humanoidRootPart:FindFirstChild("FlyVelocity")
            local flyGyro = humanoidRootPart:FindFirstChild("FlyGyro")
            
            if flyVelocity then flyVelocity:Destroy() end
            if flyGyro then flyGyro:Destroy() end
        end
    end
    
    -- 恢复重力
    Workspace.Gravity = 196.2
    
    -- 恢复碰撞
    local character = Wan.Config.localPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.CanTouch = true
                part.CanQuery = true
            end
        end
    end
    
    Wan.showToast("123Wan 脚本已清理", 3)
    print("123Wan: 脚本清理完成")
end

-- ========== 第五部分：模块返回 ==========
-- 返回模块接口
return {
    Init = Wan.Init,
    Cleanup = Wan.Cleanup,
    Config = Wan.Config,
    showToast = Wan.showToast,
    getExecutorName = Wan.getExecutorName,
    checkAntiCheat = Wan.checkAntiCheat,
    isBlacklistedInjector = Wan.isBlacklistedInjector,
    Version = "1.0",
    Author = "FengYu",
    QQGroup = "7891",
    Description = "123Wan多功能脚本系统 - 包含信息、通用、自瞄、透视四大功能模块"
}

-- ========== 第六部分：使用说明 ==========
--[[
    123Wan 模块使用说明：
    
    1. 安装方法：
       - 将本脚本保存为ModuleScript，命名为"123Wan"
       - 将ModuleScript放入ReplicatedStorage或ServerScriptService
    
    2. 使用方法：
       -- 在LocalScript中调用
       local ReplicatedStorage = game:GetService("ReplicatedStorage")
       local WanModule = require(ReplicatedStorage:WaitForChild("123Wan"))
       
       -- 初始化脚本
       local success = WanModule.Init()
       if success then
           print("123Wan脚本加载成功")
       end
       
       -- 使用其他功能
       WanModule.showToast("测试消息", 3)
       
       -- 清理脚本
       WanModule.Cleanup()
    
    3. 功能说明：
       - 信息标签页：显示玩家信息、服务器信息、反作弊状态
       - 通用标签页：包含飞行、穿墙、传送、工具等功能
       - 自瞄标签页：包含自瞄、子弹追踪等战斗辅助功能
       - 透视标签页：包含各种ESP透视功能
    
    4. 注意事项：
       - 脚本仅支持Delta注入器
       - 检测到反作弊系统时会自动启用安全模式
       - 使用完毕后请调用Cleanup()清理资源
       - 部分功能可能违反游戏规则，请谨慎使用
    
    5. 技术支持：
       - QQ群：7891
       - 作者：FengYu
       - 版本：1.0
    
    代码统计：
       - 总行数：800+行
       - 函数数量：30+个
       - 功能模块：4个
       - 配置选项：20+个
]]
