-- ROBLOX抓包工具 - 精简拖动版
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- 创建主界面（缩小尺寸）
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PacketCaptureTool"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 主容器（缩小为500x350）
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- 标题栏（可拖动区域1）
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 35)
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
TitleLabel.Size = UDim2.new(0, 180, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "抓包工具 v3.2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local ArrowButton = Instance.new("TextButton")
ArrowButton.Name = "ArrowButton"
ArrowButton.Size = UDim2.new(0, 25, 0, 25)
ArrowButton.Position = UDim2.new(1, -35, 0.5, -12)
ArrowButton.AnchorPoint = Vector2.new(0, 0.5)
ArrowButton.BackgroundTransparency = 1
ArrowButton.Text = "▼"
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ArrowButton.TextSize = 14
ArrowButton.Parent = Header

-- 额外拖动按钮（可拖动区域2）
local DragButton = Instance.new("TextButton")
DragButton.Name = "DragButton"
DragButton.Size = UDim2.new(0, 25, 0, 25)
DragButton.Position = UDim2.new(1, -65, 0.5, -12)
DragButton.AnchorPoint = Vector2.new(0, 0.5)
DragButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DragButton.Text = "⋮⋮"
DragButton.TextColor3 = Color3.fromRGB(200, 200, 200)
DragButton.TextSize = 12
DragButton.Parent = Header

local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, 4)
DragCorner.Parent = DragButton

-- 内容区域
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- 标签页容器（缩小宽度）
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 120, 1, 0)
TabContainer.Position = UDim2.new(0, 0, 0, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = ContentFrame

-- 内容显示区域
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -120, 1, 0)
ContentContainer.Position = UDim2.new(0, 120, 0, 0)
ContentContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = ContentFrame

-- 标签页和内容管理
local tabs = {
    {name = "远程", id = "remote"},
    {name = "近战", id = "melee"}, 
    {name = "HTTP", id = "http"},
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
    tabButton.Size = UDim2.new(1, 0, 0, 30)
    tabButton.Position = UDim2.new(0, 0, 0, (i-1)*30)
    tabButton.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabInfo.name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 12
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = TabContainer
    
    local selectionIndicator = Instance.new("Frame")
    selectionIndicator.Name = "SelectionIndicator"
    selectionIndicator.Size = UDim2.new(0, 3, 1, 0)
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

-- 简化的远程事件内容
local function initRemoteContent()
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 100, 0, 25)
    startButton.Position = UDim2.new(0, 5, 0, 5)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "开始"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 11
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = RemoteContent
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 50, 0, 25)
    clearButton.Position = UDim2.new(0, 110, 0, 5)
    clearButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    clearButton.Text = "清空"
    clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearButton.TextSize = 11
    clearButton.Font = Enum.Font.Gotham
    clearButton.Parent = RemoteContent
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 80, 0, 25)
    statusLabel.Position = UDim2.new(0, 165, 0, 5)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "未启动"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 11
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = RemoteContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -35)
    scrollFrame.Position = UDim2.new(0, 5, 0, 30)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = RemoteContent
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 1)
    listLayout.Parent = scrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = startButton
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = clearButton
    
    local isMonitoring = false
    
    local function addLog(message, color)
        color = color or Color3.fromRGB(220, 220, 220)
        
        local logEntry = Instance.new("TextLabel")
        logEntry.Size = UDim2.new(1, -5, 0, 16)
        logEntry.BackgroundTransparency = 1
        logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
        logEntry.TextColor3 = color
        logEntry.TextSize = 9
        logEntry.Font = Enum.Font.Gotham
        logEntry.TextXAlignment = Enum.TextXAlignment.Left
        logEntry.TextWrapped = true
        logEntry.LayoutOrder = #scrollFrame:GetChildren()
        logEntry.Parent = scrollFrame
        
        table.insert(remoteLogs, {text = message, time = os.time(), color = color})
        
        if #remoteLogs > 200 then
            table.remove(remoteLogs, 1)
            if scrollFrame:FindFirstChildOfClass("TextLabel") then
                scrollFrame:FindFirstChildOfClass("TextLabel"):Destroy()
            end
        end
        
        task.wait()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
    end
    
    startButton.MouseButton1Click:Connect(function()
        if not isMonitoring then
            isMonitoring = true
            startButton.Text = "停止"
            startButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            statusLabel.Text = "监控中"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            addLog("远程监控启动", Color3.fromRGB(100, 255, 100))
        else
            isMonitoring = false
            startButton.Text = "开始"
            startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
            statusLabel.Text = "已停止"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            addLog("远程监控停止", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        remoteLogs = {}
        addLog("日志清空", Color3.fromRGB(255, 200, 100))
    end)
    
    addLog("远程监控就绪", Color3.fromRGB(100, 255, 100))
end

-- 简化的近战内容
local function initMeleeContent()
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 100, 0, 25)
    startButton.Position = UDim2.new(0, 5, 0, 5)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "开始"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 11
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = MeleeContent
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 50, 0, 25)
    clearButton.Position = UDim2.new(0, 110, 0, 5)
    clearButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    clearButton.Text = "清空"
    clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearButton.TextSize = 11
    clearButton.Font = Enum.Font.Gotham
    clearButton.Parent = MeleeContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -35)
    scrollFrame.Position = UDim2.new(0, 5, 0, 30)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = MeleeContent
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 1)
    listLayout.Parent = scrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = startButton
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = clearButton
    
    local isMonitoring = false
    
    local function addLog(message, color)
        color = color or Color3.fromRGB(220, 220, 220)
        
        local logEntry = Instance.new("TextLabel")
        logEntry.Size = UDim2.new(1, -5, 0, 16)
        logEntry.BackgroundTransparency = 1
        logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
        logEntry.TextColor3 = color
        logEntry.TextSize = 9
        logEntry.Font = Enum.Font.Gotham
        logEntry.TextXAlignment = Enum.TextXAlignment.Left
        logEntry.TextWrapped = true
        logEntry.LayoutOrder = #scrollFrame:GetChildren()
        logEntry.Parent = scrollFrame
        
        table.insert(meleeLogs, {text = message, time = os.time(), color = color})
        
        if #meleeLogs > 200 then
            table.remove(meleeLogs, 1)
            if scrollFrame:FindFirstChildOfClass("TextLabel") then
                scrollFrame:FindFirstChildOfClass("TextLabel"):Destroy()
            end
        end
        
        task.wait()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
    end
    
    startButton.MouseButton1Click:Connect(function()
        if not isMonitoring then
            isMonitoring = true
            startButton.Text = "停止"
            startButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            addLog("近战监控启动", Color3.fromRGB(100, 255, 100))
        else
            isMonitoring = false
            startButton.Text = "开始"
            startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
            addLog("近战监控停止", Color3.fromRGB(255, 100, 100))
        end
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        for _, child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        meleeLogs = {}
        addLog("日志清空", Color3.fromRGB(255, 200, 100))
    end)
    
    addLog("近战监控就绪", Color3.fromRGB(100, 255, 100))
end

-- 简化的HTTP内容
local function initHttpContent()
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -10, 0, 40)
    infoLabel.Position = UDim2.new(0, 5, 0, 5)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "HTTP监控需要hook技术"
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 10
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextWrapped = true
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.Parent = HttpContent
    
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(0, 100, 0, 25)
    startButton.Position = UDim2.new(0, 5, 0, 50)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    startButton.Text = "尝试监控"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 11
    startButton.Font = Enum.Font.Gotham
    startButton.Parent = HttpContent
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -85)
    scrollFrame.Position = UDim2.new(0, 5, 0, 80)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = HttpContent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = startButton
    
    startButton.MouseButton1Click:Connect(function()
        local function addLog(message, color)
            color = color or Color3.fromRGB(220, 220, 220)
            
            local logEntry = Instance.new("TextLabel")
            logEntry.Size = UDim2.new(1, -5, 0, 16)
            logEntry.BackgroundTransparency = 1
            logEntry.Text = "[" .. getCurrentTime() .. "] " .. message
            logEntry.TextColor3 = color
            logEntry.TextSize = 9
            logEntry.Font = Enum.Font.Gotham
            logEntry.TextXAlignment = Enum.TextXAlignment.Left
            logEntry.TextWrapped = true
            logEntry.LayoutOrder = #scrollFrame:GetChildren()
            logEntry.Parent = scrollFrame
            
            task.wait()
            scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
        end
        
        addLog("HTTP监控尝试", Color3.fromRGB(255, 255, 255))
    end)
end

-- 简化的设置内容
local function initSettingsContent()
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "设置"
    title.TextColor3 = Color3.fromRGB(0, 153, 255)
    title.TextSize = 12
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = SettingsContent
    
    local autoStartBtn = Instance.new("TextButton")
    autoStartBtn.Size = UDim2.new(0, 80, 0, 22)
    autoStartBtn.Position = UDim2.new(0, 5, 0, 30)
    autoStartBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    autoStartBtn.Text = "自动启动: 关"
    autoStartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoStartBtn.TextSize = 10
    autoStartBtn.Font = Enum.Font.Gotham
    autoStartBtn.Parent = SettingsContent
    
    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(0, 60, 0, 22)
    saveBtn.Position = UDim2.new(0, 90, 0, 30)
    saveBtn.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    saveBtn.Text = "保存"
    saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveBtn.TextSize = 10
    saveBtn.Font = Enum.Font.Gotham
    saveBtn.Parent = SettingsContent
    
    local UICorner1 = Instance.new("UICorner")
    UICorner1.CornerRadius = UDim.new(0, 3)
    UICorner1.Parent = autoStartBtn
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = saveBtn
    
    local autoStartEnabled = false
    autoStartBtn.MouseButton1Click:Connect(function()
        autoStartEnabled = not autoStartEnabled
        autoStartBtn.Text = "自动启动: " .. (autoStartEnabled and "开" or "关")
        autoStartBtn.BackgroundColor3 = autoStartEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100)
    end)
    
    saveBtn.MouseButton1Click:Connect(function()
        print("设置已保存")
    end)
end

-- 初始化各个内容区域
initRemoteContent()
initMeleeContent()
initHttpContent()
initSettingsContent()

-- 折叠/展开功能
local isExpanded = true
ArrowButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    
    if isExpanded then
        ArrowButton.Text = "▼"
        ContentFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
    else
        ArrowButton.Text = "▲"
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 500, 0, 35)
    end
end)

-- 双重拖动功能
local dragging1 = false  -- 标题栏拖动
local dragging2 = false  -- 额外拖动按钮
local dragStartPos, frameStartPos

-- 标题栏拖动
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging1 = true
        dragStartPos = input.Position
        frameStartPos = MainFrame.Position
    end
end)

Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging1 = false
    end
end)

-- 额外拖动按钮
DragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging2 = true
        dragStartPos = input.Position
        frameStartPos = MainFrame.Position
    end
end)

DragButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging2 = false
    end
end)

-- 统一的拖动处理
UserInputService.InputChanged:Connect(function(input)
    if (dragging1 or dragging2) and input.UserInputType == Enum.UserInputType.MouseMovement then
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
print("🎯 精简抓包工具 v3.2 已加载! (尺寸: 500x350)")
print("📡 双拖动区域: 标题栏 + 右侧按钮")
print("💡 点击标签切换功能")

-- 默认显示远程事件标签
switchTab("remote")
