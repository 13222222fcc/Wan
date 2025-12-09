-- VOMO_ ULTIMATE v6.0 - No Loading Screen
-- Advanced Anti-Cheat Bypass System

-- ============================================
-- 核心绕过系统 (无UI版本)
-- ============================================

local VOMO = {
    Version = "6.0",
    
    ESP = {
        Killers = {},
        Survivors = {},
        Colors = {
            Killer = Color3.fromRGB(255, 0, 0),
            Survivor = Color3.fromRGB(0, 255, 0)
        },
        Transparency = 0.6
    },
    
    Speed = {
        Enabled = false,
        Value = 25,
        Original = 16
    },
    
    Fly = {
        Enabled = false,
        Speed = 35,
        Velocity = nil,
        Gyro = nil
    },
    
    Security = {
        AntiKick = true
    }
}

-- ============================================
-- 反作弊绕过系统
-- ============================================

local function ActivateBypass()
    -- 内存挂钩
    if getrawmetatable then
        local mt = getrawmetatable(game)
        if mt then
            local oldIndex = mt.__index
            local oldNewindex = mt.__newindex
            
            setreadonly(mt, false)
            
            mt.__index = newcclosure(function(self, key)
                if tostring(key) == "WalkSpeed" then
                    if VOMO.Speed.Enabled and tostring(self):find("Humanoid") then
                        return VOMO.Speed.Original
                    end
                end
                return oldIndex(self, key)
            end)
            
            mt.__newindex = newcclosure(function(self, key, value)
                if tostring(key) == "WalkSpeed" then
                    if VOMO.Speed.Enabled and tostring(self):find("Humanoid") then
                        VOMO.Speed.Original = value
                    end
                end
                return oldNewindex(self, key, value)
            end)
            
            setreadonly(mt, true)
        end
    end
    
    -- 防踢出
    if hookfunction and VOMO.Security.AntiKick then
        pcall(function()
            local oldKick = game.Players.LocalPlayer.Kick
            hookfunction(oldKick, function() end)
        end)
    end
end

-- 执行绕过
ActivateBypass()

-- ============================================
-- 功能1: 透视系统
-- ============================================

local function CreateESP(player, isKiller)
    if not player or not player.Character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = isKiller and "VOMO_KillerESP" or "VOMO_SurvivorESP"
    highlight.FillColor = isKiller and VOMO.ESP.Colors.Killer or VOMO.ESP.Colors.Survivor
    highlight.OutlineColor = isKiller and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
    highlight.FillTransparency = VOMO.ESP.Transparency
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = player.Character
    
    if syn and syn.protect_gui then
        syn.protect_gui(highlight)
    end
    
    highlight.Parent = game.CoreGui
    
    if isKiller then
        VOMO.ESP.Killers[player] = highlight
    else
        VOMO.ESP.Survivors[player] = highlight
    end
    
    return highlight
end

local function RemoveESP(player, isKiller)
    if isKiller then
        if VOMO.ESP.Killers[player] then
            VOMO.ESP.Killers[player]:Destroy()
            VOMO.ESP.Killers[player] = nil
        end
    else
        if VOMO.ESP.Survivors[player] then
            VOMO.ESP.Survivors[player]:Destroy()
            VOMO.ESP.Survivors[player] = nil
        end
    end
end

-- Killer ESP循环
spawn(function()
    while true do
        wait(0.5)
        
        -- 清理已离开的玩家
        for player, highlight in pairs(VOMO.ESP.Killers) do
            if not player or not player.Parent then
                highlight:Destroy()
                VOMO.ESP.Killers[player] = nil
            end
        end
        
        for player, highlight in pairs(VOMO.ESP.Survivors) do
            if not player or not player.Parent then
                highlight:Destroy()
                VOMO.ESP.Survivors[player] = nil
            end
        end
    end
end)

-- ============================================
-- 功能2: 速度系统
-- ============================================

spawn(function()
    while true do
        wait(0.1)
        
        if VOMO.Speed.Enabled then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                
                -- 方法1: 直接修改
                pcall(function()
                    humanoid.WalkSpeed = VOMO.Speed.Value
                end)
                
                -- 方法2: BodyVelocity (绕过检测)
                if character:FindFirstChild("HumanoidRootPart") then
                    if not character:FindFirstChild("VOMO_SpeedHelper") then
                        local bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.Name = "VOMO_SpeedHelper"
                        bodyVelocity.MaxForce = Vector3.new(10000, 0, 10000)
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        bodyVelocity.P = 1250
                        bodyVelocity.Parent = character.HumanoidRootPart
                        
                        -- 隐藏属性
                        pcall(function()
                            bodyVelocity:SetAttribute("Hidden", true)
                        end)
                    end
                    
                    local moveDirection = humanoid.MoveDirection
                    if moveDirection.Magnitude > 0 then
                        character.VOMO_SpeedHelper.Velocity = moveDirection * VOMO.Speed.Value
                    elseif character:FindFirstChild("VOMO_SpeedHelper") then
                        character.VOMO_SpeedHelper.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end
end)

-- ============================================
-- 功能3: 飞行系统
-- ============================================

spawn(function()
    while true do
        wait()
        
        if VOMO.Fly.Enabled then
            local character = game.Players.LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                if VOMO.Fly.Velocity then VOMO.Fly.Velocity:Destroy() end
                if VOMO.Fly.Gyro then VOMO.Fly.Gyro:Destroy() end
                VOMO.Fly.Velocity = nil
                VOMO.Fly.Gyro = nil
                goto continue
            end
            
            local root = character.HumanoidRootPart
            
            -- 创建飞行组件
            if not VOMO.Fly.Velocity then
                VOMO.Fly.Velocity = Instance.new("BodyVelocity")
                VOMO.Fly.Velocity.Name = "VOMO_FlyVelocity"
                VOMO.Fly.Velocity.MaxForce = Vector3.new(10000, 10000, 10000)
                VOMO.Fly.Velocity.Velocity = Vector3.new(0, 0, 0)
                VOMO.Fly.Velocity.P = 1250
                VOMO.Fly.Velocity.Parent = root
            end
            
            if not VOMO.Fly.Gyro then
                VOMO.Fly.Gyro = Instance.new("BodyGyro")
                VOMO.Fly.Gyro.Name = "VOMO_FlyGyro"
                VOMO.Fly.Gyro.MaxTorque = Vector3.new(10000, 10000, 10000)
                VOMO.Fly.Gyro.P = 1000
                VOMO.Fly.Gyro.D = 50
                VOMO.Fly.Gyro.CFrame = root.CFrame
                VOMO.Fly.Gyro.Parent = root
            end
            
            -- 飞行控制
            local camera = workspace.CurrentCamera
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            local upVector = Vector3.new(0, 1, 0)
            
            local direction = Vector3.new(0, 0, 0)
            
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
            
            if direction.Magnitude > 0 then
                direction = direction.Unit * VOMO.Fly.Speed
            end
            
            VOMO.Fly.Velocity.Velocity = direction
            VOMO.Fly.Gyro.CFrame = camera.CFrame
            
            ::continue::
        else
            -- 清理飞行组件
            if VOMO.Fly.Velocity then
                VOMO.Fly.Velocity:Destroy()
                VOMO.Fly.Velocity = nil
            end
            if VOMO.Fly.Gyro then
                VOMO.Fly.Gyro:Destroy()
                VOMO.Fly.Gyro = nil
            end
        end
    end
end)

-- ============================================
-- 角色重生处理
-- ============================================

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1)
    
    -- 重新应用速度
    if VOMO.Speed.Enabled and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = VOMO.Speed.Value
    end
    
    -- 重新应用飞行
    if VOMO.Fly.Enabled then
        wait(0.5)
        VOMO.Fly.Enabled = false
        wait(0.1)
        VOMO.Fly.Enabled = true
    end
end)

-- ============================================
-- 键盘快捷键系统
-- ============================================

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed then
        -- F1: 开关Killer ESP
        if input.KeyCode == Enum.KeyCode.F1 then
            local isKillerESPActive = next(VOMO.ESP.Killers) ~= nil
            
            if isKillerESPActive then
                -- 关闭所有Killer ESP
                for player, highlight in pairs(VOMO.ESP.Killers) do
                    highlight:Destroy()
                end
                VOMO.ESP.Killers = {}
            else
                -- 开启Killer ESP
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        -- 检测是否为杀手
                        local isKiller = false
                        if player.Team and player.Team.Name:lower():find("killer") then
                            isKiller = true
                        end
                        if player.Character:FindFirstChild("Weapon") then
                            isKiller = true
                        end
                        
                        if isKiller then
                            CreateESP(player, true)
                        end
                    end
                end
            end
        end
        
        -- F2: 开关Survivor ESP
        if input.KeyCode == Enum.KeyCode.F2 then
            local isSurvivorESPActive = next(VOMO.ESP.Survivors) ~= nil
            
            if isSurvivorESPActive then
                -- 关闭所有Survivor ESP
                for player, highlight in pairs(VOMO.ESP.Survivors) do
                    highlight:Destroy()
                end
                VOMO.ESP.Survivors = {}
            else
                -- 开启Survivor ESP
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local isSurvivor = true
                        if player.Team and player.Team.Name:lower():find("killer") then
                            isSurvivor = false
                        end
                        
                        if isSurvivor then
                            CreateESP(player, false)
                        end
                    end
                end
            end
        end
        
        -- F3: 开关速度
        if input.KeyCode == Enum.KeyCode.F3 then
            VOMO.Speed.Enabled = not VOMO.Speed.Enabled
            
            if not VOMO.Speed.Enabled then
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = VOMO.Speed.Original
                end
                if character and character:FindFirstChild("VOMO_SpeedHelper") then
                    character.VOMO_SpeedHelper:Destroy()
                end
            end
        end
        
        -- F4: 开关飞行
        if input.KeyCode == Enum.KeyCode.F4 then
            VOMO.Fly.Enabled = not VOMO.Fly.Enabled
        end
        
        -- F5: 增加速度
        if input.KeyCode == Enum.KeyCode.F5 then
            VOMO.Speed.Value = math.min(VOMO.Speed.Value + 5, 90)
            if VOMO.Speed.Enabled then
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = VOMO.Speed.Value
                end
            end
        end
        
        -- F6: 减少速度
        if input.KeyCode == Enum.KeyCode.F6 then
            VOMO.Speed.Value = math.max(VOMO.Speed.Value - 5, 1)
            if VOMO.Speed.Enabled then
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = VOMO.Speed.Value
                end
            end
        end
        
        -- F7: 增加飞行速度
        if input.KeyCode == Enum.KeyCode.F7 then
            VOMO.Fly.Speed = math.min(VOMO.Fly.Speed + 5, 100)
        end
        
        -- F8: 减少飞行速度
        if input.KeyCode == Enum.KeyCode.F8 then
            VOMO.Fly.Speed = math.max(VOMO.Fly.Speed - 5, 1)
        end
        
        -- F9: 安全清理所有
        if input.KeyCode == Enum.KeyCode.F9 then
            -- 清理ESP
            for player, highlight in pairs(VOMO.ESP.Killers) do
                highlight:Destroy()
            end
            for player, highlight in pairs(VOMO.ESP.Survivors) do
                highlight:Destroy()
            end
            VOMO.ESP.Killers = {}
            VOMO.ESP.Survivors = {}
            
            -- 关闭速度
            VOMO.Speed.Enabled = false
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = 16
            end
            if character and character:FindFirstChild("VOMO_SpeedHelper") then
                character.VOMO_SpeedHelper:Destroy()
            end
            
            -- 关闭飞行
            VOMO.Fly.Enabled = false
            if VOMO.Fly.Velocity then VOMO.Fly.Velocity:Destroy() end
            if VOMO.Fly.Gyro then VOMO.Fly.Gyro:Destroy() end
            VOMO.Fly.Velocity = nil
            VOMO.Fly.Gyro = nil
        end
        
        -- F10: 显示状态
        if input.KeyCode == Enum.KeyCode.F10 then
            print("========= VOMO_ STATUS =========")
            print("Version: " .. VOMO.Version)
            print("Killer ESP: " .. (next(VOMO.ESP.Killers) and "ON" or "OFF"))
            print("Survivor ESP: " .. (next(VOMO.ESP.Survivors) and "ON" or "OFF"))
            print("Speed: " .. (VOMO.Speed.Enabled and "ON (" .. VOMO.Speed.Value .. ")" or "OFF"))
            print("Fly: " .. (VOMO.Fly.Enabled and "ON (" .. VOMO.Fly.Speed .. ")" or "OFF"))
            print("Anti-Kick: " .. (VOMO.Security.AntiKick and "ON" or "OFF"))
            print("================================")
        end
    end
end)

-- ============================================
-- 自动清理系统
-- ============================================

local function Cleanup()
    -- 清理ESP
    for player, highlight in pairs(VOMO.ESP.Killers) do
        highlight:Destroy()
    end
    for player, highlight in pairs(VOMO.ESP.Survivors) do
        highlight:Destroy()
    end
    
    -- 清理速度
    local character = game.Players.LocalPlayer.Character
    if character then
        if character:FindFirstChild("VOMO_SpeedHelper") then
            character.VOMO_SpeedHelper:Destroy()
        end
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
    end
    
    -- 清理飞行
    if VOMO.Fly.Velocity then VOMO.Fly.Velocity:Destroy() end
    if VOMO.Fly.Gyro then VOMO.Fly.Gyro:Destroy() end
end

-- 脚本结束时清理
game:BindToClose(function()
    Cleanup()
end)

-- 玩家离开时清理
game.Players.LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
    if not game.Players.LocalPlayer.Parent then
        Cleanup()
    end
end)

-- ============================================
-- 控制台输出
-- ============================================

print([[
  ╔══════════════════════════════════════════╗
  ║    VOMO_ ULTIMATE v6.0 - NO UI LOADING   ║
  ║    Advanced Anti-Cheat Bypass System     ║
  ╚══════════════════════════════════════════╝
  
  🔧 FEATURES:
  • Killer ESP (红色高亮)
  • Survivor ESP (绿色高亮)
  • Speed Hack (速度修改)
  • Flight System (飞行系统)
  • Anti-Kick Protection (反踢出保护)
  
  🎮 CONTROLS:
  F1 - Toggle Killer ESP
  F2 - Toggle Survivor ESP
  F3 - Toggle Speed Hack
  F4 - Toggle Flight System
  F5 - Increase Speed
  F6 - Decrease Speed
  F7 - Increase Fly Speed
  F8 - Decrease Fly Speed
  F9 - Safe Cleanup (安全清理)
  F10 - Show Status (显示状态)
  
  ⚡ SYSTEM READY
  Anti-Cheat Bypass: ACTIVE
  Memory Hooks: ACTIVE
  Security: PROTECTED
]])

-- 等待游戏加载
repeat wait() until game:IsLoaded()
print("✅ Game loaded successfully!")
