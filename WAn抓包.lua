-- 创建主界面
local MainFrame = Instance.new("ScreenGui")
MainFrame.Name = "MainUI"
MainFrame.Parent = game.Players.LocalPlayer.PlayerGui

-- 创建TabContainer
local TabContainer = Instance.new("TabContainer")
TabContainer.Size = UDim2.new(0, 400, 0, 600)
TabContainer.Position = UDim2.new(0.5, -200, 0.5, -300)
TabContainer.Parent = MainFrame

-- 第1个标签页：玩家信息
local PlayerInfoTab = Instance.new("TabPage")
PlayerInfoTab.Title = "玩家信息"
TabContainer:AddChild(PlayerInfoTab)

local InfoLayout = Instance.new("VerticalLayout")
InfoLayout.Padding = UDim.new(0, 10)
InfoLayout.Parent = PlayerInfoTab

-- 国家标签
local CountryLabel = Instance.new("TextLabel")
CountryLabel.Text = "国家: 中国"
CountryLabel.Size = UDim2.new(1, 0, 0, 20)
CountryLabel.Parent = InfoLayout

-- 玩家注入器标签（示例）
local InjectorLabel = Instance.new("TextLabel")
InjectorLabel.Text = "注入器: ExampleInjector"
InjectorLabel.Size = UDim2.new(1, 0, 0, 20)
InjectorLabel.Parent = InfoLayout

-- 玩家名称标签
local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Text = "玩家名: "..game.Players.LocalPlayer.Name
PlayerNameLabel.Size = UDim2.new(1, 0, 0, 20)
PlayerNameLabel.Parent = InfoLayout

-- 时间标签
local TimeLabel = Instance.new("TextLabel")
TimeLabel.Text = "时间: 12:00"
TimeLabel.Size = UDim2.new(1, 0, 0, 20)
TimeLabel.Parent = InfoLayout

-- 虚拟形象显示（占位）
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Image = "rbxassetid://123456789" -- 替换为实际头像ID
AvatarImage.Size = UDim2.new(0.5, 0, 0.5, 0)
AvatarImage.Position = UDim2.new(0.25, 0, 0.25, 0)
AvatarImage.Parent = PlayerInfoTab

-- 第2个标签页：透视功能
local XRayTab = Instance.new("TabPage")
XRayTab.Title = "透视功能"
TabContainer:AddChild(XRayTab)

local XRayLayout = Instance.new("VerticalLayout")
XRayLayout.Padding = UDim.new(0, 10)
XRayLayout.Parent = XRayTab

-- 透视功能容器
local XRayContainer = Instance.new("Frame")
XRayContainer.Size = UDim2.new(1, 0, 0, 200)
XRayContainer.Position = UDim2.new(0, 0, 0.1, 0)
XRayContainer.BackgroundTransparency = 0.8
XRayContainer.Parent = XRayTab

-- 杀手透视开关
local KillerXRayToggle = Instance.new("ToggleSwitch")
KillerXRayToggle.Text = "杀手透视"
KillerXRayToggle.Size = UDim2.new(0.5, 0, 0, 20)
KillerXRayToggle.Position = UDim2.new(0, 0, 0.1, 0)
KillerXRayToggle.Parent = XRayContainer

-- 幸存者透视开关
local SurvivorXRayToggle = Instance.new("ToggleSwitch")
SurvivorXRayToggle.Text = "幸存者透视"
SurvivorXRayToggle.Size = UDim2.new(0.5, 0, 0, 20)
SurvivorXRayToggle.Position = UDim2.new(0, 0, 0.2, 0)
SurvivorXRayToggle.Parent = XRayContainer

-- 发电机透视开关
local GeneratorXRayToggle = Instance.new("ToggleSwitch")
GeneratorXRayToggle.Text = "发电机透视"
GeneratorXRayToggle.Size = UDim2.new(0.5, 0, 0, 20)
GeneratorXRayToggle.Position = UDim2.new(0, 0, 0.3, 0)
GeneratorXRayToggle.Parent = XRayContainer

-- 透视目标列表
local TargetsList = Instance.new("ScrollingFrame")
TargetsList.Size = UDim2.new(1, 0, 0.8, 0)
TargetsList.Position = UDim2.new(0, 0, 0.2, 0)
TargetsList.CanvasSize = UDim2.new(0, 0, 0, 0)
TargetsList.Parent = XRayContainer

-- 透视功能实现
local function ToggleXRay(targetType)
    if targetType == "killer" then
        -- 隐藏所有玩家（示例）
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                player.Character.HumanoidRootPart.Transparency = 1
            end
        end
    elseif targetType == "survivor" then
        -- 显示特定NPC（示例）
        local survivors = {"谢德莱次基", "访客1337", "维罗妮卡"}
        for _, name in ipairs(survivors) do
            local character = game.Workspace:FindFirstChild(name)
            if character then
                character.HumanoidRootPart.Transparency = 0
            end
        end
    elseif targetType == "generator" then
        -- 高亮发电机（示例）
        local generators = game.Workspace:GetChildren()
        for _, obj in ipairs(generators) do
            if obj.Name:find("Generator") then
                obj.BrickColor = BrickColor.new("Bright red")
            end
        end
    end
end

KillerXRayToggle.Changed:Connect(function(state)
    if state then ToggleXRay("killer") end
end)

SurvivorXRayToggle.Changed:Connect(function(state)
    if state then ToggleXRay("survivor") end
end)

GeneratorXRayToggle.Changed:Connect(function(state)
    if state then ToggleXRay("generator") end
end)

-- 第3个标签页：基础设置
local BaseSettingsTab = Instance.new("TabPage")
BaseSettingsTab.Title = "基础设置"
TabContainer:AddChild(BaseSettingsTab)

local BaseLayout = Instance.new("VerticalLayout")
BaseLayout.Padding = UDim.new(0, 10)
BaseLayout.Parent = BaseSettingsTab

-- 无限体力开关
local StaminaToggle = Instance.new("ToggleSwitch")
StaminaToggle.Text = "无限体力"
StaminaToggle.Size = UDim2.new(0.5, 0, 0, 20)
StaminaToggle.Position = UDim2.new(0, 0, 0.1, 0)
StaminaToggle.Parent = BaseLayout

-- 自动修复发电机开关
local AutoRepairToggle = Instance.new("ToggleSwitch")
AutoRepairToggle.Text = "自动修复发电机"
AutoRepairToggle.Size = UDim2.new(0.5, 0, 0, 20)
AutoRepairToggle.Position = UDim2.new(0, 0, 0.2, 0)
AutoRepairToggle.Parent = BaseLayout

-- 速度提升开关
local SpeedToggle = Instance.new("ToggleSwitch")
SpeedToggle.Text = "速度提升"
SpeedToggle.Size = UDim2.new(0.5, 0, 0, 20)
SpeedToggle.Position = UDim2.new(0, 0, 0.3, 0)
SpeedToggle.Parent = BaseLayout

-- 绕过反作弊系统（警告！）
local AntiCheatBypassToggle = Instance.new("ToggleSwitch")
AntiCheatBypassToggle.Text = "绕过反作弊"
AntiCheatBypassToggle.Size = UDim2.new(0.5, 0, 0, 20)
AntiCheatBypassToggle.Position = UDim2.new(0, 0, 0.4, 0)
AntiCheatBypassToggle.Parent = BaseLayout

-- 功能实现部分
local function UpdateStamina()
    if StaminaToggle.Value then
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
    else
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100
    end
end

StaminaToggle.Changed:Connect(UpdateStamina)

local function AutoRepairGenerators()
    if AutoRepairToggle.Value then
        coroutine.wrap(function()
            while wait(2.5) do
                local generators = game.Workspace:GetChildren()
                for _, gen in ipairs(generators) do
                    if gen.Name:find("Generator") and gen.Health < 100 then
                        gen.Health = gen.Health + 1
                    end
                end
            end
        end)()
    end
end

AutoRepairToggle.Changed:Connect(AutoRepairGenerators)

local function SpeedBoost()
    if SpeedToggle.Value then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end

SpeedToggle.Changed:Connect(SpeedBoost)

-- 安全警告
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Text = "警告：绕过反作弊可能导致封号！"
WarningLabel.TextColor3 = Color3.new(1, 0, 0)
WarningLabel.Size = UDim2.new(1, 0, 0, 30)
WarningLabel.Parent = BaseSettingsTab

-- 最终优化
for _, child in ipairs(MainFrame:GetChildren()) do
    if child:IsA("TextLabel") then
        child.Font = Enum.Font.SourceSansBold
        child.TextColor3 = Color3.new(1, 1, 1)
        child.BackgroundColor3 = Color3.new(0, 0, 0)
    end
end

-- 注意事项：
-- 1. 实际透视功能需要更复杂的实现（材质修改/碰撞检测等）
-- 2. 绕过反作弊功能在正规游戏中禁止使用
-- 3. 需要根据实际游戏结构调整对象引用
-- 4. 建议添加错误处理和性能优化
