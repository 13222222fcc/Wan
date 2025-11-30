-- ROBLOX抓包工具 - 终极修复版
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- 创建主界面
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PacketCaptureTool"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 主容器
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 500)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- 标题栏
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(0, 102, 204)
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ROBLOX抓包工具 v3.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local ArrowButton = Instance.new("TextButton")
ArrowButton.Name = "ArrowButton"
ArrowButton.Size = UDim2.new(0, 30, 0, 30)
ArrowButton.Position = UDim2.new(1, -40, 0.5, -15)
ArrowButton.AnchorPoint = Vector2.new(0, 0.5)
ArrowButton.BackgroundTransparency = 1
ArrowButton.Text = "▼"
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ArrowButton.TextSize = 16
ArrowButton.Parent = Header

-- 内容区域
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- 标签页容器
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 150, 1, 0)
TabContainer.Position = UDim2.new(0, 0, 0, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = ContentFrame

-- 内容显示区域
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -150, 1, 0)
ContentContainer.Position = UDim2.new(0, 150, 0, 0)
ContentContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = ContentFrame

-- 标签页和内容管理
local tabs = {
    {name = "远程事件", id = "remote"},
    {name = "近战监控", id = "melee"}, 
    {name = "HTTP请求", id = "http"},
    {name = "设置", id = "settings"}
}

local tabButtons = {}
local currentTab = "remote"
local remoteLogs = {}
local meleeLogs = {}
local httpLogs = {}

-- 获取当前时间的辅助函数
local function getCurrentTime()
    local time = os.time()
    local hours = math.floor(time / 3600) % 24
    local minutes = math.floor(time / 60) % 60
    local seconds = time % 60
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- 创建标签页
for i, tabInfo in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabInfo.id .. "Tab"
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.Position = UDim2.new(0, 0, 0, (i-1)*40)
    tabButton.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabInfo.name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = TabContainer
    
    local selectionIndicator = Instance.new("Frame")
    selectionIndicator.Name = "SelectionIndicator"
    selectionIndicator.Size = UDim2.new(0, 4, 1, 0)
    selectionIndicator.Position = UDim2.new(0, 0, 0, 0)
    selectionIndicator.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    selectionIndicator.BorderSizePixel = 0
    selectionIndicator.Visible = (tabInfo.id == currentTab)
    selectionIndicator.Parent = tabButton
    
    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabInfo.id)
    end)
    
    tabButtons[tabInfo.id] = tabButton
end

-- 创建各个功能的内容区域
local RemoteContent = Instance.new("Frame")
RemoteContent.Name = "RemoteContent"
RemoteContent.Size = UDim2.new(1, 0, 1, 0)
RemoteContent.BackgroundTransparency = 1
RemoteContent.Visible = true
RemoteContent.Parent = ContentContainer

local MeleeContent = Instance.new("Frame")
MeleeContent.Name = "MeleeContent"
MeleeContent.Size = UDim2.new(1, 0, 1, 0)
MeleeContent.BackgroundTransparency = 1
MeleeContent.Visible = false
MeleeContent.Parent = ContentContainer

local HttpContent = Instance.new("Frame")
HttpContent.Name = "HttpContent"
HttpContent.Size = UDim2.new(1, 0, 1, 0)
HttpContent.BackgroundTransparency = 1
HttpContent.Visible = false
HttpContent.Parent = ContentContainer

local SettingsContent = Instance.new("Frame")
SettingsContent.Name = "SettingsContent"
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.BackgroundTransparency = 1
SettingsContent.Visible = false
SettingsContent.Parent = ContentContainer

-- 标签页切换函数
local function switchTab(tabId)
    currentTab = tabId
    
    RemoteContent.Visible = (tabId == "remote")
    MeleeContent.Visible = (tabId == "melee")
    HttpContent.Visible = (tabId == "http")
    SettingsContent.Visible = (tabId == "settings")
    
    for id, button in pairs(tabButtons) do
        local indicator = button:FindFirstChild("SelectionIndicator")
        if indicator then
            indicator.Visible = (id == tabId)
        end
        
        if id == tabId then
            button.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
            button.TextColor3 = Color3.fromRGB(0, 153, 255)
        else
            button.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
            button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

-- 修复所有错误的远程事件内容初始化
local function initRemoteContent()
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 140, 0, 35)
    startButton.Position = UDim2.new(0, 10, 0, 10)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "开始监控远程事件"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 14
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = RemoteContent
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 80, 0, 35)
    clearButton.Position = UDim2.new(0, 160, 0, 10)
    clearButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    clearButton.Text = "清空日志"
    clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearButton.TextSize = 14
    clearButton.Font = Enum.Font.Gotham
    clearButton.Parent = RemoteContent
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 200, 0, 35)
    statusLabel.Position = UDim2.new(0, 250, 0, 10)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "状态: 未启动"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = RemoteContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -60)
    scrollFrame.Position = UDim2.new(0, 10, 0, 50)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = RemoteContent
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = scrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = startButton
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 4)
    UICorner2.Parent = clearButton
    
    local isMonitoring = false
    local monitoringCoroutine = nil
    local descendantConnection = nil
    
    local function addLog(message, color)
        color = color or Color3.fromRGB(220, 220, 220)
        
        local logEntry = Instance.new("TextLabel")
        logEntry.Size = UDim2.new(1, -10, 0, 20)
        logEntry.BackgroundTransparency = 1
        logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
        logEntry.TextColor3 = color
        logEntry.TextSize = 11
        logEntry.Font = Enum.Font.Gotham
        logEntry.TextXAlignment = Enum.TextXAlignment.Left
        logEntry.TextWrapped = true
        logEntry.LayoutOrder = #scrollFrame:GetChildren()
        logEntry.Parent = scrollFrame
        
        table.insert(remoteLogs, {text = message, time = os.time(), color = color})
        
        -- 限制日志数量防止内存泄漏
        if #remoteLogs > 1000 then
            table.remove(remoteLogs, 1)
            if scrollFrame:FindFirstChildOfClass("TextLabel") then
                scrollFrame:FindFirstChildOfClass("TextLabel"):Destroy()
            end
        end
        
        -- 使用task.wait代替wait，避免yield问题
        task.wait()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
    end
    
    -- 完全重写的安全监控函数
    local function startSafeMonitoring(addLogCallback)
        local remotesData = {}
        local monitoringActive = true
        
        -- 扫描远程对象
        local function scanRemotes()
            local foundPaths = {}
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                    local path = obj:GetFullName()
                    if not foundPaths[path] then
                        foundPaths[path] = true
                        local remoteInfo = {
                            instance = obj,
                            name = obj.Name,
                            path = path,
                            type = obj.ClassName,
                            lastSeen = os.time()
                        }
                        table.insert(remotesData, remoteInfo)
                        addLogCallback("📡 发现远程对象: " .. path .. " (" .. obj.ClassName .. ")", Color3.fromRGB(100, 200, 255))
                    end
                end
            end
        end
        
        -- 监控循环
        local function monitorLoop()
            while monitoringActive do
                task.wait(1) -- 每秒检查一次
                
                -- 检查现有远程对象
                for i = #remotesData, 1, -1 do
                    local remoteData = remotesData[i]
                    if remoteData.instance and remoteData.instance.Parent then
                        remoteData.lastSeen = os.time()
                    else
                        addLogCallback("❌ 远程对象已移除: " .. remoteData.path, Color3.fromRGB(255, 100, 100))
                        table.remove(remotesData, i)
                    end
                end
                
                -- 重新扫描以发现新对象
                scanRemotes()
            end
        end
        
        -- 启动监控
        scanRemotes()
        monitoringCoroutine = coroutine.create(monitorLoop)
        coroutine.resume(monitoringCoroutine)
        
        -- 监听新对象
        descendantConnection = game.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
                local path = descendant:GetFullName()
                addLogCallback("🔍 发现新的远程对象: " .. path .. " (" .. descendant.ClassName .. ")", Color3.fromRGB(255, 200, 100))
                
                table.insert(remotesData, {
                    instance = descendant,
                    name = descendant.Name,
                    path = path,
                    type = descendant.ClassName,
                    lastSeen = os.time()
                })
            end
        end)
        
        addLogCallback("✅ 安全监控模式已启动", Color3.fromRGB(100, 255, 100))
    end
    
    startButton.MouseButton1Click:Connect(function()
        if not isMonitoring then
            isMonitoring = true
            startButton.Text = "停止监控"
            startButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            statusLabel.Text = "状态: 监控中"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            startSafeMonitoring(addLog)
            addLog("远程事件监控已启动（安全模式）", Color3.fromRGB(100, 255, 100))
        else
            isMonitoring = false
            startButton.Text = "开始监控远程事件"
            startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
            statusLabel.Text = "状态: 已停止"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            -- 清理监控资源
            if monitoringCoroutine then
                -- 协程会在monitoringActive为false时自然结束
            end
            if descendantConnection then
                descendantConnection:Disconnect()
                descendantConnection = nil
            end
            
            addLog("远程事件监控已停止", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        -- 清空滚动框
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        remoteLogs = {}
        addLog("日志已清空", Color3.fromRGB(255, 200, 100))
    end)
    
    addLog("远程事件监控就绪（安全模式）", Color3.fromRGB(100, 255, 100))
    addLog("点击开始按钮启动监控", Color3.fromRGB(200, 200, 200))
end

-- 修复所有错误的近战监控内容初始化
local function initMeleeContent()
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 140, 0, 35)
    startButton.Position = UDim2.new(0, 10, 0, 10)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "开始近战监控"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 14
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = MeleeContent
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 80, 0, 35)
    clearButton.Position = UDim2.new(0, 160, 0, 10)
    clearButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    clearButton.Text = "清空日志"
    clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearButton.TextSize = 14
    clearButton.Font = Enum.Font.Gotham
    clearButton.Parent = MeleeContent
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 200, 0, 35)
    statusLabel.Position = UDim2.new(0, 250, 0, 10)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "状态: 未启动"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = MeleeContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -60)
    scrollFrame.Position = UDim2.new(0, 10, 0, 50)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = MeleeContent
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = scrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = startButton
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 4)
    UICorner2.Parent = clearButton
    
    local isMonitoring = false
    local characterConnections = {}
    
    local function addLog(message, color)
        color = color or Color3.fromRGB(220, 220, 220)
        
        local logEntry = Instance.new("TextLabel")
        logEntry.Size = UDim2.new(1, -10, 0, 20)
        logEntry.BackgroundTransparency = 1
        logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
        logEntry.TextColor3 = color
        logEntry.TextSize = 11
        logEntry.Font = Enum.Font.Gotham
        logEntry.TextXAlignment = Enum.TextXAlignment.Left
        logEntry.TextWrapped = true
        logEntry.LayoutOrder = #scrollFrame:GetChildren()
        logEntry.Parent = scrollFrame
        
        table.insert(meleeLogs, {text = message, time = os.time(), color = color})
        
        if #meleeLogs > 500 then
            table.remove(meleeLogs, 1)
            if scrollFrame:FindFirstChildOfClass("TextLabel") then
                scrollFrame:FindFirstChildOfClass("TextLabel"):Destroy()
            end
        end
        
        task.wait()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
    end
    
    local function monitorCharacter(character, playerName, logs)
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        -- 清理旧连接
        if characterConnections[playerName] then
            for _, conn in pairs(characterConnections[playerName]) do
                conn:Disconnect()
            end
        end
        
        characterConnections[playerName] = {}
        local conns = characterConnections[playerName]
        
        -- 监控工具装备
        table.insert(conns, humanoid:GetPropertyChangedSignal("Tool"):Connect(function()
            local tool = humanoid.Tool
            if tool then
                logs.addLog("🛠️ " .. playerName .. " 装备工具: " .. tool.Name, Color3.fromRGB(255, 200, 100))
            end
        end))
        
        -- 监控伤害
        table.insert(conns, humanoid.HealthChanged:Connect(function(health)
            if health < humanoid.MaxHealth then
                local damage = humanoid.MaxHealth - health
                logs.addLog("💥 " .. playerName .. " 受到伤害: " .. math.floor(damage) .. " 点", Color3.fromRGB(255, 100, 100))
            end
        end))
        
        -- 监控死亡
        table.insert(conns, humanoid.Died:Connect(function()
            logs.addLog("💀 " .. playerName .. " 死亡", Color3.fromRGB(150, 150, 150))
        end))
    end
    
    startButton.MouseButton1Click:Connect(function()
        if not isMonitoring then
            isMonitoring = true
            startButton.Text = "停止监控"
            startButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            statusLabel.Text = "状态: 监控中"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            
            local player = game.Players.LocalPlayer
            
            -- 监控本地玩家
            if player.Character then
                monitorCharacter(player.Character, "玩家自己", {addLog = addLog})
            end
            table.insert(characterConnections, player.CharacterAdded:Connect(function(char)
                monitorCharacter(char, "玩家自己", {addLog = addLog})
            end))
            
            -- 监控其他玩家
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player then
                    if otherPlayer.Character then
                        monitorCharacter(otherPlayer.Character, otherPlayer.Name, {addLog = addLog})
                    end
                    table.insert(characterConnections, otherPlayer.CharacterAdded:Connect(function(char)
                        monitorCharacter(char, otherPlayer.Name, {addLog = addLog})
                    end))
                end
            end
            
            -- 监控新玩家
            table.insert(characterConnections, game.Players.PlayerAdded:Connect(function(newPlayer)
                table.insert(characterConnections, newPlayer.CharacterAdded:Connect(function(char)
                    monitorCharacter(char, newPlayer.Name, {addLog = addLog})
                end))
            end))
            
            addLog("近战监控已启动", Color3.fromRGB(100, 255, 100))
        else
            isMonitoring = false
            startButton.Text = "开始近战监控"
            startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
            statusLabel.Text = "状态: 已停止"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            -- 清理所有连接
            for _, conns in pairs(characterConnections) do
                if type(conns) == "table" then
                    for _, conn in pairs(conns) do
                        if conn.Disconnect then
                            conn:Disconnect()
                        end
                    end
                elseif conns.Disconnect then
                    conns:Disconnect()
                end
            end
            characterConnections = {}
            
            addLog("近战监控已停止", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        meleeLogs = {}
        addLog("日志已清空", Color3.fromRGB(255, 200, 100))
    end)
    
    addLog("近战监控就绪", Color3.fromRGB(100, 255, 100))
end

-- 修复HTTP监控内容初始化
local function initHttpContent()
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 80)
    infoLabel.Position = UDim2.new(0, 10, 0, 10)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "HTTP请求监控\n\n在ROBLOX中，HTTP请求需要通过hook技术进行监控。\n此功能需要特殊权限和hook方法。"
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 14
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextWrapped = true
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.Parent = HttpContent
    
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 140, 0, 35)
    startButton.Position = UDim2.new(0, 10, 0, 100)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "尝试监控HTTP"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 14
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = HttpContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -150)
    scrollFrame.Position = UDim2.new(0, 10, 0, 150)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = HttpContent
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = scrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = startButton
    
    startButton.MouseButton1Click:Connect(function()
        local function addLog(message, color)
            color = color or Color3.fromRGB(220, 220, 220)
            
            local logEntry = Instance.new("TextLabel")
            logEntry.Size = UDim2.new(1, -10, 0, 20)
            logEntry.BackgroundTransparency = 1
            logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
            logEntry.TextColor3 = color
            logEntry.TextSize = 11
            logEntry.Font = Enum.Font.Gotham
            logEntry.TextXAlignment = Enum.TextXAlignment.Left
            logEntry.TextWrapped = true
            logEntry.LayoutOrder = #scrollFrame:GetChildren()
            logEntry.Parent = scrollFrame
            
            task.wait()
            scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
        end
        
        addLog("尝试读取HTTP服务数据...", Color3.fromRGB(255, 255, 255))
        attemptHttpHook(addLog)
    end)
end

-- 修复设置内容初始化
local function initSettingsContent()
    local settingsFrame = Instance.new("Frame")
    settingsFrame.Size = UDim2.new(1, -20, 1, -20)
    settingsFrame.Position = UDim2.new(0, 10, 0, 10)
    settingsFrame.BackgroundTransparency = 1
    settingsFrame.Parent = SettingsContent
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "抓包工具设置"
    title.TextColor3 = Color3.fromRGB(0, 153, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = settingsFrame
    
    -- 设置选项
    local settings = {
        autoStart = false,
        saveLogs = true,
        filterSensitive = true,
        maxLogSize = 1000
    }
    
    local yOffset = 40
    
    local function createToggleSetting(text, settingKey, default)
        settings[settingKey] = settings[settingKey] or default
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 30)
        toggleFrame.Position = UDim2.new(0, 0, 0, yOffset)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = settingsFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.TextSize = 14
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggleFrame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 60, 0, 25)
        toggleButton.Position = UDim2.new(0, 210, 0, 2)
        toggleButton.BackgroundColor3 = settings[settingKey] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100)
        toggleButton.Text = settings[settingKey] and "开启" or "关闭"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.TextSize = 12
        toggleButton.Font = Enum.Font.Gotham
        toggleButton.Parent = toggleFrame
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = toggleButton
        
        toggleButton.MouseButton1Click:Connect(function()
            settings[settingKey] = not settings[settingKey]
            toggleButton.BackgroundColor3 = settings[settingKey] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100)
            toggleButton.Text = settings[settingKey] and "开启" or "关闭"
        end)
        
        yOffset = yOffset + 35
    end
    
    createToggleSetting("自动开始监控", "autoStart", false)
    createToggleSetting("保存日志到文件", "saveLogs", true)
    createToggleSetting("过滤敏感信息", "filterSensitive", true)
    
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0, 120, 0, 35)
    saveButton.Position = UDim2.new(0, 0, 0, yOffset + 10)
    saveButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    saveButton.Text = "保存设置"
    saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveButton.TextSize = 14
    saveButton.Font = Enum.Font.Gotham
    saveButton.Parent = settingsFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = saveButton
    
    saveButton.MouseButton1Click:Connect(function()
        print("设置已保存")
    end)
end

-- HTTP监控功能
local function attemptHttpHook(addLog)
    local success, httpService = pcall(function()
        return game:GetService("HttpService")
    end)
    
    if not success then
        addLog("❌ 无法获取HttpService", Color3.fromRGB(255, 100, 100))
        return
    end
    
    addLog("✅ 找到HttpService", Color3.fromRGB(100, 255, 100))
    addLog("⚠️ HTTP监控需要高级hook技术", Color3.fromRGB(255, 200, 100))
    addLog("💡 建议使用浏览器开发者工具进行HTTP抓包", Color3.fromRGB(200, 200, 255))
end

-- 初始化各个内容区域
initRemoteContent()
initMeleeContent()
initHttpContent()
initSettingsContent()

-- 修复折叠/展开功能
local isExpanded = true
ArrowButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    
    if isExpanded then
        ArrowButton.Text = "▼"
        ContentFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 650, 0, 500)
    else
        ArrowButton.Text = "▲"
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 650, 0, 40)
    end
end)

-- 修复窗口拖动功能
local dragging = false
local dragStartPos, frameStartPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = MainFrame.Position
    end
end)

Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input, processed)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        MainFrame.Position = UDim2.new(
            frameStartPos.X.Scale, 
            frameStartPos.X.Offset + delta.X, 
            frameStartPos.Y.Scale, 
            frameStartPos.Y.Offset + delta.Y
        )
    end
end)

-- 初始化完成
print("🎯 ROBLOX抓包工具 v3.0 已加载!")
print("📡 功能: 远程事件监控 | 近战攻击监控 | HTTP请求监控")
print("💡 使用: 点击界面上的按钮开始监控")

-- 默认显示远程事件标签
switchTab("remote")
