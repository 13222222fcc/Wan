-- XA Hub Ultimate - 完整模块
-- 版本: 1.0.0
-- 包含：通用、透视、自瞄、范围、网络所有权、国内脚本、其他、动画区、音乐区

-- ============================================
-- 加载UI库
-- ============================================
local XA_UI = {
    Version = "1.0.0",
    Author = "XA Hub Team",
    GitHub = "https://github.com/XAHub/Roblox-Modules"
}

-- 服务
local Services = setmetatable({}, {
    __index = function(_, k)
        return game:GetService(k)
    end
})

local Players = Services.Players
local TweenService = Services.TweenService
local UserInputService = Services.UserInputService
local RunService = Services.RunService
local HttpService = Services.HttpService

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ============================================
-- 主题配置
-- ============================================
XA_UI.Themes = {
    Dark = {
        Background = Color3.fromRGB(28, 33, 55),
        Background2 = Color3.fromRGB(37, 43, 71),
        Primary = Color3.fromRGB(45, 45, 60),
        Secondary = Color3.fromRGB(60, 60, 80),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(100, 150, 255),
        Border = Color3.fromRGB(50, 50, 65),
        Success = Color3.fromRGB(85, 200, 100),
        Error = Color3.fromRGB(255, 95, 95)
    }
}

XA_UI.CurrentTheme = XA_UI.Themes.Dark

-- ============================================
-- 工具函数
-- ============================================
local Utilities = {}

function Utilities:Tween(obj, props, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad), props)
    tween:Play()
    return tween
end

function Utilities:Ripple(button)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, Mouse.X - button.AbsolutePosition.X, 0, Mouse.Y - button.AbsolutePosition.Y)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    Utilities:Tween(ripple, {
        Size = UDim2.new(0, 200, 0, 200),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, -100, 0.5, -100)
    }, 0.5)
    
    game:GetService("Debris"):AddItem(ripple, 0.5)
end

-- ============================================
-- 创建主窗口
-- ============================================
function XA_UI:CreateWindow()
    local Window = {}
    
    -- 创建GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XA_Hub_Main"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    
    -- 主框架
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 650, 0, 500)
    MainFrame.Position = UDim2.new(0.02, 0, 0.5, -250)
    MainFrame.BackgroundColor3 = self.CurrentTheme.Background
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = MainFrame
    
    -- 阴影
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5234388489"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = MainFrame
    
    -- 标题栏
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = self.CurrentTheme.Background2
    TitleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8, 0, 0)
    titleCorner.Parent = TitleBar
    
    -- 标题
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "XA Hub"
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 隐藏/打开按钮
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 80, 0, 25)
    ToggleButton.Position = UDim2.new(1, -90, 0.5, -12)
    ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
    ToggleButton.BackgroundColor3 = self.CurrentTheme.Primary
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = "隐藏/打开"
    ToggleButton.TextColor3 = self.CurrentTheme.Text
    ToggleButton.TextSize = 14
    ToggleButton.Font = Enum.Font.Gotham
    ToggleButton.AutoButtonColor = true
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = ToggleButton
    
    -- 左侧选项卡区域
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 150, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = self.CurrentTheme.Background2
    Sidebar.BorderSizePixel = 0
    
    -- 选项卡按钮容器
    local TabButtons = Instance.new("ScrollingFrame")
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(1, 0, 1, 0)
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.ScrollBarThickness = 0
    TabButtons.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- 右侧内容区域
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -150, 1, -35)
    ContentArea.Position = UDim2.new(0, 150, 0, 35)
    ContentArea.BackgroundTransparency = 1
    ContentArea.ClipsDescendants = true
    
    -- 存储数据
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- 拖拽功能
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- 隐藏/打开功能
    local isVisible = true
    ToggleButton.MouseButton1Click:Connect(function()
        isVisible = not isVisible
        if isVisible then
            MainFrame.Size = UDim2.new(0, 650, 0, 500)
            ToggleButton.Text = "隐藏"
        else
            MainFrame.Size = UDim2.new(0, 150, 0, 35)
            ToggleButton.Text = "打开"
        end
    end)
    
    -- 连接UI
    tabLayout.Parent = TabButtons
    TabButtons.Parent = Sidebar
    TitleLabel.Parent = TitleBar
    ToggleButton.Parent = TitleBar
    TitleBar.Parent = MainFrame
    Sidebar.Parent = MainFrame
    ContentArea.Parent = MainFrame
    MainFrame.Parent = ScreenGui
    
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Parent = PlayerGui
    
    Window.Gui = ScreenGui
    Window.MainFrame = MainFrame
    
    -- ============================================
    -- 窗口方法
    -- ============================================
    
    -- 添加选项卡
    function Window:AddTab(name)
        local Tab = {}
        
        -- 选项卡按钮
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "TabButton"
        TabButton.Size = UDim2.new(0.9, 0, 0, 40)
        TabButton.BackgroundColor3 = self.CurrentTheme.Primary
        TabButton.BackgroundTransparency = 0.1
        TabButton.Text = name
        TabButton.TextColor3 = self.CurrentTheme.Text
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.LayoutOrder = #self.Tabs + 1
        TabButton.AutoButtonColor = false
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = TabButton
        
        -- 选项卡内容
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = self.CurrentTheme.Accent
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Visible = false
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        -- 悬停效果
        TabButton.MouseEnter:Connect(function()
            if self.CurrentTab ~= Tab then
                TabButton.BackgroundColor3 = self.CurrentTheme.Accent
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if self.CurrentTab ~= Tab then
                TabButton.BackgroundColor3 = self.CurrentTheme.Primary
            end
        end)
        
        -- 点击切换到选项卡
        TabButton.MouseButton1Click:Connect(function()
            Utilities:Ripple(TabButton)
            
            if self.CurrentTab then
                self.CurrentTab.Button.BackgroundColor3 = self.CurrentTheme.Primary
                self.CurrentTab.Content.Visible = false
            end
            
            self.CurrentTab = Tab
            TabButton.BackgroundColor3 = self.CurrentTheme.Accent
            TabContent.Visible = true
        end)
        
        contentLayout.Parent = TabContent
        TabContent.Parent = ContentArea
        TabButton.Parent = TabButtons
        
        Tab.Name = name
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Sections = {}
        
        -- 如果是第一个选项卡，设置为当前
        if #self.Tabs == 0 then
            self.CurrentTab = Tab
            TabButton.BackgroundColor3 = self.CurrentTheme.Accent
            TabContent.Visible = true
        end
        
        table.insert(self.Tabs, Tab)
        
        -- ============================================
        -- 选项卡方法
        -- ============================================
        
        -- 添加功能区
        function Tab:AddSection(name)
            local Section = {}
            
            -- 功能区框架
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = name .. "Section"
            SectionFrame.Size = UDim2.new(0.95, 0, 0, 0)
            SectionFrame.BackgroundColor3 = self.CurrentTheme.Background2
            SectionFrame.BackgroundTransparency = 0.1
            SectionFrame.BorderSizePixel = 0
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 8)
            sectionCorner.Parent = SectionFrame
            
            -- 功能区标题
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Size = UDim2.new(1, -20, 0, 30)
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = "  " .. name
            SectionTitle.TextColor3 = self.CurrentTheme.Text
            SectionTitle.TextSize = 16
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            -- 内容容器
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Size = UDim2.new(1, -20, 0, 0)
            SectionContent.Position = UDim2.new(0, 10, 0, 35)
            SectionContent.BackgroundTransparency = 1
            
            local contentLayout = Instance.new("UIListLayout")
            contentLayout.Padding = UDim.new(0, 8)
            contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            -- 连接UI
            contentLayout.Parent = SectionContent
            SectionTitle.Parent = SectionFrame
            SectionContent.Parent = SectionFrame
            SectionFrame.Parent = TabContent
            
            -- 更新高度
            contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local height = contentLayout.AbsoluteContentSize.Y
                SectionContent.Size = UDim2.new(1, -20, 0, height)
                SectionFrame.Size = UDim2.new(0.95, 0, 0, height + 40)
            end)
            
            Section.Frame = SectionFrame
            Section.Content = SectionContent
            Section.Elements = {}
            
            table.insert(self.Sections, Section)
            
            -- ============================================
            -- 功能区方法
            -- ============================================
            
            -- 添加按钮
            function Section:AddButton(text, callback)
                local Button = Instance.new("TextButton")
                Button.Name = text .. "Button"
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.BackgroundColor3 = self.CurrentTheme.Primary
                Button.BackgroundTransparency = 0.1
                Button.Text = "  " .. text
                Button.TextColor3 = self.CurrentTheme.Text
                Button.TextSize = 14
                Button.Font = Enum.Font.Gotham
                Button.TextXAlignment = Enum.TextXAlignment.Left
                Button.AutoButtonColor = false
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 6)
                buttonCorner.Parent = Button
                
                -- 悬停效果
                Button.MouseEnter:Connect(function()
                    Button.BackgroundColor3 = self.CurrentTheme.Accent
                end)
                
                Button.MouseLeave:Connect(function()
                    Button.BackgroundColor3 = self.CurrentTheme.Primary
                end)
                
                -- 点击事件
                Button.MouseButton1Click:Connect(function()
                    Utilities:Ripple(Button)
                    if callback then callback() end
                end)
                
                Button.Parent = SectionContent
                table.insert(self.Elements, Button)
                return Button
            end
            
            -- 添加开关
            function Section:AddToggle(text, default, callback)
                local Toggle = {Value = default or false}
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = text .. "Toggle"
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                ToggleFrame.BackgroundTransparency = 1
                
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Size = UDim2.new(0.7, 0, 1, 0)
                Label.BackgroundTransparency = 1
                Label.Text = "  " .. text
                Label.TextColor3 = self.CurrentTheme.Text
                Label.TextSize = 14
                Label.Font = Enum.Font.Gotham
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "Toggle"
                ToggleButton.Size = UDim2.new(0, 50, 0, 25)
                ToggleButton.Position = UDim2.new(1, -10, 0.5, -12)
                ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
                ToggleButton.BackgroundColor3 = Toggle.Value and self.CurrentTheme.Accent or self.CurrentTheme.Primary
                ToggleButton.Text = ""
                ToggleButton.AutoButtonColor = false
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(0, 12)
                toggleCorner.Parent = ToggleButton
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "Circle"
                ToggleCircle.Size = UDim2.new(0, 21, 0, 21)
                ToggleCircle.Position = Toggle.Value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
                ToggleCircle.AnchorPoint = Vector2.new(0, 0.5)
                ToggleCircle.BackgroundColor3 = self.CurrentTheme.Text
                
                local circleCorner = Instance.new("UICorner")
                circleCorner.CornerRadius = UDim.new(1, 0)
                circleCorner.Parent = ToggleCircle
                
                -- 点击切换
                ToggleButton.MouseButton1Click:Connect(function()
                    Toggle.Value = not Toggle.Value
                    
                    Utilities:Tween(ToggleButton, {
                        BackgroundColor3 = Toggle.Value and self.CurrentTheme.Accent or self.CurrentTheme.Primary
                    })
                    
                    Utilities:Tween(ToggleCircle, {
                        Position = Toggle.Value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
                    })
                    
                    if callback then callback(Toggle.Value) end
                end)
                
                ToggleCircle.Parent = ToggleButton
                Label.Parent = ToggleFrame
                ToggleButton.Parent = ToggleFrame
                ToggleFrame.Parent = SectionContent
                
                table.insert(self.Elements, ToggleFrame)
                return Toggle
            end
            
            -- 添加滑块
            function Section:AddSlider(text, min, max, default, callback)
                local Slider = {Value = default or min}
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = text .. "Slider"
                SliderFrame.Size = UDim2.new(1, 0, 0, 60)
                SliderFrame.BackgroundTransparency = 1
                
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Size = UDim2.new(1, -20, 0, 20)
                Label.Position = UDim2.new(0, 10, 0, 5)
                Label.BackgroundTransparency = 1
                Label.Text = "  " .. text
                Label.TextColor3 = self.CurrentTheme.Text
                Label.TextSize = 14
                Label.Font = Enum.Font.Gotham
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Name = "Value"
                ValueLabel.Size = UDim2.new(0.3, 0, 0, 20)
                ValueLabel.Position = UDim2.new(0.7, 0, 0, 5)
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Text = tostring(default)
                ValueLabel.TextColor3 = self.CurrentTheme.Text2
                ValueLabel.TextSize = 14
                ValueLabel.Font = Enum.Font.Gotham
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "SliderBar"
                SliderBar.Size = UDim2.new(1, -20, 0, 8)
                SliderBar.Position = UDim2.new(0, 10, 0, 35)
                SliderBar.BackgroundColor3 = self.CurrentTheme.Primary
                
                local barCorner = Instance.new("UICorner")
                barCorner.CornerRadius = UDim.new(0, 4)
                barCorner.Parent = SliderBar
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "Fill"
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                SliderFill.BackgroundColor3 = self.CurrentTheme.Accent
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(0, 4)
                fillCorner.Parent = SliderFill
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Name = "SliderButton"
                SliderButton.Size = UDim2.new(0, 20, 0, 20)
                SliderButton.Position = UDim2.new(0, -10, 0.5, -10)
                SliderButton.AnchorPoint = Vector2.new(0, 0.5)
                SliderButton.BackgroundColor3 = self.CurrentTheme.Text
                SliderButton.Text = ""
                SliderButton.AutoButtonColor = false
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(1, 0)
                buttonCorner.Parent = SliderButton
                
                -- 更新值
                local function updateValue(value)
                    value = math.clamp(value, min, max)
                    Slider.Value = value
                    
                    local percent = (value - min) / (max - min)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderButton.Position = UDim2.new(percent, -10, 0.5, -10)
                    ValueLabel.Text = tostring(value)
                    
                    if callback then callback(value) end
                end
                
                -- 拖动功能
                local dragging = false
                
                SliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                SliderBar.MouseButton1Down:Connect(function()
                    dragging = true
                    local mouseX = UserInputService:GetMouseLocation().X
                    local barX = SliderBar.AbsolutePosition.X
                    local barWidth = SliderBar.AbsoluteSize.X
                    local percent = math.clamp((mouseX - barX) / barWidth, 0, 1)
                    updateValue(min + (max - min) * percent)
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mouseX = UserInputService:GetMouseLocation().X
                        local barX = SliderBar.AbsolutePosition.X
                        local barWidth = SliderBar.AbsoluteSize.X
                        local percent = math.clamp((mouseX - barX) / barWidth, 0, 1)
                        updateValue(min + (max - min) * percent)
                    end
                end)
                
                -- 初始化
                updateValue(default)
                
                SliderFill.Parent = SliderBar
                SliderButton.Parent = SliderBar
                Label.Parent = SliderFrame
                ValueLabel.Parent = SliderFrame
                SliderBar.Parent = SliderFrame
                SliderFrame.Parent = SectionContent
                
                table.insert(self.Elements, SliderFrame)
                return Slider
            end
            
            -- 添加文本框
            function Section:AddTextBox(placeholder, default, callback)
                local TextBoxFrame = Instance.new("Frame")
                TextBoxFrame.Name = placeholder .. "TextBox"
                TextBoxFrame.Size = UDim2.new(1, 0, 0, 35)
                TextBoxFrame.BackgroundColor3 = self.CurrentTheme.Primary
                TextBoxFrame.BackgroundTransparency = 0.1
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 6)
                frameCorner.Parent = TextBoxFrame
                
                local TextBox = Instance.new("TextBox")
                TextBox.Name = "Input"
                TextBox.Size = UDim2.new(1, -20, 1, -10)
                TextBox.Position = UDim2.new(0, 10, 0, 5)
                TextBox.BackgroundTransparency = 1
                TextBox.Text = default or ""
                TextBox.PlaceholderText = placeholder
                TextBox.TextColor3 = self.CurrentTheme.Text
                TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                TextBox.TextSize = 14
                TextBox.Font = Enum.Font.Gotham
                TextBox.ClearTextOnFocus = false
                
                TextBox.FocusLost:Connect(function()
                    if callback then callback(TextBox.Text) end
                end)
                
                TextBox.Parent = TextBoxFrame
                TextBoxFrame.Parent = SectionContent
                
                table.insert(self.Elements, TextBoxFrame)
                return TextBox
            end
            
            -- 添加标签
            function Section:AddLabel(text)
                local Label = Instance.new("TextLabel")
                Label.Name = text .. "Label"
                Label.Size = UDim2.new(1, 0, 0, 25)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = self.CurrentTheme.Text
                Label.TextSize = 14
                Label.Font = Enum.Font.Gotham
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                Label.Parent = SectionContent
                table.insert(self.Elements, Label)
                return Label
            end
            
            return Section
        end
        
        return Tab
    end
    
    -- 销毁窗口
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    -- 隐藏窗口
    function Window:Hide()
        MainFrame.Visible = false
    end
    
    -- 显示窗口
    function Window:Show()
        MainFrame.Visible = true
    end
    
    return Window
end

-- ============================================
-- 创建完整模块
-- ============================================
function XA_UI:CreateFullModule()
    local Window = self:CreateWindow()
    
    -- 添加所有选项卡（按照图片中的顺序）
    local GeneralTab = Window:AddTab("通用")
    local VisualTab = Window:AddTab("透视")
    local AimTab = Window:AddTab("自瞄")
    local RangeTab = Window:AddTab("范围")
    local NetworkTab = Window:AddTab("网络所有权")
    local ChinaTab = Window:AddTab("国内脚本")
    local OtherTab = Window:AddTab("其他")
    local AnimTab = Window:AddTab("动画区")
    local MusicTab = Window:AddTab("音乐区")
    local InfoTab = Window:AddTab("信息")
    local LocalTab = Window:AddTab("本地玩家")
    local UtilityTab = Window:AddTab("实用")
    local TriggerTab = Window:AddTab("触发类")
    
    -- ============================================
    -- 通用选项卡
    -- ============================================
    local GeneralSettings = GeneralTab:AddSection("通用设置")
    GeneralSettings:AddButton("飞行模式", function()
        print("飞行模式已切换")
    end)
    
    GeneralSettings:AddButton("穿墙模式", function()
        print("穿墙模式已切换")
    end)
    
    GeneralSettings:AddButton("上帝模式", function()
        print("上帝模式已切换")
    end)
    
    GeneralSettings:AddToggle("无限跳跃", false, function(state)
        print("无限跳跃:", state)
    end)
    
    GeneralSettings:AddToggle("速度提升", false, function(state)
        print("速度提升:", state)
    end)
    
    GeneralSettings:AddSlider("移动速度", 1, 5, 1, function(value)
        print("移动速度:", value)
    end)
    
    -- ============================================
    -- 透视选项卡
    -- ============================================
    local ESPMain = VisualTab:AddSection("ESP主要设置")
    ESPMain:AddToggle("启用ESP", true, function(state)
        print("ESP:", state)
    end)
    
    ESPMain:AddSlider("最大距离", 0, 500, 100, function(value)
        print("ESP距离:", value)
    end)
    
    ESPMain:AddToggle("方框透视", true, function(state)
        print("方框:", state)
    end)
    
    ESPMain:AddToggle("名字显示", true, function(state)
        print("名字:", state)
    end)
    
    ESPMain:AddToggle("血量显示", true, function(state)
        print("血量:", state)
    end)
    
    ESPMain:AddToggle("距离显示", false, function(state)
        print("距离:", state)
    end)
    
    ESPMain:AddToggle("武器显示", false, function(state)
        print("武器:", state)
    end)
    
    local ChamsSettings = VisualTab:AddSection("透视材质")
    ChamsSettings:AddToggle("透视材质", false, function(state)
        print("透视材质:", state)
    end)
    
    ChamsSettings:AddToggle("发光效果", true, function(state)
        print("发光效果:", state)
    end)
    
    ChamsSettings:AddButton("刷新材质", function()
        print("材质已刷新")
    end)
    
    -- ============================================
    -- 自瞄选项卡
    -- ============================================
    local AimSettings = AimTab:AddSection("自瞄设置")
    AimSettings:AddToggle("启用自瞄", false, function(state)
        print("自瞄:", state)
    end)
    
    AimSettings:AddSlider("自瞄范围", 0, 100, 50, function(value)
        print("自瞄范围:", value)
    end)
    
    AimSettings:AddSlider("平滑度", 0, 10, 3, function(value)
        print("平滑度:", value)
    end)
    
    AimSettings:AddToggle("预判瞄准", true, function(state)
        print("预判:", state)
    end)
    
    AimSettings:AddToggle("忽略队友", true, function(state)
        print("忽略队友:", state)
    end)
    
    AimSettings:AddToggle("可见性检查", true, function(state)
        print("可见性检查:", state)
    end)
    
    AimSettings:AddButton("选择目标", function()
        print("选择目标")
    end)
    
    -- ============================================
    -- 范围选项卡
    -- ============================================
    local RangeSettings = RangeTab:AddSection("范围设置")
    RangeSettings:AddSlider("攻击范围", 1, 50, 10, function(value)
        print("攻击范围:", value)
    end)
    
    RangeSettings:AddSlider("拾取范围", 1, 100, 20, function(value)
        print("拾取范围:", value)
    end)
    
    RangeSettings:AddSlider("交互范围", 1, 30, 5, function(value)
        print("交互范围:", value)
    end)
    
    RangeSettings:AddToggle("自动拾取", false, function(state)
        print("自动拾取:", state)
    end)
    
    -- ============================================
    -- 网络所有权选项卡
    -- ============================================
    local NetworkSettings = NetworkTab:AddSection("网络设置")
    NetworkSettings:AddToggle("网络优化", true, function(state)
        print("网络优化:", state)
    end)
    
    NetworkSettings:AddToggle("降低延迟", true, function(state)
        print("降低延迟:", state)
    end)
    
    NetworkSettings:AddToggle("防掉线", false, function(state)
        print("防掉线:", state)
    end)
    
    NetworkSettings:AddButton("测试连接", function()
        print("测试连接")
    end)
    
    -- ============================================
    -- 国内脚本选项卡
    -- ============================================
    local ChinaScripts = ChinaTab:AddSection("脚本列表")
    ChinaScripts:AddButton("加载脚本1", function()
        print("加载脚本1")
    end)
    
    ChinaScripts:AddButton("加载脚本2", function()
        print("加载脚本2")
    end)
    
    ChinaScripts:AddButton("加载脚本3", function()
        print("加载脚本3")
    end)
    
    ChinaScripts:AddButton("刷新列表", function()
        print("刷新列表")
    end)
    
    -- ============================================
    -- 其他选项卡
    -- ============================================
    local OtherSettings = OtherTab:AddSection("其他功能")
    OtherSettings:AddButton("截图功能", function()
        print("截图")
    end)
    
    OtherSettings:AddButton("录像功能", function()
        print("录像")
    end)
    
    OtherSettings:AddToggle("自动任务", false, function(state)
        print("自动任务:", state)
    end)
    
    OtherSettings:AddToggle("自动战斗", false, function(state)
        print("自动战斗:", state)
    end)
    
    -- ============================================
    -- 动画区选项卡
    -- ============================================
    local Animations = AnimTab:AddSection("动画列表")
    Animations:AddButton("胜利动画", function()
        print("播放胜利动画")
    end)
    
    Animations:AddButton("舞蹈动画", function()
        print("播放舞蹈动画")
    end)
    
    Animations:AddButton("表情动画", function()
        print("播放表情动画")
    end)
    
    Animations:AddSlider("动画速度", 0.5, 2, 1, function(value)
        print("动画速度:", value)
    end)
    
    -- ============================================
    -- 音乐区选项卡
    -- ============================================
    local MusicPlayer = MusicTab:AddSection("音乐播放器")
    MusicPlayer:AddButton("播放音乐", function()
        print("播放音乐")
    end)
    
    MusicPlayer:AddButton("停止音乐", function()
        print("停止音乐")
    end)
    
    MusicPlayer:AddButton("下一曲", function()
        print("下一曲")
    end)
    
    MusicPlayer:AddSlider("音量", 0, 100, 50, function(value)
        print("音量:", value)
    end)
    
    MusicPlayer:AddToggle("循环播放", true, function(state)
        print("循环:", state)
    end)
    
    -- ============================================
    -- 信息选项卡（包含玩家选择框）
    -- ============================================
    local PlayerInfo = InfoTab:AddSection("玩家信息")
    
    -- 玩家选择文本框
    local playerTextBox = PlayerInfo:AddTextBox("选择玩家", "[ 选择玩家 ]", function(text)
        print("选择的玩家:", text)
    end)
    
    PlayerInfo:AddButton("刷新列表", function()
        print("刷新玩家列表")
    end)
    
    PlayerInfo:AddLabel("当前玩家: " .. LocalPlayer.Name)
    PlayerInfo:AddLabel("玩家数量: " .. #Players:GetPlayers())
    PlayerInfo:AddLabel("游戏时间: 0:00")
    
    -- ============================================
    -- 本地玩家选项卡
    -- ============================================
    local LocalSettings = LocalTab:AddSection("本地设置")
    LocalSettings:AddSlider("视野范围", 70, 120, 80, function(value)
        print("视野范围:", value)
    end)
    
    LocalSettings:AddToggle("第三人称", false, function(state)
        print("第三人称:", state)
    end)
    
    LocalSettings:AddToggle("隐藏界面", false, function(state)
        print("隐藏界面:", state)
    end)
    
    LocalSettings:AddButton("重置设置", function()
        print("重置本地设置")
    end)
    
    -- ============================================
    -- 实用选项卡
    -- ============================================
    local UtilityTools = UtilityTab:AddSection("实用工具")
    UtilityTools:AddButton("传送菜单", function()
        print("打开传送菜单")
    end)
    
    UtilityTools:AddButton("物品生成", function()
        print("打开物品生成")
    end)
    
    UtilityTools:AddButton("坐标保存", function()
        print("保存坐标")
    end)
    
    UtilityTools:AddToggle("自动完成任务", false, function(state)
        print("自动任务:", state)
    end)
    
    -- ============================================
    -- 触发类选项卡
    -- ============================================
    local Triggers = TriggerTab:AddSection("触发器")
    Triggers:AddToggle("自动点击", false, function(state)
        print("自动点击:", state)
    end)
    
    Triggers:AddToggle("自动对话", false, function(state)
        print("自动对话:", state)
    end)
    
    Triggers:AddToggle("自动交互", false, function(state)
        print("自动交互:", state)
    end)
    
    Triggers:AddSlider("触发间隔", 0.1, 5, 1, function(value)
        print("触发间隔:", value)
    end)
    
    Triggers:AddButton("测试触发器", function()
        print("测试触发器")
    end)
    
    -- ============================================
    -- 返回完整模块
    -- ============================================
    local Module = {}
    
    function Module:GetWindow()
        return Window
    end
    
    function Module:Show()
        Window:Show()
    end
    
    function Module:Hide()
        Window:Hide()
    end
    
    function Module:Destroy()
        Window:Destroy()
    end
    
    function Module:Toggle()
        if Window.MainFrame.Visible then
            Window:Hide()
        else
            Window:Show()
        end
    end
    
    -- 添加按键绑定（右Ctrl键切换）
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            Module:Toggle()
        end
    end)
    
    print("XA Hub 模块已加载完成!")
    print("包含以下选项卡:")
    print("1. 通用 - 飞行、穿墙、上帝模式等")
    print("2. 透视 - ESP、透视材质等")
    print("3. 自瞄 - 瞄准辅助功能")
    print("4. 范围 - 攻击、拾取范围")
    print("5. 网络所有权 - 网络优化")
    print("6. 国内脚本 - 内置脚本")
    print("7. 其他 - 额外功能")
    print("8. 动画区 - 动画播放")
    print("9. 音乐区 - 音乐播放器")
    print("10. 信息 - 玩家信息")
    print("11. 本地玩家 - 本地设置")
    print("12. 实用 - 工具集")
    print("13. 触发类 - 自动化触发器")
    print("")
    print("使用方法:")
    print("- 点击标题栏拖拽窗口")
    print("- 点击'隐藏/打开'按钮折叠侧边栏")
    print("- 按右Ctrl键切换显示/隐藏")
    print("- 每个选项卡包含相关功能")
    
    return Module
end

-- ============================================
-- 导出模块
-- ============================================
return XA_UI
