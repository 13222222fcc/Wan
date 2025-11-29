local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/FengYu-ui/refs/heads/main/mainUI.lua"))()
end)

if not success then
    warm("加载UI发生错误 \n\n（错误代码：风御 X）")
    return
end

local Blacklist = {
    Users = {
        "ajja_2244",
        "hxbbd769",
        "linluwqw",
        "woshidasabi91666"
    }
}

local localPlayer = game.Players.LocalPlayer
local playerName = localPlayer.Name

local isBanned = false

for _, bannedName in pairs(Blacklist.Users) do
    if string.lower(playerName) == string.lower(bannedName) then
        isBanned = true
        break
    end
end

if isBanned then
    
    wait(5)
    game.Players.LocalPlayer:Kick("用户： " .. playerName .. " ┃你已被列入殺脚本黑名单 \n\n（错误代码: 风御 X）")
    return
end

local FengY3 = {
    "殺脚本中心", "风御 X制作", "FengYu Hub", "爆打所有人", 
}

local randomName = FengY3[math.random(1, #FengY3)]
local window = library:new(randomName)
--殺用户服务
local FY = window:card("脚本设置", "随便进群", "84830962019412")

local FengYu = FY:Tab("〖你的信息】",'84830962019412')

local about = FengYu:section("〖最新消息】",true)

about:Image({Type = "Player", UserId = game.Players.LocalPlayer.UserId}, 150, 150)
about:Label("用户名：" .. game.Players.LocalPlayer.Name)
about:Label("用户ID:" .. game.Players.LocalPlayer.UserId)
about:Label("你的注入器:" .. identifyexecutor())
about:Label("注册账号：" .. game.Players.LocalPlayer.AccountAge .. " 天")
about:Label("地区：" .. game:GetService("LocalizationService").RobloxLocaleId)
about:Label("客户端ID:" .. game:GetService("RbxAnalyticsService"):GetClientId())
--服务器拓展
about:Image({Type = "Game", PlaceId = game.PlaceId}, 150, 150)
about:Label("你在的服务器名字:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
about:Label("服务器ID:" .. game.GameId)

local FengYu = FY:Tab("〖殺脚本官方项目】",'84830962019412')

local us = FengYu:section("〖制作人员信息】",true)

us:Image("139304770593574", 150, 150)
us:Button("别忘了进群❗（点击复制QQ群号）",function()
setclipboard("819104139")
end)

local FengYu = FY:Tab("〖风御 X】",'84830962019412')

local me = FengYu:section("〖主官方】",true)
me:Image("78337278414476", 150, 150)
me:Button("游戏名:FengY3（复制）",function()
setclipboard("FengY3")
end)
me:Label("主要开发人员")
me:Label("善良又帮助别人")
me:Label("说话傻傻的")
me:Label("心不坏")
me:Label("喜欢开玩笑")
me:Button("复制QQ号",function()
setclipboard("1926190957")
end)
me:Button("复制快手号",function()
setclipboard("FengYu19400")
end)
me:Button("复制哔哩哔哩名字",function()
setclipboard("X风御X")
end)
local FengYu = FY:Tab("〖单殺 X】",'84830962019412')

local me = FengYu:section("〖领导】",true)
me:Image("117707731864858", 150, 150)
me:Label("主要提供人员")
me:Label("目前没发现什么特点")
me:Button("复制QQ号",function()
setclipboard("917104821")
end)
me:Button("复制快手号（爱直播）",function()
setclipboard("TianRuo928")
end)

local FY = window:card("全局通用", "毫无疑问就是通用", "132419977785712")

local FengYu = FY:Tab("〖本地玩家】",'84830962019412')

local Feng = FengYu:section("〖修改权限※】",true)
            Feng:Toggle("速度 (开/关)","开关",false,function(v)
                if v == true then
                    sudu = game:GetService("RunService").Heartbeat:Connect(function()
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                            if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                                game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                            end
                        end
                    end)
                elseif not v and sudu then
                    sudu:Disconnect()
                    sudu = nil
                end
            end)

            Feng:Slider('速度设置', '拉条',  1, 1, 1000,false, function(v)
                Speed = v
            end)

Feng:Textbox("快速跑步", "tpwalking", "推荐调2", function(king)
local tspeed = king
local hb = game:GetService("RunService").Heartbeat
local tpwalking = true
local player = game:GetService("Players")
local lplr = player.LocalPlayer
local chr = lplr.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
while tpwalking and hb:Wait() and chr and hum and hum.Parent do
  if hum.MoveDirection.Magnitude > 0 then
    if tspeed then
      chr:TranslateBy(hum.MoveDirection * tonumber(tspeed))
    else
      chr:TranslateBy(hum.MoveDirection)
    end
  end
end
end)
    
Feng:Textbox("漂移加速", "", "输入", function(Value)
    if tonumber(Value) then
        speed = tonumber(Value)
        tpwalkingspeed = true
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
        
        if humanoid then
            RunService:UnbindFromRenderStep("TPWalk")

            RunService:BindToRenderStep("TPWalk", Enum.RenderPriority.Character.Value, function(delta)
                if tpwalkingspeed and character and humanoid and humanoid.Parent then
                    if humanoid.MoveDirection.Magnitude > 0 then
                        character:TranslateBy(humanoid.MoveDirection * speed * delta * 10)
                    end
                end
            end)
        end
    else
        print("感觉自己好帅呀")
    end
end)

Feng:Button("点击即可漂移加速关闭",function()
    tpwalkingspeed = false
    RunService:UnbindFromRenderStep("TPWalk")
end)
  
Feng:Slider('修改跳跃', 'JumpPowerSlider', 50, 50, 99999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)
    
Feng:Slider('修改生命值', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.Health = Value
end)
 
Feng:Slider('相机焦距上限', 'ZOOOOOM OUT!',  20, 0, 200000,false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)
    
local FengYu = FY:Tab("〖通用】",'84830962019412')

local Feng = FengYu:section("〖精选通用※】",true)
  
Feng:Toggle("隐身〖实用】", "FengYu", false, function(state)
    if state then
        local savedpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait()
        game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-25.95, 84, 3537.55))
        wait(.15)
        local Seat = Instance.new('Seat', game.Workspace)
        Seat.Anchored = false
        Seat.CanCollide = false
        Seat.Name = 'invischair'
        Seat.Transparency = 1
        Seat.Position = Vector3.new(-25.95, 84, 3537.55)
        local Weld = Instance.new("Weld", Seat)
        Weld.Part0 = Seat
        Weld.Part1 = game.Players.LocalPlayer.Character:FindFirstChild("Torso") or game.Players.LocalPlayer.Character.UpperTorso
        wait()
        Seat.CFrame = savedpos
        
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0.5
            end
        end
    else
        local invisChair = workspace:FindFirstChild('invischair')
        if invisChair then
            invisChair:Destroy()
        end
        
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 0
            end
        end
    end
end)
  
Feng:Toggle("穿墙", "FengYu", false, function(Value)
    if Value then
        Noclip = true
        Stepped = game.RunService.Stepped:Connect(function()
            if Noclip == true then
                for a, b in pairs(game.Workspace:GetChildren()) do
                    if b.Name == game.Players.LocalPlayer.Name then
                        for i, v in pairs(game.Workspace[game.Players.LocalPlayer.Name]:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                end
            else
                Stepped:Disconnect()
            end
        end)
    else
        Noclip = false
    end
end)
 
Feng:Toggle("自动互动","AutoInteract",false, function(state)
    if state then
        autoInteract = true
        while autoInteract do
            for _,descendant in pairs(workspace:GetDescendants()) do
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

Feng:Toggle("快速交互", "Faster", false, function(Fast)
    Faster = Fast
end)

Feng:Toggle("夜视", "FengYu", false, function(state)
        if state then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)
    
Feng:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)

Feng:Toggle("无敌", "FengYu", false, function(Value)
    if Value then
        local Cam = workspace.CurrentCamera
        local Pos, Char = Cam.CFrame, speaker.Character
        local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
        local nHuman = Human:Clone()
        nHuman.Parent = Char
        nHuman:SetStateEnabled(Enum.HumanoidStateType.Health, false)
        nHuman:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        nHuman:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        nHuman.BreakJointsOnDeath = true
        Human:Destroy()
        speaker.Character = nil
        speaker.Character = Char
        Cam.CameraSubject = nHuman
        Cam.CFrame = wait() and Pos or Cam.CFrame
        nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local Script = Char:FindFirstChild("Animate")
        if Script then
            Script.Disabled = true
            wait()
            Script.Disabled = false
        end
        nHuman.Health = nHuman.MaxHealth
    else
        game.Players.LocalPlayer.Character.Humanoid.Health = 100
    end
end)

Feng:Toggle('上帝模式', 'No Description', false, function(Value)
        if Value then
            local LP = game:GetService"Players".LocalPlayer
            local HRP = LP.Character.HumanoidRootPart
            local Clone = HRP:Clone()
            Clone.Parent = LP.Character
        else
            game.Players.LocalPlayer.Character.Head:Destroy()
        end
    end)
 
Feng:Button("殺飞行",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)
    
Feng:Button("无敌少侠",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
end)

Feng:Button("翻跟斗",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-super-awesome-backflip-31143"))()
end)
    
Feng:Button("飞车",function()  
local Flymguiv2 = Instance.new("ScreenGui")
local Drag = Instance.new("Frame")
local FlyFrame = Instance.new("Frame")
local ddnsfbfwewefe = Instance.new("TextButton")
local Speed = Instance.new("TextBox")
local Fly = Instance.new("TextButton")
local Speeed = Instance.new("TextLabel")
local Stat = Instance.new("TextLabel")
local Stat2 = Instance.new("TextLabel")
local Unfly = Instance.new("TextButton")
local Vfly = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local Flyon = Instance.new("Frame")
local W = Instance.new("TextButton")
local S = Instance.new("TextButton")

--Properties:

Flymguiv2.Name = "Flym gui v2"
Flymguiv2.Parent = game.CoreGui
Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Drag.Name = "Drag"
Drag.Parent = Flymguiv2
Drag.Active = true
Drag.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Drag.BorderSizePixel = 0
Drag.Draggable = true
Drag.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)
Drag.Size = UDim2.new(0, 237, 0, 27)

FlyFrame.Name = "FlyFrame"
FlyFrame.Parent = Drag
FlyFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FlyFrame.BorderSizePixel = 0
FlyFrame.Draggable = true
FlyFrame.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)
FlyFrame.Size = UDim2.new(0, 237, 0, 139)

ddnsfbfwewefe.Name = "ddnsfbfwewefe"
ddnsfbfwewefe.Parent = FlyFrame
ddnsfbfwewefe.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
ddnsfbfwewefe.BorderSizePixel = 0
ddnsfbfwewefe.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)
ddnsfbfwewefe.Size = UDim2.new(0, 237, 0, 27)
ddnsfbfwewefe.Font = Enum.Font.SourceSans
ddnsfbfwewefe.Text = "殺脚本"
ddnsfbfwewefe.TextColor3 = Color3.fromRGB(255, 255, 255)
ddnsfbfwewefe.TextScaled = true
ddnsfbfwewefe.TextSize = 14.000
ddnsfbfwewefe.TextWrapped = true

Speed.Name = "Speed"
Speed.Parent = FlyFrame
Speed.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
Speed.BorderColor3 = Color3.fromRGB(0, 0, 191)
Speed.BorderSizePixel = 0
Speed.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)
Speed.Size = UDim2.new(0, 111, 0, 33)
Speed.Font = Enum.Font.SourceSans
Speed.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Speed.Text = "50"
Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speed.TextScaled = true
Speed.TextSize = 14.000
Speed.TextWrapped = true

Fly.Name = "Fly"
Fly.Parent = FlyFrame
Fly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Fly.Size = UDim2.new(0, 199, 0, 32)
Fly.Font = Enum.Font.SourceSans
Fly.Text = "开启"
Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
Fly.TextScaled = true
Fly.TextSize = 14.000
Fly.TextWrapped = true
Fly.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        Fly.Visible = false
        Stat2.Text = "开启"
        Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)
        Unfly.Visible = true
        Flyon.Visible = true
        local BV = Instance.new("BodyVelocity",HumanoidRP)
        local BG = Instance.new("BodyGyro",HumanoidRP)
        BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        game:GetService('RunService').RenderStepped:connect(function()
        BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BG.D = 5000
        BG.P = 100000
        BG.CFrame = game.Workspace.CurrentCamera.CFrame
        end)
end)

Speeed.Name = "Speeed"
Speeed.Parent = FlyFrame
Speeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Speeed.BorderSizePixel = 0
Speeed.Position = UDim2.new(0.0759493634, 0, 0.402877688, 0)
Speeed.Size = UDim2.new(0, 87, 0, 32)
Speeed.ZIndex = 0
Speeed.Font = Enum.Font.SourceSans
Speeed.Text = "速度:"
Speeed.TextColor3 = Color3.fromRGB(255, 255, 255)
Speeed.TextScaled = true
Speeed.TextSize = 14.000
Speeed.TextWrapped = true

Stat.Name = "Stat"
Stat.Parent = FlyFrame
Stat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat.BorderSizePixel = 0
Stat.Position = UDim2.new(0.299983799, 0, 0.239817441, 0)
Stat.Size = UDim2.new(0, 85, 0, 15)
Stat.Font = Enum.Font.SourceSans
Stat.Text = "状态:"
Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
Stat.TextScaled = true
Stat.TextSize = 14.000
Stat.TextWrapped = true

Stat2.Name = "Stat2"
Stat2.Parent = FlyFrame
Stat2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Stat2.BorderSizePixel = 0
Stat2.Position = UDim2.new(0.546535194, 0, 0.239817441, 0)
Stat2.Size = UDim2.new(0, 27, 0, 15)
Stat2.Font = Enum.Font.SourceSans
Stat2.Text = "关闭"
Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
Stat2.TextScaled = true
Stat2.TextSize = 14.000
Stat2.TextWrapped = true

Unfly.Name = "Unfly"
Unfly.Parent = FlyFrame
Unfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Unfly.BorderSizePixel = 0
Unfly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
Unfly.Size = UDim2.new(0, 199, 0, 32)
Unfly.Visible = false
Unfly.Font = Enum.Font.SourceSans
Unfly.Text = "停止"
Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Unfly.TextScaled = true
Unfly.TextSize = 14.000
Unfly.TextWrapped = true
Unfly.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        Fly.Visible = true
        Stat2.Text = "关闭"
        Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait()
        Unfly.Visible = false
        Flyon.Visible = false
        HumanoidRP:FindFirstChildOfClass("BodyVelocity"):Destroy()
        HumanoidRP:FindFirstChildOfClass("BodyGyro"):Destroy()
end)

Vfly.Name = "Vfly"
Vfly.Parent = Drag
Vfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Vfly.BorderSizePixel = 0
Vfly.Size = UDim2.new(0, 57, 0, 27)
Vfly.Font = Enum.Font.SourceSans
Vfly.Text = "飞车"
Vfly.TextColor3 = Color3.fromRGB(255, 255, 255)
Vfly.TextScaled = true
Vfly.TextSize = 14.000
Vfly.TextWrapped = true

Close.Name = "Close"
Close.Parent = Drag
Close.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.875, 0, 0, 0)
Close.Size = UDim2.new(0, 27, 0, 27)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true
Close.MouseButton1Click:Connect(function()
        Flymguiv2:Destroy()
end)

Minimize.Name = "Minimize"
Minimize.Parent = Drag
Minimize.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.75, 0, 0, 0)
Minimize.Size = UDim2.new(0, 27, 0, 27)
Minimize.Font = Enum.Font.SourceSans
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextScaled = true
Minimize.TextSize = 14.000
Minimize.TextWrapped = true
function Mini()
        if Minimize.Text == "-" then
                Minimize.Text = "+"
                FlyFrame.Visible = false
        elseif Minimize.Text == "+" then
                Minimize.Text = "-"
                FlyFrame.Visible = true
        end
end
Minimize.MouseButton1Click:Connect(Mini)

Flyon.Name = "Fly on"
Flyon.Parent = Flymguiv2
Flyon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Flyon.BorderSizePixel = 0
Flyon.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)
Flyon.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)
Flyon.Visible = false
Flyon.Active = true
Flyon.Draggable = true

W.Name = "W"
W.Parent = Flyon
W.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
W.BorderSizePixel = 0
W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)
W.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
W.Font = Enum.Font.SourceSans
W.Text = "^"
W.TextColor3 = Color3.fromRGB(255, 255, 255)
W.TextScaled = true
W.TextSize = 14.000
W.TextWrapped = true
W.TouchLongPress:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

W.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.Name = "S"
S.Parent = Flyon
S.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
S.BorderSizePixel = 0
S.Position = UDim2.new(0.134000003, 0, 0.479999989, 0)
S.Rotation = 180.000
S.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
S.Font = Enum.Font.SourceSans
S.Text = "^"
S.TextColor3 = Color3.fromRGB(255, 255, 255)
S.TextScaled = true
S.TextSize = 14.000
S.TextWrapped = true
S.TouchLongPress:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)

S.MouseButton1Click:Connect(function()
        local HumanoidRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -Speed.Text
        wait(.1)
        HumanoidRP.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
end)
end)

    Feng:Button(
        "自杀",
        function()
            game.Players.LocalPlayer.Character.Humanoid.Health=0
HumanDied = true
        end
    )    

    Feng:Toggle("FPS显示", "FengYu", false, function(state)
    if state then

        local ScreenGui = Instance.new("ScreenGui")
        local FpsLabel = Instance.new("TextLabel")

        ScreenGui.Name = "FPSGui"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        FpsLabel.Name = "FPSLabel"
        FpsLabel.Size = UDim2.new(0, 100, 0, 50)
        FpsLabel.Position = UDim2.new(0.75,20,0.075,20)--位置
        FpsLabel.BackgroundTransparency = 1
        FpsLabel.Font = Enum.Font.SourceSansBold
        FpsLabel.Text = "FPS: 0"
        FpsLabel.TextSize = 30
        FpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0) --颜色
        FpsLabel.Parent = ScreenGui

        local frameCounter = 0

        local function updateFpsLabel()
            frameCounter = frameCounter + 1
            if frameCounter >= 20 then
                local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
                FpsLabel.Text = "风御FPS: " .. fps
                frameCounter = 0
            end
        end

        local connection = game:GetService("RunService").RenderStepped:Connect(updateFpsLabel)

        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        getgenv().FPS_Toggle = {
            ScreenGui = ScreenGui,
            connection = connection
        }
    else

        if getgenv().FPS_Toggle then
            if getgenv().FPS_Toggle.connection then
                getgenv().FPS_Toggle.connection:Disconnect()
            end
            if getgenv().FPS_Toggle.ScreenGui then
                getgenv().FPS_Toggle.ScreenGui:Destroy()
            end
            getgenv().FPS_Toggle = nil
        end
    end
    end)
    
Feng:Button(
        "动态模糊",
        function()
            local camera = workspace.CurrentCamera
local blurAmount = 10
local blurAmplifier = 5
local lastVector = camera.CFrame.LookVector

local motionBlur = Instance.new("BlurEffect", camera)

local runService = game:GetService("RunService")

workspace.Changed:Connect(function(property)
 if property == "CurrentCamera" then
  print("Changed")
  local camera = workspace.CurrentCamera
  if motionBlur and motionBlur.Parent then
   motionBlur.Parent = camera
  else
   motionBlur = Instance.new("BlurEffect", camera)
  end
 end
end)

runService.Heartbeat:Connect(function()
 if not motionBlur or motionBlur.Parent == nil then
  motionBlur = Instance.new("BlurEffect", camera)
 end
 
 local magnitude = (camera.CFrame.LookVector - lastVector).magnitude
 motionBlur.Size = math.abs(magnitude)*blurAmount*blurAmplifier/2
 lastVector = camera.CFrame.LookVector
end)
        end
    )
    
Feng:Button("飞檐走壁",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)
    
Feng:Textbox("旋转速度", "SpinSpeed", "输入", function(Value)
    local speed = tonumber(Value)
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    local humanoid = plr.Character:WaitForChild("Humanoid")
    humanoid.AutoRotate = false

    if not spinVelocity then
        spinVelocity = Instance.new("AngularVelocity")
        spinVelocity.Attachment0 = humRoot:WaitForChild("RootAttachment")
        spinVelocity.MaxTorque = math.huge
        spinVelocity.AngularVelocity = Vector3.new(0, speed, 0)
        spinVelocity.Parent = humRoot
        spinVelocity.Name = "Spinbot"
    else
        spinVelocity.AngularVelocity = Vector3.new(0, speed, 0)
    end
end)

Feng:Button("停止旋转", function()
    local plr = game:GetService("Players").LocalPlayer
    repeat task.wait() until plr.Character
    local humRoot = plr.Character:WaitForChild("HumanoidRootPart")
    local humanoid = plr.Character:WaitForChild("Humanoid")

    local spinbot = humRoot:FindFirstChild("Spinbot")
    if spinbot then
        spinbot:Destroy()
        spinVelocity = nil
    end
    humanoid.AutoRotate = true 
end)
  
local FengYu = FY:Tab("〖玩家透视】",'84830962019412')

local Feng = FengYu:section("〖ESP※】", 
true)

local ColorPresets = {
    {"红", Color3.fromRGB(255, 0, 0)},
    {"绿", Color3.fromRGB(0, 255, 0)},
    {"蓝", Color3.fromRGB(0, 0, 255)},
    {"黄", Color3.fromRGB(255, 255, 0)},
    {"紫", Color3.fromRGB(128, 0, 128)},
    {"白", Color3.fromRGB(255, 255, 255)},
    {"黑", Color3.fromRGB(0, 0, 0)},
    {"橙", Color3.fromRGB(255, 165, 0)},
    {"青", Color3.fromRGB(0, 255, 255)},
    {"粉", Color3.fromRGB(255, 105, 180)},
    {"青绿", Color3.fromRGB(0, 255, 127)},
    {"金色", Color3.fromRGB(255, 215, 0)},
    {"银色", Color3.fromRGB(192, 192, 192)}
}

local function GetColorByName(name)
    for _, preset in ipairs(ColorPresets) do
        if preset[1] == name then
            return preset[2]
        end
    end
    return Color3.new(1, 1, 1)
end

local function GetColorNames()
    local names = {}
    for _, preset in ipairs(ColorPresets) do
        table.insert(names, preset[1])
    end
    return names
end

local function GetPlayerWeapon(character)
    local tool = character:FindFirstChildOfClass("Tool")
    return tool and tool.Name or "无武器"
end

local function GetPlayerBackpackWeapons(player)
    local weapons = {}
    if player:FindFirstChild("Backpack") then
        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(weapons, tool.Name)
            end
        end
    end
    return #weapons > 0 and table.concat(weapons, ", ") or "无武器"
end

-- ESP配置
local ESPConfig = {
    Enabled = false,
    
    ShowName = true,
    ShowHealth = true,
    ShowDistance = true,
    ShowWeapon = true,
    ShowTeam = true,
    ShowBackpack = false,
    
    FillTransparency = 0.5,
    OutlineTransparency = 0.2,
    TextSize = 14,
    TextOutline = true,
    
    ColorMode = "队伍_红",
    RainbowSpeed = 2,
    
    MaxDistance = 2000,
    UseDistanceFade = true,
    
    TeamCheck = true,
    
    HighlightEnabled = true,
    BoxOutlineEnabled = true,
    
    WallhackEnabled = false,
    ChamsEnabled = false,
    NameTagSize = 1.0,
    HealthBarEnabled = true,
    DistanceScale = true,
    
    UpdateRate = 30,
    PerformanceMode = false
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local ESPCache = {}
local LastUpdateTime = 0

local function CalculateVisibility(distance, maxDistance)
    if distance > maxDistance then return 0 end
    local fadeStart = maxDistance * 0.8
    if distance > fadeStart then
        return 1 - ((distance - fadeStart) / (maxDistance - fadeStart))
    end
    return 1
end

local function CalculatePlayerColor(esp, humanoid, distance)
    local mode = ESPConfig.ColorMode
    
    if mode == "队伍_红" or mode == "队伍_绿" or mode == "队伍_蓝" then
        local isTeammate = ESPConfig.TeamCheck and esp.Player.Team == LocalPlayer.Team
        
        if mode == "队伍_红" then
            return isTeammate and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        elseif mode == "队伍_绿" then
            return isTeammate and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        else
            return isTeammate and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(255, 100, 100)
        end
        
    elseif mode == "血量" then
        if humanoid and humanoid.MaxHealth > 0 then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            return Color3.new(2 * (1 - healthPercent), 2 * healthPercent, 0)
        end
        return Color3.new(1, 1, 1)
        
    elseif mode == "彩虹" then
        return Color3.fromHSV((tick() * ESPConfig.RainbowSpeed) % 1, 1, 1)
        
    elseif mode == "距离" then
        local distPercent = math.clamp(distance / ESPConfig.MaxDistance, 0, 1)
        return Color3.fromHSV(distPercent * 0.7, 1, 1)
        
    else
        return GetColorByName(mode)
    end
end

local function IsBehindWall(character)
    if not ESPConfig.WallhackEnabled then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return true end
    
    local ray = Ray.new(Camera.CFrame.Position, (humanoidRootPart.Position - Camera.CFrame.Position).Unit * 100)
    local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {Camera, LocalPlayer.Character, character})
    
    return part ~= nil
end

local function CreateESP(character, player)
    if not character or not character.Parent or ESPCache[character] then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local esp = {
        Character = character,
        Player = player,
        Highlight = nil,
        Billboard = nil,
        HealthBar = nil,
        Connections = {}
    }
    
    esp.Highlight = Instance.new("Highlight")
    esp.Highlight.Name = "ESP_Highlight"
    esp.Highlight.FillColor = Color3.new(1, 1, 1)
    esp.Highlight.OutlineColor = Color3.new(0, 0, 0)
    esp.Highlight.FillTransparency = ESPConfig.FillTransparency
    esp.Highlight.OutlineTransparency = ESPConfig.OutlineTransparency
    esp.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    esp.Highlight.Enabled = ESPConfig.Enabled and ESPConfig.HighlightEnabled
    esp.Highlight.Parent = character
    
    esp.Billboard = Instance.new("BillboardGui")
    esp.Billboard.Name = "ESP_Billboard"
    esp.Billboard.AlwaysOnTop = true
    esp.Billboard.Size = UDim2.new(0, 200 * ESPConfig.NameTagSize, 0, 60 * ESPConfig.NameTagSize)
    esp.Billboard.StudsOffset = Vector3.new(0, 3, 0)
    esp.Billboard.Adornee = humanoidRootPart
    esp.Billboard.Enabled = ESPConfig.Enabled
    esp.Billboard.MaxDistance = ESPConfig.MaxDistance
    esp.Billboard.Parent = character
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESP_TextLabel"
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextSize = ESPConfig.TextSize * ESPConfig.NameTagSize
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextStrokeTransparency = ESPConfig.TextOutline and 0.5 or 1
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.Text = ""
    textLabel.ZIndex = 10
    textLabel.Parent = esp.Billboard
    
    if ESPConfig.HealthBarEnabled then
        local healthBar = Instance.new("Frame")
        healthBar.Name = "ESP_HealthBar"
        healthBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        healthBar.BorderSizePixel = 0
        healthBar.Size = UDim2.new(1, 0, 0, 4 * ESPConfig.NameTagSize)
        healthBar.Position = UDim2.new(0, 0, 1, 0)
        healthBar.ZIndex = 11
        healthBar.Parent = esp.Billboard
        
        local healthFill = Instance.new("Frame")
        healthFill.Name = "ESP_HealthFill"
        healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
        healthFill.BorderSizePixel = 0
        healthFill.Size = UDim2.new(1, 0, 1, 0)
        healthFill.ZIndex = 12
        healthFill.Parent = healthBar
        
        esp.HealthBar = healthFill
    end
    
    esp.Connections.CharacterRemoving = character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            CleanupESP(character)
        end
    end)
    
    ESPCache[character] = esp
end

local function CleanupESP(character)
    local esp = ESPCache[character]
    if esp then
        for _, conn in pairs(esp.Connections) do
            conn:Disconnect()
        end
        if esp.Highlight then esp.Highlight:Destroy() end
        if esp.Billboard then esp.Billboard:Destroy() end
        ESPCache[character] = nil
    end
end

local function UpdateESP()
    local currentTime = tick()
    if currentTime - LastUpdateTime < (1 / ESPConfig.UpdateRate) then
        return
    end
    LastUpdateTime = currentTime
    
    if not ESPConfig.Enabled then 
        for character, esp in pairs(ESPCache) do
            if esp.Highlight then esp.Highlight.Enabled = false end
            if esp.Billboard then esp.Billboard.Enabled = false end
        end
        return 
    end
    
    for character, esp in pairs(ESPCache) do
        if not character or not character.Parent then
            CleanupESP(character)
            continue
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            if esp.Highlight then esp.Highlight.Enabled = false end
            if esp.Billboard then esp.Billboard.Enabled = false end
            continue
        end
        
        local distance = (humanoidRootPart.Position - Camera.CFrame.Position).Magnitude
        local visibility = CalculateVisibility(distance, ESPConfig.MaxDistance)
        
        if visibility <= 0 then
            if esp.Highlight then esp.Highlight.Enabled = false end
            if esp.Billboard then esp.Billboard.Enabled = false end
            continue
        end
        
        local color = CalculatePlayerColor(esp, humanoid, distance)
        local alphaMultiplier = ESPConfig.UseDistanceFade and visibility or 1
        local isBehindWall = IsBehindWall(character)
        
        if esp.Highlight then
            esp.Highlight.FillColor = color
            esp.Highlight.OutlineColor = Color3.new(0, 0, 0)
            
            esp.Highlight.FillTransparency = ESPConfig.FillTransparency + (0.3 * (1 - alphaMultiplier))
            
            if ESPConfig.BoxOutlineEnabled then
                esp.Highlight.OutlineTransparency = ESPConfig.OutlineTransparency + (0.3 * (1 - alphaMultiplier))
            else
                esp.Highlight.OutlineTransparency = 1
            end
            
            esp.Highlight.Enabled = ESPConfig.HighlightEnabled and (not isBehindWall or ESPConfig.WallhackEnabled)
        end
        
        local textLabel = esp.Billboard:FindFirstChildOfClass("TextLabel")
        if textLabel then
            local textParts = {}
            
            if ESPConfig.ShowName then
                table.insert(textParts, esp.Player.Name)
            end
            
            if ESPConfig.ShowHealth then
                table.insert(textParts, string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth)))
            end
            
            if ESPConfig.ShowDistance then
                table.insert(textParts, string.format("%dm", math.floor(distance)))
            end
            
            if ESPConfig.ShowWeapon then
                table.insert(textParts, GetPlayerWeapon(character))
            end
            
            if ESPConfig.ShowBackpack then
                local backpackWeapons = GetPlayerBackpackWeapons(esp.Player)
                if backpackWeapons ~= "无武器" then
                    table.insert(textParts, "背包: " .. backpackWeapons)
                end
            end
            
            if ESPConfig.ShowTeam then
                local isTeammate = ESPConfig.TeamCheck and esp.Player.Team == LocalPlayer.Team
                table.insert(textParts, isTeammate and "队友" or "敌人")
            end
            
            if isBehindWall and ESPConfig.WallhackEnabled then
                table.insert(textParts, "[墙后]")
            end
            
            textLabel.Text = table.concat(textParts, " | ")
            textLabel.TextColor3 = color
            textLabel.TextTransparency = ESPConfig.UseDistanceFade and (0.3 * (1 - alphaMultiplier)) or 0
            textLabel.TextSize = ESPConfig.TextSize * (ESPConfig.DistanceScale and math.clamp(1.5 - (distance / 1000) * 0.5, 0.8, 1.5) or 1) * ESPConfig.NameTagSize
            esp.Billboard.Enabled = #textParts > 0 and (not isBehindWall or ESPConfig.WallhackEnabled)
        end
        
        if esp.HealthBar then
            local healthPercent = humanoid.Health / humanoid.MaxHealth
            esp.HealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
            esp.HealthBar.BackgroundColor3 = Color3.new(1 - healthPercent, healthPercent, 0)
        end
    end
end

local function RecreateAllESP()
    for character, esp in pairs(ESPCache) do
        CleanupESP(character)
    end
    
    if ESPConfig.Enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                CreateESP(player.Character, player)
            end
        end
    end
    UpdateESP()
end

local function InitializePlayerESP(player)
    if player == LocalPlayer then return end
    
    local function CharacterAdded(character)
        task.wait(0.5)
        if ESPConfig.Enabled then
            CreateESP(character, player)
        end
    end
    
    if player.Character and ESPConfig.Enabled then
        task.spawn(CharacterAdded, player.Character)
    end
    
    player.CharacterAdded:Connect(CharacterAdded)
    player.CharacterRemoving:Connect(function(character)
        CleanupESP(character)
    end)
end

RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character then return end
    pcall(UpdateESP)
end)

if ESPConfig.Enabled then
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            InitializePlayerESP(player)
        end
    end
end

Players.PlayerAdded:Connect(InitializePlayerESP)

Feng:Toggle("开启ESP", "esp_toggle", false, function(state)
    ESPConfig.Enabled = state
    if state then
        RecreateAllESP()
    else
        for character, esp in pairs(ESPCache) do
            if esp.Highlight then esp.Highlight:Destroy() end
            if esp.Billboard then esp.Billboard:Destroy() end
        end
        ESPCache = {}
    end
end)

Feng:Toggle("内部发光", "esp_highlight", false, function(state)
    ESPConfig.HighlightEnabled = state
    for _, esp in pairs(ESPCache) do
        if esp.Highlight then
            esp.Highlight.Enabled = state and ESPConfig.Enabled
        end
    end
end)

Feng:Toggle("方框描边", "ESPBoxOutline", false, function(state)
    ESPConfig.BoxOutlineEnabled = state
    for _, esp in pairs(ESPCache) do
        if esp.Highlight then
            esp.Highlight.OutlineTransparency = state and ESPConfig.OutlineTransparency or 1
        end
    end
end)

Feng:Toggle("显示玩家名字", "esp_show_name", false, function(state)
    ESPConfig.ShowName = state
    UpdateESP()
end)

Feng:Toggle("显示血量", "esp_show_health", false, function(state)
    ESPConfig.ShowHealth = state
    UpdateESP()
end)

Feng:Toggle("显示距离", "esp_show_distance", false, function(state)
    ESPConfig.ShowDistance = state
    UpdateESP()
end)

Feng:Toggle("显示武器", "esp_show_weapon", false, function(state)
    ESPConfig.ShowWeapon = state
    UpdateESP()
end)

Feng:Toggle("显示背包", "esp_show_backpack", false, function(state)
    ESPConfig.ShowBackpack = state
    UpdateESP()
end)

Feng:Toggle("显示队伍", "esp_show_team", false, function(state)
    ESPConfig.ShowTeam = state
    UpdateESP()
end)

Feng:Dropdown("颜色模式", "esp_color_mode", {
    "队伍_红", "队伍_绿", "队伍_蓝",
    "血量", "彩虹", "距离",
    "红", "绿", "蓝", "黄", "紫", "白", "黑", "橙", "青", "粉", "青绿", "金色", "银色"
}, function(selected)
    ESPConfig.ColorMode = selected
    UpdateESP()
end)

Feng:Toggle("队伍检测", "esp_team_check", false, function(state)
    ESPConfig.TeamCheck = state
    UpdateESP()
end)

Feng:Toggle("穿墙显示", "esp_wallhack", false, function(state)
    ESPConfig.WallhackEnabled = state
    UpdateESP()
end)

Feng:Toggle("血量条显示", "esp_health_bar", false, function(state)
    ESPConfig.HealthBarEnabled = state
    RecreateAllESP()
end)

Feng:Toggle("距离缩放", "esp_distance_scale", false, function(state)
    ESPConfig.DistanceScale = state
    UpdateESP()
end)

Feng:Toggle("性能模式", "esp_performance_mode", false, function(state)
    ESPConfig.PerformanceMode = state
    if state then
        ESPConfig.UpdateRate = 15
        ESPConfig.UseDistanceFade = true
        ESPConfig.MaxDistance = 1000
    else
        ESPConfig.UpdateRate = 30
        ESPConfig.UseDistanceFade = true
        ESPConfig.MaxDistance = 2000
    end
    UpdateESP()
end)

local FengYu = FY:Tab("〖自瞄】",'84830962019412')

local Feng = FengYu:section("〖自瞄※】",true)

local isAiming = false
local isPredicting = false 
local isLowHealthPriority = false
local fov = 50 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Cam = workspace.CurrentCamera


local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(255, 0, 0)
FOVring.Filled = false
FOVring.Radius = fov
FOVring.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)


local targetPart = "Head"


local function updateDrawings()
    FOVring.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
end


local function removeFOVring()
    FOVring.Visible = false
end


local function lookAt(target)
    local lookVector = (target - Cam.CFrame.Position).Unit
    local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
    Cam.CFrame = newCFrame
end


local function getClosestPlayerInFOV()
    local nearest = nil
    local last = math.huge
    local lowestHealthPlayer = nil
    local lowestHealth = math.huge
    local playerMousePos = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= plr then
            local character = player.Character
            if character and character:FindFirstChild(targetPart) then
                local part = character[targetPart]
                local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude

                if distance < last and isVisible and distance < fov then
                    last = distance
                    nearest = player
                end

                
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    if humanoid.Health < lowestHealth then
                        lowestHealth = humanoid.Health
                        lowestHealthPlayer = player
                    end
                end
            end
        end
    end

    
    if isLowHealthPriority and lowestHealthPlayer then
        return lowestHealthPlayer
    end

    return nearest
end


local function predictNextPosition(player, deltaTime)
    local character = player.Character
    if not character or not character:FindFirstChild(targetPart) then return end

    local part = character[targetPart]
    local velocity = part.Velocity
    local nextPosition = part.Position + velocity * deltaTime * 1.2 
    return nextPosition
end


local function toggleAiming(v)
    if v then 
        isAiming = true
        FOVring.Visible = true

        
        targetPart = "Head"

        
        FOVring.Connection = RunService.RenderStepped:Connect(function(dt)
            updateDrawings()
            local closest = getClosestPlayerInFOV()
            if closest and closest.Character and closest.Character:FindFirstChild(targetPart) then
                local targetPosition = closest.Character[targetPart].Position
                if isPredicting then
                    targetPosition = predictNextPosition(closest, dt)
                end
                lookAt(targetPosition)
            end
        end)
    else 
        isAiming = false
        FOVring.Visible = false

       
        if FOVring.Connection then
            FOVring.Connection:Disconnect()
            FOVring.Connection = nil
        end

        
        Cam.CFrame = workspace.CurrentCamera.CFrame

        
        targetPart = nil 
    end
end


local function togglePredicting(v)
    isPredicting = v
end


local function toggleLowHealthPriority(v)
    isLowHealthPriority = v
end


Feng:Toggle("自瞄 (开/关)", "开关", false, function(v)
    toggleAiming(v)
end)

Feng:Toggle("预判自瞄 (开/关)", "开关", false, function(v)
    togglePredicting(v)
end)

Feng:Toggle("优先瞄准血量低的玩家 (开/关)", "开关", false, function(v)
    toggleLowHealthPriority(v)
end)

Feng:Slider("自瞄圈大小", "拉条", fov, 1, 600, false, function(newFOV)
    fov = newFOV
    if isAiming then
        FOVring.Radius = fov
    else
        removeFOVring() 
    end
end)

Feng:Slider("自瞄圈厚度", "拉条", FOVring.Thickness, 1, 10, false, function(newThickness)
    if isAiming then
        FOVring.Thickness = newThickness
    else
        removeFOVring() 
    end
end)

Feng:Dropdown("自瞄玩家身体部位", "Dropdown", {"头", "胸", "左手", "右手", "左腿", "右腿"}, function(Value)
    if isAiming then
        local partMap = {
            ["头"] = "Head",
            ["胸"] = "UpperTorso",
            ["左手"] = "LeftHand",
            ["右手"] = "RightHand",
            ["左腿"] = "LeftFoot",
            ["右腿"] = "RightFoot"
        }
        targetPart = partMap[Value] 
    end
end)

Feng:Dropdown("自瞄圈颜色", "Dropdown", {"红色", "黄色", "绿色", "蓝色", "紫色", "橙色", "黑色"}, function(Value)
    if isAiming then
        local colorMap = {
            ["红色"] = Color3.fromRGB(255, 0, 0),
            ["黄色"] = Color3.fromRGB(255, 255, 0),
            ["绿色"] = Color3.fromRGB(0, 255, 0),
            ["蓝色"] = Color3.fromRGB(0, 0, 255),
            ["紫色"] = Color3.fromRGB(128, 0, 128),
            ["橙色"] = Color3.fromRGB(255, 165, 0),
            ["黑色"] = Color3.fromRGB(0, 0, 0)
        }
        FOVring.Color = colorMap[Value]
    else
        removeFOVring() 
    end
end)

local FengYu = FY:Tab("〖传送与甩飞】",'84830962019412')

local Feng = FengYu:section("〖传送和与甩飞※】",true)

local dropdown = {}
local playernamedied = ""

for i, player in pairs(game.Players:GetPlayers()) do
    dropdown[i] = player.Name
end
local LS = {
    playernamedied = "",
    dropdown = {},
    sayCount = 1,
    sayFast = false,
    autoSay = false,
}

--传送与甩飞玩家
function shuaxinlb(zji)
    LS.dropdown = {}
    if zji == true then
        for _, player in pairs(game.Players:GetPlayers()) do
            table.insert(LS.dropdown, player.Name)
        end
    else
        local lp = game.Players.LocalPlayer
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp then
                table.insert(LS.dropdown, player.Name)
            end
        end
    end
end
shuaxinlb(true)

function Notify(top, text, ico, dur)
  game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = top,
    Text = text,
    Icon = ico,
    Duration = dur,
  })
end

local dropdown = {}
local playernamedied = ""
local teleportConnection
local behindTeleportDistance = 3 
local headTeleportHeight = 4 


for i, player in pairs(game.Players:GetPlayers()) do
    dropdown[i] = player.Name
end


function Notify(top, text, ico, dur)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = top,
        Text = text,
        Icon = ico,
        Duration = dur,
    })
end

local Players = Feng:Dropdown("选择玩家的名称", 'Dropdown', LS.dropdown, function(v)
    LS.playernamedied = v
end)

Feng:Button("刷新玩家名称", function()
    shuaxinlb(true)
    Players:SetOptions(LS.dropdown)
end)

Feng:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(LS.playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("殺脚本", "已传送到玩家旁边", "rbxassetid://84830962019412", 5)
    else
        Notify("殺脚本", "无法传送 玩家已消失", "rbxassetid://84830962019412", 5)
    end
end)

Feng:Toggle("锁定传送", "Loop", false, function(state)
    if state then
        LS.LoopTeleport = true
        Notify("殺脚本", "已开启循环传送", "rbxassetid://84830962019412", 5)
        while LS.LoopTeleport do
            local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            local tp_player = game.Players:FindFirstChild(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
            wait()
        end
    else
        LS.LoopTeleport = false
        Notify("殺脚本", "已关闭循环传送", "rbxassetid://84830962019412", 5)
    end
end)

Feng:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(LS.playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("殺脚本", "已将玩家传送过来", "rbxassetid://84830962019412", 5)
    else
        Notify("殺脚本", "无法传送 玩家已消失", "rbxassetid://84830962019412", 5)
    end
end)

Feng:Toggle("循环传送玩家过来", "Loop", false, function(state)
    if state then
        LS.LoopTeleport = true
        Notify("殺脚本", "已开启循环传送玩家过来", "rbxassetid://84830962019412", 5)
        while LS.LoopTeleport do
            local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
            local tp_player = game.Players:FindFirstChild(LS.playernamedied)
            if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
                tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
            end
            wait()
        end
    else
        LS.LoopTeleport = false
        Notify("殺脚本", "已关闭循环传送玩家过来", "rbxassetid://84830962019412", 5)
    end
end)

Feng:Toggle("查看玩家", "look player", false, function(state)
    if state then
        game:GetService('Workspace').CurrentCamera.CameraSubject =
            game:GetService('Players'):FindFirstChild(LS.playernamedied).Character.Humanoid
        Notify("殺脚本", "已开启查看玩家", "rbxassetid://84830962019412", 5)
    else
        local lp = game.Players.LocalPlayer
        game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        Notify("殺脚本", "已关闭查看玩家", "rbxassetid://84830962019412", 5)
    end
end)   
 
Feng:Toggle("循环甩飞", "AutoFling",false, function(t)
if LS.playernamedied == nil then
 elseif LS.playernamedied ~= nil then
getgenv().autofling = t
spawn(function()
while autofling do wait()
pcall(function()
local Targets = {LS.playernamedied}

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
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
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
            return Message("错误", "殺脚本", 5)
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

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
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

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
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
            return Message("已开/关", "殺脚本", 5)
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
        return Message("玩家消失", "已停止", 5)
    end
end

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
            Message("检测到玩家消失", "已停止", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        Message("未获取到玩家或工具", "已停止", 5)
    end
end
end)
end
end)
end
end)
 
Feng:Toggle("自瞄选择目标", "Aimbot", false, function(Aimbot)
    if Aimbot then
        while Aimbot do
            local Cam = workspace.CurrentCamera
            local targetPlayer = game.Players:FindFirstChild(LS.playernamedied)
            local target = targetPlayer and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if target and Cam then
                local lookVector = (target.Position - Cam.CFrame.Position).unit
                local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                Cam.CFrame = newCFrame
                wait()
            else
                break
            end
        end
    end
end)

Feng:Toggle("吸选中玩家", "PullPlayer", false, function(state)
    LS.LoopPull = state
    while LS.LoopPull do
        local selfRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetPlayer = game:GetService("Players"):FindFirstChild(LS.playernamedied)
        local targetRoot = targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if selfRoot and targetRoot then
            local direction = (selfRoot.Position - targetRoot.Position).Unit
            targetRoot.CFrame = targetRoot.CFrame + direction * 1.5
        end
        task.wait()
    end
end)
  
Feng:Toggle("吸全部玩家", "TpAll", false, function(state)
    while state do
        local selfRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if selfRoot then
            local direction = selfRoot.CFrame.lookVector
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= LocalPlayer then
                    local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        targetRoot.CFrame = CFrame.new(selfRoot.Position + direction * 3, selfRoot.Position + direction * 4)
                    end
                end
            end
        end
        task.wait()
    end
end)
 
local FengYu = FY:Tab("〖碰撞箱】",'84830962019412')

local Feng = FengYu:section("〖hitbox※】",true)

local HitboxEnabled = false
local HitboxSize = 25
local HitboxTransparency = 0.7
local HitboxColor = "Really red"
local HitboxMaterial = "Neon"
local HitboxCanCollide = false
local HitboxShowOnlyEnemies = false
local HitboxTeamCheck = true
local HitboxRainbowEffect = false
local HitboxPulseEffect = false
local HitboxGlowEffect = false
local HitboxOutline = true
local HitboxAutoResize = false
local HitboxResizeSpeed = 1
local HitboxConnection = nil

local colorOptions = {
    "Really red",
    "Bright red", 
    "Neon orange",
    "Bright yellow",
    "Lime green",
    "Bright green",
    "Really blue",
    "Bright blue",
    "Royal purple",
    "Hot pink",
    "White",
    "Black"
}

local materialOptions = {
    "Neon",
    "Plastic",
    "Wood",
    "Slate",
    "Concrete",
    "CorrodedMetal",
    "DiamondPlate",
    "Foil",
    "Grass",
    "Ice",
    "Marble",
    "Granite",
    "Brick",
    "Pebble",
    "Sand",
    "Fabric",
    "SmoothPlastic",
    "Metal",
    "WoodPlanks",
    "Cobblestone"
}

Feng:Toggle("Hitbox 开关", "HitboxToggle", false, function(Value)
    HitboxEnabled = Value
    if Value then
        startHitbox()
    else
        stopHitbox()
    end
end)

Feng:Textbox("Hitbox 大小", "HitboxSize", "25", function(Value)
    HitboxSize = tonumber(Value) or 25
end)

Feng:Slider('Hitbox 透明度', 'HitboxTransparency', 0.7, 0, 1, false, function(Value)
    HitboxTransparency = Value
end)

Feng:Dropdown("Hitbox 颜色", "HitboxColor", colorOptions, function(Value)
    HitboxColor = Value
end)

Feng:Dropdown("Hitbox 材质", "HitboxMaterial", materialOptions, function(Value)
    HitboxMaterial = Value
end)

Feng:Toggle("禁用碰撞", "HitboxCanCollide", false, function(Value)
    HitboxCanCollide = not Value
end)

Feng:Toggle("仅显示敌人", "HitboxShowOnlyEnemies", false, function(Value)
    HitboxShowOnlyEnemies = Value
end)

Feng:Toggle("队伍检查", "HitboxTeamCheck", true, function(Value)
    HitboxTeamCheck = Value
end)

Feng:Label("特效设置")
Feng:Toggle("彩虹效果", "HitboxRainbowEffect", false, function(Value)
    HitboxRainbowEffect = Value
end)

Feng:Toggle("脉动效果", "HitboxPulseEffect", false, function(Value)
    HitboxPulseEffect = Value
end)

Feng:Toggle("发光效果", "HitboxGlowEffect", false, function(Value)
    HitboxGlowEffect = Value
end)

Feng:Toggle("显示轮廓", "HitboxOutline", true, function(Value)
    HitboxOutline = Value
end)

Feng:Toggle("自动调整大小", "HitboxAutoResize", false, function(Value)
    HitboxAutoResize = Value
end)

Feng:Slider('调整速度', 'HitboxResizeSpeed', 1, 0.1, 5, false, function(Value)
    HitboxResizeSpeed = Value
end)
local FengYu = FY:Tab("〖甩飞功能】",'84830962019412')

local Feng = FengYu:section("〖甩飞欠打的人※】",true)

Feng:Toggle("防甩飞", "FengYu", false, function(state)
    if state then
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        local ANTI_FLING_FORCE = 1e6
        local UPDATE_RATE = 0.01
        
        local ActiveHandles = {
            Connections = {},
            Constraints = {},
            Alignments = {}
        }
        
        local function CreateSuperConstraint(part)
            local bodyPos = Instance.new("BodyPosition")
            bodyPos.P = ANTI_FLING_FORCE
            bodyPos.D = ANTI_FLING_FORCE/10
            bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPos.Position = part.Position
            bodyPos.Parent = part
            
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.P = ANTI_FLING_FORCE
            bodyGyro.D = ANTI_FLING_FORCE/10
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.CFrame = part.CFrame
            bodyGyro.Parent = part
            
            local alignPos = Instance.new("AlignPosition")
            alignPos.RigidityEnabled = true
            alignPos.MaxForce = ANTI_FLING_FORCE
            alignPos.Responsiveness = ANTI_FLING_FORCE
            alignPos.Parent = part
            
            local alignOri = Instance.new("AlignOrientation")
            alignOri.RigidityEnabled = true
            alignOri.MaxTorque = ANTI_FLING_FORCE
            alignOri.Responsiveness = ANTI_FLING_FORCE
            alignOri.Parent = part
            
            table.insert(ActiveHandles.Constraints, bodyPos)
            table.insert(ActiveHandles.Constraints, bodyGyro)
            table.insert(ActiveHandles.Alignments, alignPos)
            table.insert(ActiveHandles.Alignments, alignOri)
            
            return bodyPos, bodyGyro, alignPos, alignOri
        end
        
        local function ApplyUltimateProtection(character)
            if not character then return end
            
            local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
            if not rootPart then return end
            
            local bodyPos, bodyGyro, alignPos, alignOri = CreateSuperConstraint(rootPart)
            
            local updateConn = RunService.Heartbeat:Connect(function()
                if not character:IsDescendantOf(workspace) then return end
                
                bodyPos.Position = rootPart.Position
                bodyGyro.CFrame = rootPart.CFrame
                
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                        part.AssemblyAngularVelocity = Vector3.new()
                        part.AssemblyLinearVelocity = Vector3.new()
                        part.Velocity = Vector3.new()
                        part.RotVelocity = Vector3.new()
                        
                        part:SetAttribute("LastPosition", part.Position)
                    end
                end
            end)
            table.insert(ActiveHandles.Connections, updateConn)
            
            local velConn = rootPart:GetPropertyChangedSignal("AssemblyLinearVelocity"):Connect(function()
                rootPart.AssemblyLinearVelocity = Vector3.new()
                rootPart.Velocity = Vector3.new()
            end)
            table.insert(ActiveHandles.Connections, velConn)
            
            local rotConn = rootPart:GetPropertyChangedSignal("AssemblyAngularVelocity"):Connect(function()
                rootPart.AssemblyAngularVelocity = Vector3.new()
                rootPart.RotVelocity = Vector3.new()
            end)
            table.insert(ActiveHandles.Connections, rotConn)
            
            local posCheck = RunService.Heartbeat:Connect(function()
                if not character:IsDescendantOf(workspace) then return end
                
                local lastPos = rootPart:GetAttribute("LastPosition")
                if lastPos then
                    local dist = (rootPart.Position - lastPos).Magnitude
                    if dist > 5 then
                        rootPart.CFrame = CFrame.new(lastPos)
                    end
                end
                rootPart:SetAttribute("LastPosition", rootPart.Position)
            end)
            table.insert(ActiveHandles.Connections, posCheck)
        end
        
        local function MonitorPlayer(player)
            if player == LocalPlayer then return end
            
            local function HandleCharacter(character)
                if not character then return end
                repeat task.wait() until character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                ApplyUltimateProtection(character)
            end
            
            if player.Character then
                HandleCharacter(player.Character)
            end
            
            local charConn = player.CharacterAdded:Connect(HandleCharacter)
            table.insert(ActiveHandles.Connections, charConn)
        end
        
        for _, player in ipairs(Players:GetPlayers()) do
            MonitorPlayer(player)
        end
        
        local playerConn = Players.PlayerAdded:Connect(MonitorPlayer)
        table.insert(ActiveHandles.Connections, playerConn)
        
    else
        for _, conn in ipairs(ActiveHandles.Connections or {}) do
            if conn.Connected then
                conn:Disconnect()
            end
        end
        
        for _, constraint in ipairs(ActiveHandles.Constraints or {}) do
            if constraint and constraint.Parent then
                constraint:Destroy()
            end
        end
        
        for _, align in ipairs(ActiveHandles.Alignments or {}) do
            if align and align.Parent then
                align:Destroy()
            end
        end
        
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.CustomPhysicalProperties = nil
                        part.AssemblyAngularVelocity = Vector3.new()
                        part.AssemblyLinearVelocity = Vector3.new()
                        part:SetAttribute("LastPosition", nil)
                    end
                end
            end
        end
        
        ActiveHandles = {
            Connections = {},
            Constraints = {},
            Alignments = {}
        }
    end
end)

Feng:Button("旋转甩飞",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)
    
Feng:Button("碰到就飞",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
end)
    
Feng:Button("甩飞全部人",function()
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
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
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
            return Message("Error Occurred", "Targeting is sitting", 5)
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

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
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
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
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
            return Message("Error Occurred", "Target is missing everything", 5)
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
        return Message("Error Occurred", "Random error", 5)
    end
end

if not Welcome then Message("殺脚本甩飞提示", "已开启甩飞后面不会再提示", "rbxassetid://84830962019412", 5)
    end
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
            Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        Message("Error Occurred", "Username Invalid", 5)
    end
end
end)
   
Feng:Button("铁拳",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)
    
local FY = window:card("FE中心", "动画恶搞或其他", "108446823535062")

local FengYu = FY:Tab("〖恶搞】",'84830962019412')

local Feng = FengYu:section("〖让别人笑出来吧※】",true)
   
    Feng:Button(
        "直升机",
        function()
            if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://27432686"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
hi.Volume = 2
hi.Looped = true
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()

local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)

end)
else
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://507776043"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
hi.Volume = 2
hi.Looped = true
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()

local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)


end)    
end
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local u = game.Players.LocalPlayer
local urchar = u.Character

task.spawn(function()


qUp = Mouse.KeyUp:Connect(function(KEY)
if KEY == 'q' then
urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight - 3
end
end)
eUp = Mouse.KeyUp:Connect(function(KEY)
if KEY == 'e' then
urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight + 3
end
end)


end)
        end
    )    
    
Feng:Button("奇怪的舞蹈",function()
    local Players = game:GetService("Players")
local player = Players.LocalPlayer

local originalRot
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:FindFirstChild("HumanoidRootPart")

local function loadAnimation(char)
	local humanoid = char:WaitForChild("Humanoid")
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://136720812089001"
	return animator:LoadAnimation(anim)
end

local function rotateCharacter(char, degrees)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(degrees), 0)
	end
end

if hrp then
	originalRot = hrp.CFrame - hrp.Position
end

local currentTrack = loadAnimation(char)
currentTrack.Looped = true
currentTrack.Priority = Enum.AnimationPriority.Action
currentTrack:Play(0, 99)
currentTrack:AdjustSpeed(1)
rotateCharacter(char, 180)
end)

  Feng:Button("人物螺旋上天",function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://27432686"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=8114290584"
hi.Volume = 2
hi.Looped = false
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()
wait(1.5)
local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
wait(3.5)
while speaker.Character.Humanoid.Health > 0 do
   wait(0.1)
speaker.Character.Humanoid.HipHeight = speaker.Character.Humanoid.HipHeight + 1
end
end)
else
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://507776043"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=8114290584"
hi.Volume = 2
hi.Looped = false
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()
wait(1.5)
local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
wait(3.5)
while speaker.Character.Humanoid.Health > 0 do
   wait(0.1)
speaker.Character.Humanoid.HipHeight = speaker.Character.Humanoid.HipHeight + 1
end
end)    
end
end)
  
Feng:Button("撸管r6",function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
    
Feng:Button("撸管r15",function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
    
    
local FengYu = FY:Tab("〖动画】",'84830962019412')

local Feng = FengYu:section("〖动画※】",true)

Feng:Button("FE-R15动作",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/FE_R15.lua"))()
end)

Feng:Button("VR视角",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
end)

local FengYu = FY:Tab("〖物品】",'84830962019412')

local Feng = FengYu:section("〖给到你的背包※】",true)

Feng:Button("AK-47",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/AK-47.lua"))()
end)

Feng:Button("FE抓取",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty1.lua"))()
end)
 
    Feng:Button("FE传送",function()
    mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "风御传送" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
end)
    
local FengYu = FY:Tab("〖FE脚本】",'84830962019412')

local Feng = FengYu:section("〖FE脚本中心】",true)

Feng:Button("John Doe（只支持R6形象）",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/general/refs/heads/main/John%20Doe"))()
end)

Feng:Button("FE脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sypcerr/FECollection/refs/heads/main/script.lua",true))()
end)

Feng:Button("FE百吨王",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6"))()
end)

Feng:Button("FE前后空翻动作", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%89%8D%E5%90%8E%E7%A9%BA%E7%BF%BB.txt"))()
end)

Feng:Button("FE巨人",function()
    _G.HideCharacter = true
_G.FlingEnabled = true
_G.TransparentRig = true
_G.ToolFling = false
_G.AntiFling = false
_G.CustomHats = true
_G.Scale = 4.2
_G.CH = {
    Torso = {
        Name= "Accessory (Torso)",
        TextureId = "83269599235494",
        Orientation= CFrame.new(0,0,0) * CFrame.Angles(math.rad(0),math.rad(0),math.rad(0))
    },
    RightArm = {
        Name= "Accessory (BIGGEST RIGHT ARMAccessory)",
        TextureId = "117484156735788", 
         Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    LeftArm = {
        Name= "Accessory (BIGGEST LEFT ARMAccessory)",
        TextureId = "117484156735788", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    RightLeg = {
        Name= "Accessory (RLeg)",
        TextureId = "83269599235494", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    LeftLeg = {
        Name= "Accessory (LLeg)",
        TextureId = "83269599235494", 
        Orientation= CFrame.Angles(math.rad(0),math.rad(90),math.rad(90))
    },
    Head = {
        Name = "Accessory (big head)",
        Orientation = CFrame.new(),
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nitro-GT/Oxide/refs/heads/main/LoadstringPerma"))()
task.wait(20)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Nitro-GT/OxideReanim/refs/heads/main/KrystalDance3"))()
end)

Feng:Button("FE地精",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_rTvXTs8F16D8D2oiLxZ62E1E9jT1we312yUyJr2h72Vwqr32l37rirU1S89hqRV7.lua.txt"))()
end)

Feng:Button("FE酷小孩",function()
    _G.Config = {
    ["HatCollide"]     = false,
    ["ReClaim"]        = true,
    ["Fling"]          = true,
    ["HideCharacter"]  = true,

    ["FlingOption"] = {
        ["HatFling"]        = false,
        ["Highlight"]       = true,
        ["PredictionFling"] = true,
        ["ToolFling"]       = false
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty2.lua"))()
end)

Feng:Button("FE滚球", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/unofficial-Projects/FEHamsterBall.lua"))()
end)

local FengYu = FY:Tab("〖假延迟】",'84830962019412')

local Feng = FengYu:section("〖在别人眼里以为你卡了※】",true)

local fakeLagEnabled = false
local fakeLagCoroutine = nil
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(newChar)
    char = newChar
end)

Feng:Toggle("慢移动/人物快速移动", "FengYu", false, function(state)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    local runAnimId = "rbxassetid://913376220"
    local runTrack = nil
    local runConnection = nil
    
    local function playRunAnimation(humanoid)
        local animator = humanoid:FindFirstChildWhichIsA("Animator")
        if not animator then
            animator = Instance.new("Animator", humanoid)
        end

        local runAnim = Instance.new("Animation")
        runAnim.AnimationId = runAnimId
        runTrack = animator:LoadAnimation(runAnim)
        runTrack.Priority = Enum.AnimationPriority.Movement
        runTrack:AdjustSpeed(6)
        runTrack:Play()

        runConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if humanoid.MoveDirection.Magnitude == 0 then
                if runTrack.IsPlaying then runTrack:Stop() end
            else
                if not runTrack.IsPlaying then
                    runTrack:Play()
                    runTrack:AdjustSpeed(6)
                end
            end
        end)
    end

    local function stopRunAnimation()
        if runTrack then runTrack:Stop() end
        if runConnection then runConnection:Disconnect() end
    end

    local function enableEgor()
        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end

        humanoid.WalkSpeed = 3
        playRunAnimation(humanoid)
    end

    local function disableEgor()
        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end

        humanoid.WalkSpeed = 16
        stopRunAnimation()
    end

    local function onCharacterAdded(char)
        local humanoid = char:WaitForChild("Humanoid")
        char:WaitForChild("Animate")
        task.wait(0.5)

        if state then
            enableEgor()
        else
            disableEgor()
        end
    end

    if state then
        if player.Character then
            onCharacterAdded(player.Character)
        end
        player.CharacterAdded:Connect(onCharacterAdded)
    else
        if player.Character then
            disableEgor()
        end
        player.CharacterAdded:Disconnect()
    end
end)
  
Feng:Toggle("假延迟开关", "FakeLagToggle", false, function(state)
    fakeLagEnabled = state
    
    if fakeLagEnabled then
        fakeLagCoroutine = coroutine.create(function()
            while fakeLagEnabled and char do
                if char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.Anchored = true
                    wait(fakeLagDelay or 2)
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Anchored = false
                    end
                end
                wait(0.05)
            end
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Anchored = false
            end
        end)
        coroutine.resume(fakeLagCoroutine)
    else
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Anchored = false
        end
    end
end)

local fakeLagDelay = 0.1
Feng:Textbox("假延迟延迟", "FengYu", "0.1", function(text)
    fakeLagDelay = tonumber(text) or 0.1
end)
local FY = window:card("音乐播放器", "请使用音乐ID", "133049870636628")

local FengYu = FY:Tab("〖音乐播放♫】",'84830962019412')

local Feng = FengYu:section("〖殺脚本音乐系统】",true)

local musicPlayer = Feng:MusicPlayer("播放列表", {
    {
        id = "115877769571526",
        title = "一路顺风",
        artist = "被遗弃",
        imageId = "116131795310461"
    },
    {
        id = "122671004690894",
        title = "🗿羽绒被",
        artist = "来原于哔哩哔哩一个视频",
        imageId = "120958598331824"
    },
    {
        id = "89967120507744",
        title = "天地旋转",
        artist = "三角符文改版",
        imageId = "115654494819611"
    },
    {
        id = "1839246711",
        title = "音响破坏机",
        artist = "战歌",
        imageId = "113169058130521"
    }
})

local currentMusicId = ""
Feng:Textbox("音乐ID", "MusicID", "输入音乐ID", function(text)
    currentMusicId = text
end)

local isPlaying = false
local currentSound = nil

local playToggle = Feng:Toggle("播放/暂停", "MusicPlayToggle", false, function(state)
    if state then
        if currentMusicId and currentMusicId ~= "" then
            if tonumber(currentMusicId) then
                if currentSound then
                    currentSound:Stop()
                    currentSound:Destroy()
                end
                
                currentSound = Instance.new("Sound")
                currentSound.SoundId = "rbxassetid://" .. currentMusicId
                currentSound.Volume = 0.5
                currentSound.Looped = false
                currentSound.Parent = game:GetService("SoundService")
                
                currentSound.Ended:Connect(function()
                    isPlaying = false
                    playToggle:SetState(false)
                end)
                
                currentSound:Play()
                isPlaying = true
                
                musicPlayer:ClearPlaylist()
                musicPlayer:AddTrack(currentMusicId, "自定义音乐", "未知艺术家", "87313406360181")
                musicPlayer:PlayTrack(currentMusicId)
            else
                playToggle:SetState(false)
            end
        else
            playToggle:SetState(false)
        end
    else
        if currentSound then
            currentSound:Stop()
            isPlaying = false
        end
    end
end)

local FY = window:card("光影设置", "类似于材质包", "110417460216040")

local FengYu = FY:Tab("〖光影】",'84830962019412')
local Feng = FengYu:section("『画质』", true)
Feng:Button(
        "画质光影",
        function()
            loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
        end
    )   
   
   Feng:Button(
        "深色光影",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
        end
    )
    
local FY = window:card("服务器功能", "根据对应的服务器来找到", "87032069041923")

local FengYu = FY:Tab("〖服务器功能】",'84830962019412')

local Feng =FengYu:section("〖其他脚本功能】",true)

local gameScripts = {
    [6331902150] = {
        {
            name = "SNT-被遗弃",
            url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/SNT.lua"
        },
        {
            name = "〖殺】被遗弃",
            url = "https://raw.githubusercontent.com/FengYu-3/function/refs/heads/Feng/forsaken.lua"
        }
    },
    [1526814825] = {
        name = "战争大亨",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.txt"
    },
    [8305240030] = {
        name = "成为乞丐",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/NEGA.lua"
    },
    [4777817887] = {
        name = "刀刃球",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Kalitor.lua"
    },
    [111958650] = {
        name = "兵工厂",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Tbao.lua"
    },
    [7326934954] = {
        name = "99夜",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/99%E5%A4%9C%E8%99%9A%E7%A9%BA.txt"
    },
    [5980808883] = {
        name = "活了七天",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/bf.txt"
    },
    [3085257211] = {
        name = "彩虹朋友2",
        url = "https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/BestRainbowFriendsTwo"
    },
    [65241] = {
        {
            name = "自然灾害",
            url = "https://raw.githubusercontent.com/9NLK7/93qjoadnlaknwldk/main/main"
        },
        {
            name = "〖殺】黑洞",
            url = "https://raw.githubusercontent.com/FengYu-3/function/refs/heads/Feng/%E9%BB%91%E6%B4%9E.lua"
        }
    },
    [1268927906] = {
        name = "力量传奇",
        url = "https://raw.githubusercontent.com/Anscripterato/QQ2134702438/refs/heads/main/byato/AnScript/atoscript"
    },
    [5308566453] = {
        name = "融合维度-技能无cd",
        url = "https://raw.githubusercontent.com/FengYu-3/function/refs/heads/Feng/%E7%BB%B4%E5%BA%A6%E8%9E%8D%E5%90%88%E5%85%A8%E6%8A%80%E8%83%BD%E6%97%A0cd.lua"
    },
    [2440500124] = {
        name = "doors",
        url = "https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/DOORS.lua"
    }
}

local currentGameId = game.GameId

if gameScripts[currentGameId] then
    if type(gameScripts[currentGameId]) == "table" and #gameScripts[currentGameId] > 0 then
        for _, scriptInfo in ipairs(gameScripts[currentGameId]) do
            Feng:Button(scriptInfo.name, function()
                loadstring(game:HttpGet(scriptInfo.url))()
            end)
        end
    else
        local scriptInfo = gameScripts[currentGameId]
        Feng:Button(scriptInfo.name, function()
            loadstring(game:HttpGet(scriptInfo.url))()
        end)
    end
else
    Feng:Label("当前服务器暂没可用的脚本")
    Feng:Label("请你去支持的服务器里使用")
    Feng:Label("作者：风御 X\n作者：单殺 X")
    Feng:Label("©-2025 殺脚本")
    Feng:Image("121036626410639", 150, 150)
end

local Feng =FengYu:section("〖依旧】",true)

Feng:Label("接下来会发生什么呢")
Feng:Image("140005402255916", 300, 190)

local AdminUsers = {
    "FengY3",
    ""
}

local isAdmin = false
for _, adminName in pairs(AdminUsers) do
    if string.lower(playerName) == string.lower(adminName) then
        isAdmin = true
        break
    end
end

if isAdmin then
local KFZ = window:card("开发者项目", "恭喜你你是开发者", "84830962019412")

local AdminTab = KFZ:Tab("★开发者模式", "rbxassetid://84830962019412")

local Feng = AdminTab:section("自用", true)

Feng:Button("控制NPC", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
end)

local Feng = AdminTab:section("脚本制作", true)

Feng:Label("游戏ID:"..tostring(game.GameId))

Feng:Button("复制游戏ID", function()
    setclipboard(tostring(game.GameId))
end)

Feng:Button("IY指令", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)
Feng:Label("IY指令输入：dex和rspy")

local AdminSection = AdminTab:section("黑名单管理", true)
    
AdminSection:Label("黑名单用户:")
    
for i, bannedUser in pairs(Blacklist.Users) do
    AdminSection:Label(bannedUser)
end
    
AdminSection:Textbox("添加用户到黑名单", "输入用户名", "用户名", function(newUser)
    if newUser and newUser ~= "" then
        table.insert(Blacklist.Users, newUser)
        print("玩家" .. newUser .. "已被登记")
    end
end)

end

-----("你好，恭喜你成功开源殺脚本")-----

-----("早就预料到了,恭喜你祝你天天开心")-----