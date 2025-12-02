-- ROBLOX脚本 - 使用Feng UI库
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- 加载UI库
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/13222222fcc/Wan/refs/heads/main/Feng.lua"))()

-- 创建主窗口
local Window = Library:CreateWindow({
    Title = "游戏增强菜单",
    Icon = "rbxassetid://123456789", -- 可以替换为你的图标ID
    Drag = true,
    Size = UDim2.new(0, 500, 0, 400)
})

-- 标签1: 你的信息
local Tab1 = Window:Tab("你的信息", "rbxassetid://123456789") -- 替换图标ID

-- 国家显示
local country = "未知"
-- 尝试获取国家信息
pcall(function()
    local geo = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(Players.LocalPlayer)
    if geo == "CN" then
        country = "中国"
    elseif geo == "US" then
        country = "美国"
    elseif geo == "JP" then
        country = "日本"
    elseif geo == "KR" then
        country = "韩国"
    elseif geo == "RU" then
        country = "俄罗斯"
    else
        country = geo
    end
end)

Tab1:Label("国家: " .. country)

-- 注入器信息
Tab1:Label("玩家的注入器: FengYu Injector v2.0")

-- 玩家名称
local player = Players.LocalPlayer
Tab1:Label("玩家名称: " .. player.Name)
Tab1:Label("玩家ID: " .. tostring(player.UserId))

-- 时间显示
local timeText = Tab1:Label("时间: " .. os.date("%Y-%m-%d %H:%M:%S"))

-- 更新时间的循环
spawn(function()
    while true do
        timeText:Set("时间: " .. os.date("%Y-%m-%d %H:%M:%S"))
        wait(1)
    end
end)

-- 玩家虚拟形象部分
Tab1:Line()
Tab1:Label("玩家虚拟形象")
local avatarFrame = Tab1:Frame({
    Size = UDim2.new(0, 150, 0, 200),
    Position = UDim2.new(0.5, -75, 0, 150)
})

-- 尝试加载玩家头像
spawn(function()
    local thumbnail
    pcall(function()
        thumbnail = Players:GetUserThumbnailAsync(
            player.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size420x420
        )
    end)
    
    if thumbnail then
        -- 创建头像图像
        local avatarImage = Instance.new("ImageLabel")
        avatarImage.Size = UDim2.new(1, 0, 1, 0)
        avatarImage.Image = thumbnail
        avatarImage.BackgroundTransparency = 1
        avatarImage.Parent = avatarFrame:GetObject()
    else
        Tab1:Label("无法加载头像")
    end
end)

-- 标签2: 透视功能
local Tab2 = Window:Tab("透视功能", "rbxassetid://123456789") -- 替换图标ID

-- 杀手透视开关
local killerESPEnabled = false
local killerESPHighlights = {}

Tab2:Toggle("杀手透视", false, function(state)
    killerESPEnabled = state
    if state then
        enableKillerESP()
    else
        disableKillerESP()
    end
end)

-- 幸存者透视开关
local survivorESPEnabled = false
local survivorESPHighlights = {}

Tab2:Toggle("幸存者透视", false, function(state)
    survivorESPEnabled = state
    if state then
        enableSurvivorESP()
    else
        disableSurvivorESP()
    end
end)

-- 发电机透视开关
local generatorESPEnabled = false
local generatorESPHighlights = {}

Tab2:Toggle("发电机透视", false, function(state)
    generatorESPEnabled = state
    if state then
        enableGeneratorESP()
    else
        disableGeneratorESP()
    end
end)

-- 透视功能实现
function enableKillerESP()
    local killers = {
        "JohnDoe",      -- 约翰多
        "coolkidd",     -- coolkidd
        "1x1x1x1",      -- 1x1x1x1
        "noli",         -- noli
        "Visitor666"    -- 访客666
    }
    
    for _, killerName in pairs(killers) do
        local playerObj = findPlayerByName(killerName)
        if playerObj and playerObj.Character then
            createESP(playerObj.Character, Color3.fromRGB(255, 0, 0), "杀手: " .. killerName, killerName)
        end
    end
end

function disableKillerESP()
    for playerName, highlight in pairs(killerESPHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    killerESPHighlights = {}
end

function enableSurvivorESP()
    local survivors = {
        "Shedletsky",   -- 谢德莱次基
        "Visitor1337",  -- 访客1337
        "Veronica",     -- 维罗妮卡
        "Dusekar",      -- 杜塞卡尔
        "NOOB",         -- NOOB
        "Pizza"         -- 披萨
    }
    
    for _, survivorName in pairs(survivors) do
        local playerObj = findPlayerByName(survivorName)
        if playerObj and playerObj.Character then
            createESP(playerObj.Character, Color3.fromRGB(0, 255, 0), "幸存者: " .. survivorName, survivorName)
        end
    end
end

function disableSurvivorESP()
    for playerName, highlight in pairs(survivorESPHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    survivorESPHighlights = {}
end

function enableGeneratorESP()
    -- 在工作区查找所有发电机
    local generators = workspace:GetDescendants()
    for _, obj in pairs(generators) do
        if obj.Name:lower():find("generator") or obj.Name:lower():find("发电机") then
            createESP(obj, Color3.fromRGB(255, 255, 0), "发电机", obj.Name)
        end
    end
end

function disableGeneratorESP()
    for objName, highlight in pairs(generatorESPHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    generatorESPHighlights = {}
end

-- 通用ESP创建函数
function createESP(target, color, label, id)
    if not target then return end
    
    -- 如果已有高亮，先移除
    if target:FindFirstChild("ESP_Highlight") then
        target:FindFirstChild("ESP_Highlight"):Destroy()
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = target
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = target
    
    -- 添加标签
    if label then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Label"
        billboard.Adornee = target
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = label
        textLabel.TextColor3 = color
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = billboard
        
        billboard.Parent = target
    end
    
    -- 存储引用
    if id then
        if target.Parent == workspace then
            generatorESPHighlights[id] = highlight
        elseif target:IsDescendantOf(Players.LocalPlayer.Character) == false then
            if killerESPEnabled then
                killerESPHighlights[id] = highlight
            elseif survivorESPEnabled then
                survivorESPHighlights[id] = highlight
            end
        end
    end
    
    return highlight
end

function findPlayerByName(name)
    for _, playerObj in pairs(Players:GetPlayers()) do
        if string.lower(playerObj.Name) == string.lower(name) then
            return playerObj
        end
    end
    return nil
end

-- 监听新玩家加入
Players.PlayerAdded:Connect(function(playerObj)
    wait(1) -- 等待玩家加载
    
    if killerESPEnabled then
        local killers = {"JohnDoe", "coolkidd", "1x1x1x1", "noli", "Visitor666"}
        for _, killerName in pairs(killers) do
            if string.lower(playerObj.Name) == string.lower(killerName) then
                if playerObj.Character then
                    createESP(playerObj.Character, Color3.fromRGB(255, 0, 0), "杀手: " .. killerName, killerName)
                end
            end
        end
    end
    
    if survivorESPEnabled then
        local survivors = {"Shedletsky", "Visitor1337", "Veronica", "Dusekar", "NOOB", "Pizza"}
        for _, survivorName in pairs(survivors) do
            if string.lower(playerObj.Name) == string.lower(survivorName) then
                if playerObj.Character then
                    createESP(playerObj.Character, Color3.fromRGB(0, 255, 0), "幸存者: " .. survivorName, survivorName)
                end
            end
        end
    end
end)

-- 标签3: 基础功能
local Tab3 = Window:Tab("基础功能", "rbxassetid://123456789") -- 替换图标ID

-- 无限体力开关
local infiniteStaminaEnabled = false
local staminaLoop

Tab3:Toggle("无限体力", false, function(state)
    infiniteStaminaEnabled = state
    
    if state then
        -- 启用无限体力
        if staminaLoop then
            staminaLoop:Disconnect()
        end
        
        staminaLoop = RunService.Heartbeat:Connect(function()
            -- 查找体力条
            local staminaBar = findStaminaBar()
            if staminaBar then
                if staminaBar:IsA("NumberValue") or staminaBar:IsA("IntValue") then
                    staminaBar.Value = 99999999
                elseif staminaBar:IsA("Frame") then
                    -- 假设是进度条样式的体力条
                    staminaBar.Size = UDim2.new(1, 0, 1, 0)
                end
            end
        end)
    else
        -- 禁用无限体力
        if staminaLoop then
            staminaLoop:Disconnect()
            staminaLoop = nil
        end
        
        -- 恢复体力值
        local staminaBar = findStaminaBar()
        if staminaBar then
            if staminaBar:IsA("NumberValue") or staminaBar:IsA("IntValue") then
                staminaBar.Value = 100
            elseif staminaBar:IsA("Frame") then
                staminaBar.Size = UDim2.new(0.5, 0, 1, 0) -- 假设50%体力
            end
        end
    end
end)

-- 查找体力条
function findStaminaBar()
    local player = Players.LocalPlayer
    if not player.Character then return nil end
    
    -- 在角色中查找
    local staminaNames = {"StaminaBar", "Stamina", "Energy", "StaminaValue", "体力条", "体力"}
    
    for _, name in pairs(staminaNames) do
        -- 在角色中查找
        local stamina = player.Character:FindFirstChild(name, true)
        if stamina then
            return stamina
        end
        
        -- 在PlayerGui中查找
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui then
            stamina = playerGui:FindFirstChild(name, true)
            if stamina then
                return stamina
            end
        end
        
        -- 在StarterGui中查找
        local starterGui = game:GetService("StarterGui")
        stamina = starterGui:FindFirstChild(name, true)
        if stamina then
            return stamina
        end
    end
    
    return nil
end

-- 自动修复发电机开关
local autoRepairEnabled = false
local repairLoop

Tab3:Toggle("自动修复发电机", false, function(state)
    autoRepairEnabled = state
    
    if state then
        -- 启用自动修复
        if repairLoop then
            repairLoop:Disconnect()
        end
        
        repairLoop = RunService.Heartbeat:Connect(function(deltaTime)
            -- 每2.5秒修复一次
            local timePassed = deltaTime
            local repairInterval = 2.5
            
            -- 查找所有发电机
            local generators = workspace:GetDescendants()
            for _, obj in pairs(generators) do
                if obj.Name:lower():find("generator") or obj.Name:lower():find("发电机") then
                    -- 查找发电机进度值
                    local progress = obj:FindFirstChild("Progress") or 
                                   obj:FindFirstChild("Value") or
                                   obj:FindFirstChild("Completion")
                    
                    if progress and (progress:IsA("NumberValue") or progress:IsA("IntValue")) then
                        -- 每2.5秒增加1
                        local timer = obj:FindFirstChild("RepairTimer")
                        if not timer then
                            timer = Instance.new("NumberValue")
                            timer.Name = "RepairTimer"
                            timer.Value = 0
                            timer.Parent = obj
                        end
                        
                        timer.Value = timer.Value + deltaTime
                        
                        if timer.Value >= repairInterval then
                            progress.Value = math.min(progress.Value + 1, 100)
                            timer.Value = 0
                        end
                    end
                end
            end
        end)
    else
        -- 禁用自动修复
        if repairLoop then
            repairLoop:Disconnect()
            repairLoop = nil
        end
    end
end)

-- 速度开关
local speedHackEnabled = false
local originalWalkSpeed = 16
local speedLoop

Tab3:Toggle("速度开关", false, function(state)
    speedHackEnabled = state
    
    if state then
        -- 启用速度hack
        local humanoid = getHumanoid()
        if humanoid then
            originalWalkSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = 50 -- 设置新的速度
            
            -- 持续监控
            speedLoop = RunService.Heartbeat:Connect(function()
                local currentHumanoid = getHumanoid()
                if currentHumanoid and currentHumanoid.WalkSpeed < 50 then
                    currentHumanoid.WalkSpeed = 50
                end
            end)
        end
    else
        -- 禁用速度hack
        if speedLoop then
            speedLoop:Disconnect()
            speedLoop = nil
        end
        
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = originalWalkSpeed
        end
    end
end)

function getHumanoid()
    local player = Players.LocalPlayer
    if player and player.Character then
        return player.Character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

-- 绕过反作弊系统开关
local antiCheatBypassEnabled = false

Tab3:Toggle("绕过反作弊系统", false, function(state)
    antiCheatBypassEnabled = state
    
    if state then
        -- 启用反作弊绕过
        enableAntiCheatBypass()
    else
        -- 禁用反作弊绕过
        disableAntiCheatBypass()
    end
end)

-- 反作弊绕过实现
function enableAntiCheatBypass()
    print("[反作弊绕过] 正在初始化...")
    
    -- 方法1: 修改安全检查
    pcall(function()
        -- 禁用某些安全检查
        local mt = getrawmetatable(game)
        if mt then
            local oldNamecall = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- 拦截可疑的方法调用
                if method == "Kick" or method == "kick" then
                    print("[反作弊绕过] 阻止了踢出尝试")
                    return nil
                end
                
                return oldNamecall(self, unpack(args))
            end)
            
            setreadonly(mt, true)
        end
    end)
    
    -- 方法2: 隐藏脚本执行
    pcall(function()
        -- 清除日志
        for _, connection in pairs(getconnections(game:GetService("LogService").MessageOut)) do
            connection:Disable()
        end
    end)
    
    -- 方法3: 绕过检测
    pcall(function()
        -- 创建假数据来混淆检测
        local fakeData = Instance.new("Folder")
        fakeData.Name = "AntiCheatData"
        
        local fakeStats = Instance.new("IntValue")
        fakeStats.Name = "CheatDetection"
        fakeStats.Value = 0
        fakeStats.Parent = fakeData
        
        fakeData.Parent = workspace
    end)
    
    print("[反作弊绕过] 已启用")
end

function disableAntiCheatBypass()
    print("[反作弊绕过] 正在禁用...")
    
    -- 清理创建的假数据
    pcall(function()
        local fakeData = workspace:FindFirstChild("AntiCheatData")
        if fakeData then
            fakeData:Destroy()
        end
    end)
    
    print("[反作弊绕过] 已禁用")
end

-- 角色重生时重新应用设置
local function onCharacterAdded(character)
    wait(1) -- 等待角色完全加载
    
    -- 重新应用速度hack
    if speedHackEnabled then
        local humanoid = character:WaitForChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 50
        end
    end
    
    -- 重新应用透视
    if killerESPEnabled then
        enableKillerESP()
    end
    
    if survivorESPEnabled then
        enableSurvivorESP()
    end
end

Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- 如果已经有角色，立即应用
if Players.LocalPlayer.Character then
    onCharacterAdded(Players.LocalPlayer.Character)
end

-- 初始化完成
print("==================================")
print("FengYu 增强菜单 v2.0 加载完成!")
print("玩家: " .. Players.LocalPlayer.Name)
print("时间: " .. os.date("%Y-%m-%d %H:%M:%S"))
print("==================================")

-- 创建一个简单的通知
Library:Notification({
    Title = "FengYu",
    Content = "增强菜单已成功加载!",
    Duration = 5
})
