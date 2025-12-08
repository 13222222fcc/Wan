local library = loadstring(game:HttpGet("https://github.com/Yomkav2/Sugar-UI"))();

local LBLG = Instance.new("ScreenGui")
local LBL = Instance.new("TextLabel")
local PlayerLabel = Instance.new("TextLabel")
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true

LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0, 5, 0, 10)
LBL.Size = UDim2.new(0, 250, 0, 35)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "时间:加载中..."
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = false
LBL.TextSize = 22
LBL.TextWrapped = false
LBL.Visible = true
LBL.TextXAlignment = Enum.TextXAlignment.Left
LBL.TextYAlignment = Enum.TextYAlignment.Top
LBL.ZIndex = 10

LBL.TextSize = 18
LBL.Size = UDim2.new(0, 250, 0, 30)
LBL.Position = UDim2.new(1, -255, 0, 10)
LBL.TextXAlignment = Enum.TextXAlignment.Right

local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
    LastIteration = tick()
    for Index = #FrameUpdateTable, 1, -1 do
        FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
    end
    FrameUpdateTable[1] = LastIteration
    local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
    CurrentFPS = CurrentFPS - CurrentFPS % 1
    
    local hue = tick() % 5 / 5
    local r = math.sin(hue * 6.28 + 0) * 127 + 128
    local g = math.sin(hue * 6.28 + 2) * 127 + 128
    local b = math.sin(hue * 6.28 + 4) * 127 + 128
    local color = Color3.fromRGB(r, g, b)
    
    LBL.Text = ("北京时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
    LBL.TextColor3 = color
    PlayerLabel.TextColor3 = color
end
 
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
 
game:GetService("StarterGui"):SetCore("SendNotification",{Title="提示";Text="挽脚本通用源码ovo\n请等待1-12秒喵";Icon="rbxassetid://114514";Duration=3;})
 
 -- 这是我的公开UI库
local success, ui = pcall(function()
return loadstring(game:HttpGet("https://raw.githubusercontent.com/3345179204-sudo/-/refs/heads/main/UI%E5%BA%93", true))()
end)
if not success then
game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Text="UI库加载失败";Icon="rbxassetid://114514";Duration=5;})
return
end
local win = ui:new("挽脚本通用源码脚本")
local function RainbowColor()
local hue=0
while true do
hue=(hue+1)%360
wait(0.05)
local color=Color3.fromHSV(hue/360,0.8,0.9)
coroutine.wrap(function()
for _,tab in pairs({UITab1,UITab2,UITab3,UITab4,UITab5,UITab6,UITab7,UITab8,UITab9,UITab10,UITab11})do
pcall(function()
tab.TabButton.BackgroundColor3=color
tab.TabButton.TextColor3=Color3.new(1,1,1)
end)
end
end)()
end
end
coroutine.wrap(RainbowColor)()
 
local UITab1 = win:Tab("『公告』",'114514')
local UITab2 = win:Tab("『通用』",'114514')
local UITab3 = win:Tab("『范围+自瞄』",'114514')
local UITab4 = win:Tab("『传送+甩飞』",'114514')
local UITab5 = win:Tab("『FE』",'114514')
local UITab6 = win:Tab("『ESP』",'114514')
local UITab7 = win:Tab("『旋转』",'114514')
local UITab8 = win:Tab("『自然灾害』",'114514')
local UITab9 = win:Tab("『力量传奇』",'114514')
local UITab10 = win:Tab("『极速传奇』",'114514')
local UITab11 = win:Tab("『忍者传奇』",'114514')
local UITab12 = win:Tab("『战争大亨』",'114514')
local UITab13 = win:Tab("『刀球刃』",'114514')
 
local about = UITab1:section("『公告』",true)
local function RainbowFont(label)
local hue = 0
spawn(function()
while true do
hue = (hue + 1) % 360
wait(0.1)
pcall(function()
label.TextColor3 = Color3.fromHSV(hue/360, 0.8, 0.9)
end)
end
end)
end
local versionLabel = about:Label("挽脚本通用源码v1.0.2")
RainbowFont(versionLabel)
local lbl1 = about:Label("一个刚学三年lua的女孩子")
RainbowFont(lbl1)
local lbl2 = about:Label("作者qq:3345179204")
RainbowFont(lbl2)
local lbl3 = about:Label("感谢支持挽脚本通用源码脚本")
RainbowFont(lbl3)
local lbl4 = about:Label("就随便做的")
RainbowFont(lbl4)
local lbl5 = about:Label("请勿拿别的缝合来对比")
RainbowFont(lbl5)
local lbl6 = about:Label("请勿拿别的缝合来对比")
RainbowFont(lbl6)
 
local about = UITab1:section("『关于』",true)
local function safeIdentify()
local success, res = pcall(identifyexecutor)
return success and res or "未知"
end
about:Label("你的注入器:"..safeIdentify())
about:Label("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
about:Label("当前服务器ID:" .. game.GameId)
about:Label("你的用户名:" .. game.Players.LocalPlayer.DisplayName)
about:Label("你的账号年龄:"..game.Players.LocalPlayer.AccountAge.."天")
local player = game.Players.LocalPlayer
if player.MembershipType == Enum.MembershipType.Premium then
about:Label("会员状态： 有会员")
else
about:Label("会员状态： 没有会员")
end
about:Label("语言： "..game.Players.LocalPlayer.LocaleId)
 
local UserInputService = game:GetService("UserInputService")
local deviceType = "未知设备"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
deviceType = "移动设备"
elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
deviceType = "电脑"
elseif UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
deviceType = "带触摸屏的电脑"
end
about:Label("设备类型："..deviceType)
 
about:Label("客户端ID:"..game:GetService("RbxAnalyticsService"):GetClientId())
 
local player = game.Players.LocalPlayer
if player.MembershipType == Enum.MembershipType.Premium then
print("会员状态： 是")
else
print("会员状态： 否")
end

local about = UITab1:section("『其他』", true)

about:Toggle("缩小UI", "UIScale", false, function(state)
    local scale = state and 0.965 or 1
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if not targetGui then return end
    local mainWindow = targetGui:FindFirstChild("Main")
    if not mainWindow then return end
    if not mainWindow:FindFirstChild("OriginalSize") then
        local originalSize = Instance.new("Vector3Value")
        originalSize.Name = "OriginalSize"
        originalSize.Value = Vector3.new(mainWindow.Size.X.Offset, mainWindow.Size.Y.Offset, 0)
        originalSize.Parent = mainWindow
    end
    mainWindow.Size = UDim2.new(0, mainWindow.OriginalSize.Value.X * scale, 0, mainWindow.OriginalSize.Value.Y * scale)
end)

local function adaptVisualStyle()
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if not targetGui then return end
    local otherSection = targetGui:FindFirstChild("『其他』")
    if otherSection then
        local buttons = otherSection:GetDescendants()
        for _, btn in ipairs(buttons) do
            if btn:IsA("TextButton") then
                if btn.Name == "关闭UI" or (btn.Parent and btn.Parent.Name == "ToggleModule" and btn.Parent.Parent == otherSection) then
                    btn.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.CornerRadius = UDim.new(0, 6)
                    btn.BackgroundTransparency = 0.75
                end
            end
        end
    end
end
adaptVisualStyle()

about:Button("重新加入服务器", function()
    local TeleportService = game:GetService("TeleportService")
    local success, err = pcall(function()
        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "重进失败喵"; Icon = "rbxassetid://114514"; Text ="null："..err; Duration = 4; })
    end
end)

about:Button("关闭UI", function()
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if targetGui then
        targetGui:Destroy()
    end
end)

local about = UITab1:section("『复制』",true)
about:Button("复制服务器名称", function()
    local serverName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    setclipboard(serverName)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Icon="rbxassetid://114514";Text="服务器名称已复制喵";Duration=3;})
end)

about:Button("复制脚本学习+制作交流群", function()
    setclipboard("574149379")
    game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "挽脚本通用源码"; Icon = "rbxassetid://114514"; Text ="群号已复制喵"; Duration = 3; })
end)

local about = UITab2:section("『玩家属性』",true)

about:Slider("视野", "FieldOfView", Workspace.CurrentCamera.FieldOfView, 10, 180, false, function(FOV)
    spawn(function() 
        while task.wait() do 
            Workspace.CurrentCamera.FieldOfView = FOV
        end 
    end)
end)

about:Slider("视角缩放距离", "CameraZoom", 100, 0.5, 1000000, false, function(Distance)
    local player = game.Players.LocalPlayer
    if player then
        player.CameraMaxZoomDistance = Distance
        player.CameraMinZoomDistance = 0.5
    end
end)

about:Slider("步行速度", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 1, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

about:Slider("跳跃高度", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 0, 2000, false, function(Jump)
    local plr = game.Players.LocalPlayer
    local originalJump = 50
    
    local function updateJump()
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = Jump
            humanoid.JumpHeight = Jump / 7  
        end
    end
    
    local function resetJump()
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = originalJump
            humanoid.JumpHeight = originalJump / 7
        end
    end
    
    updateJump()
    
    if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed then
                wait(0.1)
                updateJump()
            end
        end)
    end
    
    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        updateJump()
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed then
                wait(0.1)
                updateJump()
            end
        end)
    end)
end)

about:Slider("重力设置（默认196.2 高起不了身）", "Gravity", game.Workspace.Gravity, 1, 2000, false, function(GravityValue)
    game.Workspace.Gravity = GravityValue
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    if _G.MaxHealthValue then
        char:WaitForChild("Humanoid").MaxHealth = _G.MaxHealthValue
    end
    if _G.HealthValue then
        char:WaitForChild("Humanoid").Health = _G.HealthValue
    end
end)

about:Button("重置重力",function()
local p=game.Players.LocalPlayer
local h=p.Character and p.Character:FindFirstChild("Humanoid")
if h then game:GetService("Workspace").Gravity=196.2 end
end)

local about = UITab2:section("『功能』",true)

about:Button("飞行v3",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/XxwanhexxX/321/refs/heads/main/fly'))()
end)

about:Button("FPS显示",function()
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FPSDisplay"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "FPS: 0"
    textLabel.TextSize = 22
    textLabel.Font = Enum.Font.GothamBold
    textLabel.BackgroundTransparency = 1
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Size = UDim2.new(0, 200, 0, 35)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.AnchorPoint = Vector2.new(0, 0)
    textLabel.ZIndex = 10
    textLabel.Parent = screenGui

    local frameCount = 0
    local lastUpdate = tick()

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        
        local currentTime = tick()
        if currentTime - lastUpdate >= 0.15 then
            local fps = math.floor(frameCount / (currentTime - lastUpdate))
            local color = Color3.new(1, 1, 1)
            
            textLabel.Text = "FPS: " .. fps
            textLabel.TextColor3 = color
            
            frameCount = 0
            lastUpdate = currentTime
        end
    end)
end)

about:Button("动态模糊", function()
    local Lighting = game:GetService("Lighting")
    
    local motionBlur = Instance.new("BlurEffect")
    motionBlur.Name = "DynamicMotionBlur"
    motionBlur.Size = 10
    motionBlur.Parent = Lighting
    
    game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
        local player = game:GetService("Players").LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local velocity = player.Character.HumanoidRootPart.Velocity.Magnitude
            motionBlur.Size = math.clamp(velocity / 20, 0, 15)
        end
    end)
end)

about:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua'))()
end)

about:Button("反挂机",function()
loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)

about:Toggle("通用防摔伤", "Toggle", false, function(Value)
end)

about:Toggle("悬空锁高度", "Toggle", false, function(Value)
end)

local godModeEnabled = false
local connection

about:Toggle("无敌", "Toggle", false, function(Value)
end)

about:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

about:Toggle("自动互动", "Auto Interact", false, function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25)
            end
        else
            autoInteract = false
        end
    end)

about:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)
    
    about:Toggle("循环恢复血量","Toggle",false,function(Value)
    AutoHeal = Value
    while AutoHeal do
        wait(0.01) 
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

about:Button("汉化穿墙",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/OtherScript/main/Noclip"))()
end)

about:Button("踏空ui", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float', true))()
end)

about:Button("强制杀死玩家", function()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:BreakJoints()
    end
end)

about:Button("飞车", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vb/main/%E9%A3%9E%E8%BD%A6.lua", true))()
end)

about:Button("旋转", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua", true))()
end)

about:Label("境头")

about:Button("第一人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    
    local function setFirstPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    end
    
    setFirstPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setFirstPerson()
    end)
end)

about:Button("第三人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 50
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    
    local function setThirdPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 50
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    end
    
    setThirdPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setThirdPerson()
    end)
end)

local about = UITab2:section("『工具』",true)

about:Button("点击传送", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "挽脚本通用源码点击传送"
    tool.Activated:Connect(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
        end
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

about:Button("控制台",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/3345179204-sudo/-/refs/heads/main/%E6%8E%A7%E5%88%B6tai"))()
end)

about:Button("汉化dex",function()
loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)

about:Button("工具挂", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua", true))()
end)

about:Button("iw指令", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source', true))()
end)

about:Button("电脑键盘", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

local about = UITab2:section("『光影』",true)

about:Button("普通光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

about:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

about:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local about = UITab3:section("『范围』",true)

about:Textbox("自定义范围", "HitBox", "输入", function(Value)
    _G.HeadSize = tonumber(Value)
    _G.Disabled = true 
    if _G.HeadSize then
        for i,v in next, game:GetService('Players'):GetPlayers() do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
                    v.Character.HumanoidRootPart.Transparency = 0.7 
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end 
        end
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Icon="rbxassetid://114514";Text="范围已设置喵";Duration=3;})
    else
        game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Icon="rbxassetid://114514";Text="请输入数字喵";Duration=3;})
    end
end)

about:Button("关闭范围", function()
    _G.Disabled = false
    for i,v in next, game:GetService('Players'):GetPlayers() do
        if v.Name ~= game:GetService('Players').LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                v.Character.HumanoidRootPart.Transparency = 1
                v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Medium stone grey")
                v.Character.HumanoidRootPart.Material = "Plastic"
                v.Character.HumanoidRootPart.CanCollide = true
            end)
        end
    end
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Icon="rbxassetid://114514";Text="范围关闭了喵";Duration=3;})
end)

about:Button("彩虹", function()
    _G.HeadSize = 20 
    _G.Disabled = true 
    
    game:GetService('RunService').RenderStepped:connect(function() 
        if _G.Disabled then
            local hue = tick() % 5 / 5
            local r = math.sin(hue * 6.28 + 0) * 127 + 128
            local g = math.sin(hue * 6.28 + 2) * 127 + 128
            local b = math.sin(hue * 6.28 + 4) * 127 + 128
            
            for i,v in next, game:GetService('Players'):GetPlayers() do 
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
                    pcall(function() 
                        v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
                        v.Character.HumanoidRootPart.Transparency = 0.7 
                        v.Character.HumanoidRootPart.Color = Color3.fromRGB(r, g, b)
                        v.Character.HumanoidRootPart.Material = "Neon"
                        v.Character.HumanoidRootPart.CanCollide = false
                    end) 
                end 
            end 
        end
    end)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="挽脚本通用源码";Icon="rbxassetid://114514";Text="彩虹已启用喵";Duration=3;})
end)

local about = UITab3:section("『快速调』",true)

about:Button("普通范围",function()_G.HeadSize=15 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("中等范围",function()_G.HeadSize=50 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("超大范围",function()_G.HeadSize=100 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("终极范围",function()_G.HeadSize=200 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("全图范围",function()_G.HeadSize=400 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)

local about = UITab3:section("『自定义』",true)

about:Button("范围15",function()_G.HeadSize=15 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围50",function()_G.HeadSize=50 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围100",function()_G.HeadSize=100 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围150",function()_G.HeadSize=150 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围200",function()_G.HeadSize=200 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围250",function()_G.HeadSize=250 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围300",function()_G.HeadSize=300 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围400",function()_G.HeadSize=400 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)
about:Button("范围500",function()_G.HeadSize=500 _G.Disabled=true if _G.Disabled then for i,v in next,game:GetService('Players'):GetPlayers()do if v.Name~=game:GetService('Players').LocalPlayer.Name then pcall(function()v.Character.HumanoidRootPart.Size=Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)v.Character.HumanoidRootPart.Transparency=0.7 v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really blue")v.Character.HumanoidRootPart.Material="Neon"v.Character.HumanoidRootPart.CanCollide=false end)end end end end)

local about = UITab3:section("『自瞄』",true)

local currentAimbotConnection = nil
local currentFOVring = nil
local currentInputConnection = nil
local rainbowHue = 0

local function cleanupCurrentAimbot()
    if currentAimbotConnection then
        currentAimbotConnection:Disconnect()
        currentAimbotConnection = nil
    end
    
    if currentFOVring then
        currentFOVring:Remove()
        currentFOVring = nil
    end
    
    if currentInputConnection then
        currentInputConnection:Disconnect()
        currentInputConnection = nil
    end
end

about:Button("关闭自瞄",function()
    cleanupCurrentAimbot()
    print("自瞄已关闭")
end)

local function createAimbot(fov)
    cleanupCurrentAimbot()
    
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local Cam = game.Workspace.CurrentCamera
    
    currentFOVring = Drawing.new("Circle")
    currentFOVring.Visible = true
    currentFOVring.Thickness = 1
    currentFOVring.NumSides = 64
    currentFOVring.Filled = false
    currentFOVring.Radius = fov
    currentFOVring.Position = Cam.ViewportSize / 2
    
    local function updateDrawings()
        local camViewportSize = Cam.ViewportSize
        currentFOVring.Position = camViewportSize / 2
        
        rainbowHue = (rainbowHue + 0.02) % 1
        local color = Color3.fromHSV(rainbowHue, 1, 1)
        currentFOVring.Color = color
    end
    
    local function onKeyDown(input)
        if input.KeyCode == Enum.KeyCode.Delete then
            cleanupCurrentAimbot()
        end
    end
    
    currentInputConnection = UserInputService.InputBegan:Connect(onKeyDown)
    
    local function lookAt(target)
        local lookVector = (target - Cam.CFrame.Position).unit
        local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
        Cam.CFrame = newCFrame
    end
    
    local function getClosestPlayerInFOV(trg_part)
        local nearest = nil
        local last = math.huge
        local playerMousePos = Cam.ViewportSize / 2
    
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local part = player.Character and player.Character:FindFirstChild(trg_part)
                if part then
                    local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                    local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude
    
                    if distance < last and isVisible and distance < fov then
                        last = distance
                        nearest = player
                    end
                end
            end
        end
    
        return nearest
    end
    
    currentAimbotConnection = RunService.RenderStepped:Connect(function()
        updateDrawings()
        local closest = getClosestPlayerInFOV("Head")
        if closest and closest.Character and closest.Character:FindFirstChild("Head") then
            lookAt(closest.Character.Head.Position)
        end
    end)
end

about:Button("自瞄10",function()
    createAimbot(15)
end)

about:Button("自瞄30",function()
    createAimbot(30)
end)

about:Button("自瞄50",function()
    createAimbot(50)
end)

about:Button("自瞄100",function()
    createAimbot(100)
end)

about:Button("自瞄200",function()
    createAimbot(200)
end)

about:Button("自瞄300",function()
    createAimbot(300)
end)

about:Button("自瞄400",function()
    createAimbot(400)
end)

about:Button("自瞄全屏",function()
    createAimbot(1600)
end)

getgenv().LockTPEnabled = false
getgenv().LoopTPEnabled = false
getgenv().LoopFrontTPEnabled = false
getgenv().LoopHeadHeightEnabled = false
getgenv().LoopHeadTPEnabled = false
getgenv().LoopBackTPEnabled = false
getgenv().LoopThrowEnabled = false
getgenv().FrontDistance = 5
getgenv().BackDistance = 5

local RunService = game:GetService("RunService")

local about = UITab4:section("『玩家选择』", true)
local selectedPlayer = nil
local playerList = {}
local playerDropdown

local function refreshPlayers()
    table.clear(playerList)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    if playerDropdown then
        playerDropdown:Destroy()
    end
    playerDropdown = about:Dropdown("选择玩家的名称", "Dropdown", playerList, function(selected)
        selectedPlayer = game.Players:FindFirstChild(selected)
    end)
end

refreshPlayers()

about:Button("刷新列表", function()
    local newPlayerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(newPlayerList, player.Name)
        end
    end
    
    playerDropdown:SetOptions(newPlayerList)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "挽脚本通用源码",
        Text = "列表刷新成功喵",
        Icon = "rbxassetid://114514",
        Duration = 3
    })
end)

about:Button("查看玩家", function()
    if selectedPlayer then
        game.Workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.Humanoid
    end
end)

about:Button("停止查看", function()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        game.Workspace.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
    end
end)

local about = UITab4:section("『传送功能』",true)

about:Button("传递到玩家旁边", function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = selectedPlayer.Character.HumanoidRootPart.Position
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(3, 0, 3))
    end
end)

about:Toggle("锁定传送", "LockTP", false, function(state)
    getgenv().LockTPEnabled = state
    local connection
    if state and selectedPlayer then
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LockTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            local targetPos = selectedPlayer.Character.HumanoidRootPart.Position
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(3, 0, 3))
            end
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)

about:Button("把玩家传送过来", function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = game.Players.LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local myPos = myChar.HumanoidRootPart.Position
            selectedPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(3, 0, 3))
        end
    end
end)

about:Toggle("循环把玩家传送过来", "LoopTP", false, function(state)
    getgenv().LoopTPEnabled = state
    local connection
    if state and selectedPlayer then
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LoopTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            local myChar = game.Players.LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local myPos = myChar.HumanoidRootPart.Position
                selectedPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(3, 0, 3))
            end
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)

local about = UITab4:section("『吸人+甩飞』",true)

about:Toggle("吸附所有人", "AttractAll", false, function(state)
end)

about:Label("甩飞")

about:Button("甩飞一次选中的人", function()
    local Player = game:GetService("Players").LocalPlayer
    local TargetPlayer = selectedPlayer
    if not TargetPlayer or TargetPlayer == Player then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "挽脚本通用源码", Text = "无玩家可甩飞", Duration = 2, Icon = "rbxassetid://114514"})
        return
    end

    local Message = function(_Title, _Text, Time)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time, Icon = "rbxassetid://114514"})
    end

    local pid = game.PlaceId
    if pid == 189707 then
        local rs = game:GetService("RunService")
        local hb = rs.Heartbeat
        local rsd = rs.RenderStepped
        local lp = game.Players.LocalPlayer
        local z = Vector3.zero
        local function f(c)
            local r = c:WaitForChild("HumanoidRootPart")
            if r then
                local con
                con = hb:Connect(function()
                    if not r.Parent then
                        con:Disconnect()
                    end
                    local v = r.AssemblyLinearVelocity
                    r.AssemblyLinearVelocity = z
                    rsd:Wait()
                    r.AssemblyLinearVelocity = v
                end)
            end
        end
        f(lp.Character)
        lp.CharacterAdded:Connect(f)
    end

    local SkidFling = function(Target)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = Target.Character
        local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart
        local THead = TCharacter and TCharacter:FindFirstChild("Head")
        local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
        local Handle = Accessory and Accessory:FindFirstChild("Handle")

        if not (Character and Humanoid and RootPart and TCharacter and THumanoid) then
            return Message("挽脚本通用源码", "玩家已趋势", 2)
        end
        if THumanoid.Sit then return Message("挽脚本通用源码", "目标处于坐姿", 2) end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then return Message("挽脚本通用源码", "玩家已趋势", 2) end

        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        else
            workspace.CurrentCamera.CameraSubject = THumanoid
        end

        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= Target.Character or Target.Parent ~= game:GetService("Players") or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            SFBasePart((TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 and THead or TRootPart)
        elseif TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        else
            return Message("挽脚本通用源码", "玩家已趋势", 2)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        getgenv().FPDH = getgenv().FPDH or workspace.FallenPartsDestroyHeight

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
        Message("挽脚本通用源码", "已甩飞选中玩家", 2)
    end

    if TargetPlayer.UserId ~= 1414978355 then
        SkidFling(TargetPlayer)
    else
        Message("挽脚本通用源码", "该玩家存在甩飞名单", 2)
    end
end)

getgenv().LoopFlingEnabled = false

about:Toggle("锁定甩飞选中的人", "LoopFling", false, function(state)
getgenv().LoopFlingEnabled = state
local isRunning = false
 
local function performFling()
if not getgenv().LoopFlingEnabled or not selectedPlayer or selectedPlayer == game.Players.LocalPlayer or isRunning then
return
end
 
isRunning = true
local Player = game.Players.LocalPlayer
local Target = selectedPlayer
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
local RootPart = Humanoid and Humanoid.RootPart
local TCharacter = Target.Character
local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
local TRootPart = THumanoid and THumanoid.RootPart
local THead = TCharacter and TCharacter:FindFirstChild("Head")
local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
local Handle = Accessory and Accessory:FindFirstChild("Handle")
 
if not (Character and Humanoid and RootPart and TCharacter and THumanoid) then
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "挽脚本通用源码", Text = "无玩家可甩飞", Duration = 2, Icon = "rbxassetid://114514"})
isRunning = false
return
end
if THumanoid.Sit then
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "挽脚本通用源码", Text = "目标处于坐姿", Duration = 2, Icon = "rbxassetid://114514"})
isRunning = false
return
end
if not TCharacter:FindFirstChildWhichIsA("BasePart") then
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "挽脚本通用源码", Text = "玩家已趋势", Duration = 2, Icon = "rbxassetid://114514"})
isRunning = false
return
end
 
if THead then
workspace.CurrentCamera.CameraSubject = THead
elseif Handle then
workspace.CurrentCamera.CameraSubject = Handle
else
workspace.CurrentCamera.CameraSubject = THumanoid
end
 
if RootPart.Velocity.Magnitude < 50 then
getgenv().OldPos = RootPart.CFrame
end
 
local FPos = function(BasePart, Pos, Ang)
RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
end
 
local SFBasePart = function(BasePart)
local TimeToWait = 2
local Time = tick()
local Angle = 0
repeat
if RootPart and THumanoid then
if BasePart.Velocity.Magnitude < 50 then
Angle = Angle + 100
FPos(BasePart, CFrame.new(0, 1.2, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
task.wait()
else
FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
task.wait()
 
FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
task.wait()
FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
task.wait()
end
else
break
end
until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= Target.Character or Target.Parent ~= game:GetService("Players") or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
end
 
workspace.FallenPartsDestroyHeight = 0/0
local BV = Instance.new("BodyVelocity")
BV.Name = "EpixVel"
BV.Parent = RootPart
BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
 
if TRootPart and THead then
SFBasePart((TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 and THead or TRootPart)
elseif TRootPart then
SFBasePart(TRootPart)
elseif THead then
SFBasePart(THead)
elseif Handle then
SFBasePart(Handle)
end
 
BV:Destroy()
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
workspace.CurrentCamera.CameraSubject = Humanoid
getgenv().FPDH = getgenv().FPDH or workspace.FallenPartsDestroyHeight
 
repeat
RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
Humanoid:ChangeState("GettingUp")
table.foreach(Character:GetChildren(), function(_, x)
if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
end)
task.wait()
until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
workspace.FallenPartsDestroyHeight = getgenv().FPDH
 
isRunning = false
task.wait(0.01)
if getgenv().LoopFlingEnabled then
performFling()
end
end
 
if state and selectedPlayer then
performFling()
end
end)

about:Button("甩飞所有人", function()
    local Targets = {"All"}
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local AllBool = false
    local GetPlayer = function(Name)
        Name = Name:lower()
        if Name == "all" or Name == "others" then
            AllBool = true
            return
        elseif Name == "random" then
            local GetPlayers = Players:GetPlayers()
            if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
            return GetPlayers[math.random(#GetPlayers)]
        elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
            for _,x in next, Players:GetPlayers() do
                if x ~= Player then
                    if x.Name:lower():match("^"..Name) then
                        return x;
                    elseif x.DisplayName:lower():match("^"..Name) then
                        return x;
                    end
                end
            end
        else
            return
        end
    end
    local Message = function(_Title, _Text, Time)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time, Icon = "rbxassetid://114514"})
    end
    local SkidFling = function(TargetPlayer)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = TargetPlayer.Character
        local THumanoid
        local TRootPart
        local THead
        local Accessory
        local Handle
        if TCharacter:FindFirstChildOfClass("Humanoid") then
            THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        end
        if THumanoid and THumanoid.RootPart then
            TRootPart = THumanoid.RootPart
        end
        if TCharacter:FindFirstChild("Head") then
            THead = TCharacter.Head
        end
        if TCharacter:FindFirstChildOfClass("Accessory") then
            Accessory = TCharacter:FindFirstChildOfClass("Accessory")
        end
        if Accessoy and Accessory:FindFirstChild("Handle") then
            Handle = Accessory.Handle
        end
        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
            end
            if THumanoid and THumanoid.Sit and not AllBool then
                return Message("错误提示", "目标处于坐姿", 2)
            end
            if THead then
                workspace.CurrentCamera.CameraSubject = THead
            elseif not THead and Handle then
                workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then
                workspace.CurrentCamera.CameraSubject = THumanoid
            end
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                return
            end
            
            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
            
            local SFBasePart = function(BasePart)
                local TimeToWait = 2
                local Time = tick()
                local Angle = 0
                repeat
                    if RootPart and THumanoid then
                        if BasePart.Velocity.Magnitude < 50 then
                            Angle = Angle + 100
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
            end
            
            workspace.FallenPartsDestroyHeight = 0/0
            
            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            if TRootPart and THead then
                if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                    SFBasePart(THead)
                else
                    SFBasePart(TRootPart)
                end
            elseif TRootPart and not THead then
                SFBasePart(TRootPart)
            elseif not TRootPart and THead then
                SFBasePart(THead)
            elseif not TRootPart and not THead and Accessory and Handle then
                SFBasePart(Handle)
            else
                return Message("null", "玩家已趋势", 2)
            end
            
            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid
            
            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                table.foreach(Character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        else
            return Message("挽脚本通用源码", "随机错误", 2)
        end
    end
    local hasPlayers = false
    for _,x in next, Players:GetPlayers() do
        if x ~= Player then
            hasPlayers = true
            break
        end
    end
    if not hasPlayers then
        return Message("挽脚本通用源码", "无玩家可以甩飞", 2)
    end
    if not Welcome then Message("挽脚本通用源码", "甩飞增强版", 2) end
    getgenv().Welcome = true
    if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
    if AllBool then
        for _,x in next, Players:GetPlayers() do
            SkidFling(x)
        end
    end
    for _,x in next, Targets do
        if GetPlayer(x) and GetPlayer(x) ~= Player then
            if GetPlayer(x).UserId ~= 1414978355 then
                local TPlayer = GetPlayer(x)
                if TPlayer then
                    SkidFling(TPlayer)
                end
            else
                Message("挽脚本通用源码", "该玩家已经存在甩飞名单", 2)
            end
        elseif not GetPlayer(x) and not AllBool then
            Message("挽脚本通用源码", "玩家掉线", 2)
        end
    end
end)

local about = UITab4:section("『传送玩家前后方』",true)

about:Slider("传送前方的距离", "FrontDistance", 3, 1, 50, false, function(value)
    getgenv().FrontDistance = value
end)

about:Toggle("循环传送至玩家前方", "LoopFrontTP", false, function(state)
    getgenv().LoopFrontTPEnabled = state
    local connection
    if state and selectedPlayer then
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LoopFrontTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            local targetCF = selectedPlayer.Character.HumanoidRootPart.CFrame
            local frontPos = targetCF.Position + targetCF.LookVector * (getgenv().FrontDistance or 5)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(frontPos)
            end
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)

about:Slider("传送头顶的距离", "HeadDistance", 4, 1, 50, false, function(value)
    getgenv().HeadDistance = value
end)

about:Toggle("循环传送至玩家头顶", "LoopHeadHeight", false, function(state)
    getgenv().LoopHeadHeightEnabled = state
    local connection
    if state and selectedPlayer then
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LoopHeadHeightEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            local targetPos = selectedPlayer.Character.HumanoidRootPart.Position
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos.X, targetPos.Y + (getgenv().HeadDistance or 5), targetPos.Z)
            end
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)

about:Slider("传送后面的距离", "BackDistance", 2, 1, 50, false, function(value)
    getgenv().BackDistance = value
end)

about:Toggle("循环传送至玩家后面", "LoopBackTP", false, function(state)
    getgenv().LoopBackTPEnabled = state
    local connection
    if state and selectedPlayer then
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LoopBackTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            local targetCF = selectedPlayer.Character.HumanoidRootPart.CFrame
            local backPos = targetCF.Position - targetCF.LookVector * (getgenv().BackDistance or 5)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(backPos)
            end
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)

local about = UITab5:section("『FE』",true)

about:Button("FE C00lgui", function()
loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
about:Button("FE 1x1x1x1", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)
about:Button("FE大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)
about:Button("FE用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)
about:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)
about:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)
about:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)
about:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)
about:Button("超长机巴", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)
about:Button("操人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/AHAJAJAKAK/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A.LUA", true))()
end)
about:Button("FE动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)
about:Button("FE变玩家", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)
about:Button("FE猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)
about:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)

local about = UITab6:section("『普通版』",true)

about:Label("我懒得写了喵")

about:Button("人物透视+名字",function()  
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
        local function ApplyESP(v)
       if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
           v.Character.Humanoid.NameDisplayDistance = 9e9
           v.Character.Humanoid.NameOcclusion = "NoOcclusion"
           v.Character.Humanoid.HealthDisplayDistance = 9e9
           v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
           v.Character.Humanoid.Health = v.Character.Humanoid.Health
       end
    end
    for i,v in pairs(game.Players:GetPlayers()) do
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end
    
    game.Players.PlayerAdded:Connect(function(v)
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end)
    
        local Players = game:GetService("Players"):GetChildren()
    local RunService = game:GetService("RunService")
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    
    for i, v in pairs(Players) do
        repeat wait() until v.Character
        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = v.Character
            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlightClone.Name = "Highlight"
        end
    end
    
    game.Players.PlayerAdded:Connect(function(player)
        repeat wait() until player.Character
        if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = player.Character
            highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.Name = "Highlight"
        end
    end)
    
    game.Players.PlayerRemoving:Connect(function(playerRemoved)
        playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
    end)
    
    RunService.Heartbeat:Connect(function()
        for i, v in pairs(Players) do
            repeat wait() until v.Character
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
                task.wait()
            end
    end
    end)
    end)

local about = UITab7:section("『旋转速度』",true)

about:Button("关闭旋转", function()
    local plr = game:GetService("Players").LocalPlayer
    if plr.Character then
        local humRoot = plr.Character:FindFirstChild("HumanoidRootPart")
        if humRoot then
            local spinbot = humRoot:FindFirstChild("Spinbot")
            if spinbot then
                spinbot:Destroy()
            end
        end
        
        local humanoid = plr.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.AutoRotate = true
        end
    end
    print("旋转已关闭")
end)

about:Button("旋转10", function()
    local speed = 10
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转20", function()
    local speed = 20
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转40", function()
    local speed = 40
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转50", function()
    local speed = 50
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转60", function()
    local speed = 60
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转70", function()
    local speed = 70
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转80", function()
    local speed = 80
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转90", function()
    local speed = 90
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转100", function()
    local speed = 100
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转150", function()
    local speed = 150
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转200", function()
    local speed = 200
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

about:Button("旋转250", function()
    local speed = 250
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    plr.Character:WaitForChild("Humanoid").AutoRotate = false
    local velocity = Instance.new("AngularVelocity")
    velocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
    velocity.MaxTorque = math.huge
    velocity.AngularVelocity = Vector3.new(0, speed, 0)
    velocity.Parent = humRoot
    velocity.Name = "Spinbot"
end)

local about = UITab8:section("『挽脚本通用源码☆自然灾害』", true)
about:Label("检测到你当前的服务器不是☆自然灾害☆")
about:Label("亲爱的挽脚本通用源码用户")
about:Label("请到自然灾害执行脚本 会加载对应功能")

local about = UITab9:section("『挽脚本通用源码☆力量传奇』", true)
about:Label("检测到你当前的服务器不是☆力量传奇☆")
about:Label("亲爱的挽脚本通用源码用户")
about:Label("请到力量传奇执行脚本 会加载对应功能")

local about = UITab10:section("『挽脚本通用源码☆极速传奇』", true)
about:Label("检测到你当前的服务器不是☆极速传奇☆")
about:Label("亲爱的挽脚本通用源码用户")
about:Label("请到极速传奇执行脚本 会加载对应功能")

local about = UITab11:section("『挽脚本通用源码☆忍者传奇』", true)
about:Label("忍者传奇更新中")

local about = UITab12:section("『挽脚本通用源码☆战争大亨』", true)
about:Label("检测到你当前的服务器不是☆战争大亨☆")
about:Label("亲爱的挽脚本通用源码用户")
about:Label("请到战争大亨执行脚本 会加载对应功能")

local about = UITab13:section("『挽脚本通用源码☆刀球刃』", true)
about:Label("刀球刃更新中")

game:GetService("StarterGui"):SetCore("SendNotification",{Title="欢迎使用";Text="ui库加载成功喵";Icon="rbxassetid://114514";Duration=3;})
