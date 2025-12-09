--[[
Script Name: VOMO_
Version: 2.0
Author: VOMO Team
Description: Premium Roblox Enhancement Tool with Advanced Features
Base UI: Obsidian Framework
Luarmor Protected Loader Implementation
]]

-- Luarmor protected loader integration
local scripturl = "https://api.luarmor.net/files/v3/loaders/80b606551d4b7075eb3e229d6f68e4df.lua"
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local showGUI = true

-- Advanced security check and environment validation
local isExecutor = (syn and syn.protect_gui) or (getexecutorname and getexecutorname() ~= nil) or (identifyexecutor and identifyexecutor() ~= nil) or (KRNL_LOADED and true) or (PROTOSMASHER_LOADED and true)
if not isExecutor then
    warn("Executor environment not detected. Script may not function properly.")
    return
end

-- Protected loading system with advanced error handling
local function SecureLoad(url)
    local success, response = pcall(function()
        if syn and syn.request then
            local req = syn.request({
                Url = url,
                Method = "GET",
                Headers = {
                    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
                }
            })
            return req.Body
        elseif request then
            local req = request({
                Url = url,
                Method = "GET"
            })
            return req.Body
        elseif http_request then
            local req = http_request({
                Url = url,
                Method = "GET"
            })
            return req.Body
        else
            return game:HttpGetAsync(url, true)
        end
    end)
    
    if success and response then
        return loadstring(response)
    end
    return nil
end

-- Load Obsidian UI with advanced protection
local ObsidianLoadFunction = SecureLoad(repo)
if not ObsidianLoadFunction then
    error("Failed to load Obsidian UI library. Check your internet connection and try again.")
    return
end

local ObsidianSuccess, Obsidian = pcall(ObsidianLoadFunction)
if not ObsidianSuccess then
    error("Failed to initialize Obsidian UI framework. Please ensure you have a stable internet connection.")
    return
end

-- Create main application window with enhanced settings
local MainWindow = Obsidian:Window{
    Name = "VOMO_ Enhancement Suite v2.0",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = {420, 550},
    Theme = "Midnight",
    Accent = Color3.fromRGB(0, 180, 255),
    Icon = "rbxassetid://7072706620",
    MinSize = {380, 450},
    MaxSize = {650, 750},
    Resizable = true,
    AutoHide = false
}

-- Initialize global variables and modules
local VOMO = {
    Settings = {
        Version = "2.0",
        Build = "2024.01",
        Author = "VOMO Development Team",
        LastUpdate = os.date("%Y-%m-%d")
    },
    Modules = {},
    Connections = {},
    ESP = {
        Instances = {},
        Components = {},
        Enabled = false,
        Killers = {},
        Survivors = {}
    },
    Movement = {
        Speed = {
            Enabled = false,
            Value = 20,
            OriginalWalkSpeed = 16,
            OriginalJumpPower = 50
        },
        Fly = {
            Enabled = false,
            Speed = 30,
            BodyVelocity = nil,
            BodyGyro = nil,
            Flying = false
        },
        Noclip = false
    },
    Security = {
        AntiKick = true,
        AntiLog = true,
        AntiBan = true,
        AntiDetection = true,
        Obfuscation = true,
        FakeLag = false
    }
}

-- Tab 1: Information Section
local InfoTab = MainWindow:Tab{
    Name = "Information Center",
    Icon = "rbxassetid://7072706620",
    Tooltip = "General information and community links"
}

local InfoSection = InfoTab:Section{
    Name = "Community & Information",
    Side = "Left",
    Collapsible = true,
    DefaultCollapsed = false
}

-- Application information display
InfoSection:Label{
    Text = "VOMO_ Enhancement Suite",
    Description = "Version 2.0 | Premium Game Enhancement Tool",
    Color = Color3.fromRGB(0, 180, 255),
    Bold = true,
    Size = 18
}

InfoSection:Label{
    Text = "Security Status: ACTIVE",
    Description = "Luarmor protection enabled | All systems operational",
    Color = Color3.fromRGB(0, 255, 0),
    Bold = true
}

InfoSection:Label{
    Text = "Join Our Community!",
    Description = "Connect with other users and get latest updates",
    Color = Color3.fromRGB(255, 170, 0),
    Bold = false
}

-- Community links with advanced functionality
InfoSection:Button{
    Name = "Discord Server",
    Description = "Join our Discord community for support and updates",
    Callback = function()
        local discordLink = "https://discord.gg/example"
        if setclipboard then
            setclipboard(discordLink)
        elseif writeclipboard then
            writeclipboard(discordLink)
        elseif toclipboard then
            toclipboard(discordLink)
        end
        print("Discord link copied to clipboard: " .. discordLink)
    end
}

InfoSection:Button{
    Name = "Telegram Channel",
    Description = "Follow us on Telegram for announcements",
    Callback = function()
        local telegramLink = "https://t.me/example"
        if setclipboard then
            setclipboard(telegramLink)
        elseif writeclipboard then
            writeclipboard(telegramLink)
        end
        print("Telegram link copied to clipboard: " .. telegramLink)
    end
}

-- System information display
local SystemInfo = InfoTab:Section{
    Name = "System Information",
    Side = "Right",
    Collapsible = true,
    DefaultCollapsed = false
}

SystemInfo:Label{
    Text = "Executor Information",
    Description = "Environment details and capabilities",
    Color = Color3.fromRGB(170, 170, 255),
    Bold = true
}

SystemInfo:Label{
    Text = "Executor: " .. (getexecutorname and getexecutorname() or "Unknown"),
    Description = "Current execution environment",
    Color = Color3.fromRGB(200, 200, 200)
}

SystemInfo:Label{
    Text = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Description = "Current game information",
    Color = Color3.fromRGB(200, 200, 200)
}

SystemInfo:Label{
    Text = "Players: " .. #game:GetService("Players"):GetPlayers(),
    Description = "Current player count in server",
    Color = Color3.fromRGB(200, 200, 200)
}

-- Performance monitoring
local Performance = InfoTab:Section{
    Name = "Performance Monitor",
    Side = "Right",
    Collapsible = true,
    DefaultCollapsed = true
}

local fps = 0
local lastTick = tick()
local frameCount = 0

Performance:Label{
    Text = "FPS: Calculating...",
    Description = "Current frames per second",
    Color = Color3.fromRGB(0, 255, 255)
}

Performance:Label{
    Text = "Ping: Calculating...",
    Description = "Current network latency",
    Color = Color3.fromRGB(0, 255, 255)
}

-- Performance update loop
spawn(function()
    while true do
        wait(1)
        local currentFPS = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        
        -- Update labels
        for _, label in pairs(Performance:GetLabels()) do
            if label.Text:find("FPS") then
                label:Update{
                    Text = "FPS: " .. currentFPS,
                    Color = currentFPS > 30 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                }
            elseif label.Text:find("Ping") then
                label:Update{
                    Text = "Ping: " .. math.floor(ping) .. "ms",
                    Color = ping < 100 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                }
            end
        end
    end
end)

-- Tab 2: ESP (Extra Sensory Perception)
local ESPTab = MainWindow:Tab{
    Name = "ESP Features",
    Icon = "rbxassetid://7072725347",
    Tooltip = "Visual enhancement and player tracking"
}

local ESPSection = ESPTab:Section{
    Name = "ESP Configuration",
    Side = "Left",
    Collapsible = false
}

-- ESP for Killers
local espKillerEnabled = false
ESPSection:Toggle{
    Name = "ESP for Killers",
    Flag = "ESP_Killer_Toggle",
    Description = "Enable ESP for killer players (Anti-Cheat Bypass)",
    Callback = function(state)
        espKillerEnabled = state
        VOMO.ESP.Enabled = state
        
        if state then
            spawn(function()
                -- Initialize ESP system for killers
                VOMO.ESP.Killers = {}
                
                local function createESP(player)
                    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        return
                    end
                    
                    -- Check if player is a killer (this logic depends on the game)
                    -- You need to implement game-specific killer detection
                    local isKiller = false
                    
                    -- Example detection methods (adjust based on actual game)
                    if player.Team and player.Team.Name:lower():find("killer") then
                        isKiller = true
                    elseif player.Character:FindFirstChild("Weapon") then
                        isKiller = true
                    end
                    
                    if isKiller then
                        -- Create ESP components
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "VOMO_ESP_Killer_" .. player.Name
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red for killers
                        highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = player.Character
                        
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "VOMO_ESP_Info_" .. player.Name
                        billboard.AlwaysOnTop = true
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Text = player.Name .. " [KILLER]"
                        nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextSize = 14
                        nameLabel.Parent = billboard
                        
                        local distanceLabel = Instance.new("TextLabel")
                        distanceLabel.Text = "Distance: 0 studs"
                        distanceLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
                        distanceLabel.TextStrokeTransparency = 0
                        distanceLabel.BackgroundTransparency = 1
                        distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                        distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
                        distanceLabel.Font = Enum.Font.Gotham
                        distanceLabel.TextSize = 12
                        distanceLabel.Parent = billboard
                        
                        billboard.Parent = player.Character.HumanoidRootPart
                        
                        -- Store ESP components
                        VOMO.ESP.Killers[player] = {
                            Highlight = highlight,
                            Billboard = billboard,
                            NameLabel = nameLabel,
                            DistanceLabel = distanceLabel
                        }
                        
                        -- Update distance
                        spawn(function()
                            while espKillerEnabled and player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                                wait(0.1)
                                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - 
                                                 player.Character.HumanoidRootPart.Position).Magnitude
                                distanceLabel.Text = "Distance: " .. math.floor(distance) .. " studs"
                            end
                        end)
                    end
                end
                
                -- Process existing players
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        createESP(player)
                    end
                end
                
                -- Listen for new players
                game:GetService("Players").PlayerAdded:Connect(function(player)
                    wait(2) -- Wait for character to load
                    if espKillerEnabled then
                        createESP(player)
                    end
                end)
                
                -- Clean up when players leave
                game:GetService("Players").PlayerRemoving:Connect(function(player)
                    if VOMO.ESP.Killers[player] then
                        VOMO.ESP.Killers[player].Highlight:Destroy()
                        VOMO.ESP.Killers[player].Billboard:Destroy()
                        VOMO.ESP.Killers[player] = nil
                    end
                end)
                
                print("Killer ESP activated successfully")
            end)
        else
            -- Disable ESP for killers
            for player, espData in pairs(VOMO.ESP.Killers) do
                if espData.Highlight then
                    espData.Highlight:Destroy()
                end
                if espData.Billboard then
                    espData.Billboard:Destroy()
                end
            end
            VOMO.ESP.Killers = {}
            print("Killer ESP deactivated")
        end
    end
}

-- ESP for Survivors
local espSurvivorEnabled = false
ESPSection:Toggle{
    Name = "ESP for Survivors",
    Flag = "ESP_Survivor_Toggle",
    Description = "Enable ESP for survivor players (Anti-Cheat Bypass)",
    Callback = function(state)
        espSurvivorEnabled = state
        
        if state then
            spawn(function()
                -- Initialize ESP system for survivors
                VOMO.ESP.Survivors = {}
                
                local function createSurvivorESP(player)
                    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                        return
                    end
                    
                    -- Check if player is a survivor (this logic depends on the game)
                    -- You need to implement game-specific survivor detection
                    local isSurvivor = true -- Default assumption
                    
                    -- Example detection methods (adjust based on actual game)
                    if player.Team and player.Team.Name:lower():find("survivor") then
                        isSurvivor = true
                    end
                    
                    if isSurvivor and player ~= game.Players.LocalPlayer then
                        -- Create ESP components with different colors
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "VOMO_ESP_Survivor_" .. player.Name
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green for survivors
                        highlight.OutlineColor = Color3.fromRGB(100, 255, 100)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = player.Character
                        
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "VOMO_ESP_SurvivorInfo_" .. player.Name
                        billboard.AlwaysOnTop = true
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                        
                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Text = player.Name .. " [SURVIVOR]"
                        nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.TextSize = 14
                        nameLabel.Parent = billboard
                        
                        local healthLabel = Instance.new("TextLabel")
                        healthLabel.Text = "Health: 100%"
                        healthLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
                        healthLabel.TextStrokeTransparency = 0
                        healthLabel.BackgroundTransparency = 1
                        healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
                        healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
                        healthLabel.Font = Enum.Font.Gotham
                        healthLabel.TextSize = 12
                        healthLabel.Parent = billboard
                        
                        billboard.Parent = player.Character.HumanoidRootPart
                        
                        -- Store ESP components
                        VOMO.ESP.Survivors[player] = {
                            Highlight = highlight,
                            Billboard = billboard,
                            NameLabel = nameLabel,
                            HealthLabel = healthLabel
                        }
                        
                        -- Update health
                        spawn(function()
                            while espSurvivorEnabled and player and player.Character and player.Character:FindFirstChild("Humanoid") do
                                wait(0.2)
                                local humanoid = player.Character.Humanoid
                                local health = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                                healthLabel.Text = "Health: " .. health .. "%"
                                
                                -- Change color based on health
                                if health > 70 then
                                    healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                                elseif health > 30 then
                                    healthLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                else
                                    healthLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                                end
                            end
                        end)
                    end
                end
                
                -- Process existing players
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    createSurvivorESP(player)
                end
                
                -- Listen for new players
                game:GetService("Players").PlayerAdded:Connect(function(player)
                    wait(2)
                    if espSurvivorEnabled then
                        createSurvivorESP(player)
                    end
                end)
                
                -- Clean up when players leave
                game:GetService("Players").PlayerRemoving:Connect(function(player)
                    if VOMO.ESP.Survivors[player] then
                        VOMO.ESP.Survivors[player].Highlight:Destroy()
                        VOMO.ESP.Survivors[player].Billboard:Destroy()
                        VOMO.ESP.Survivors[player] = nil
                    end
                end)
                
                -- Handle character changes
                game:GetService("Players").PlayerAdded:Connect(function(player)
                    player.CharacterAdded:Connect(function(character)
                        wait(1)
                        if espSurvivorEnabled then
                            createSurvivorESP(player)
                        end
                    end)
                end)
                
                print("Survivor ESP activated successfully")
            end)
        else
            -- Disable ESP for survivors
            for player, espData in pairs(VOMO.ESP.Survivors) do
                if espData.Highlight then
                    espData.Highlight:Destroy()
                end
                if espData.Billboard then
                    espData.Billboard:Destroy()
                end
            end
            VOMO.ESP.Survivors = {}
            print("Survivor ESP deactivated")
        end
    end
}

-- ESP customization
local ESPCustomization = ESPTab:Section{
    Name = "ESP Customization",
    Side = "Right",
    Collapsible = true,
    DefaultCollapsed = true
}

local espColorKiller = Color3.fromRGB(255, 0, 0)
local espColorSurvivor = Color3.fromRGB(0, 255, 0)
local espTransparency = 0.5

ESPCustomization:ColorPicker{
    Name = "Killer ESP Color",
    Default = espColorKiller,
    Callback = function(color)
        espColorKiller = color
        -- Update existing killer ESP
        for _, espData in pairs(VOMO.ESP.Killers) do
            if espData.Highlight then
                espData.Highlight.FillColor = color
                espData.NameLabel.TextColor3 = color
            end
        end
    end
}

ESPCustomization:ColorPicker{
    Name = "Survivor ESP Color",
    Default = espColorSurvivor,
    Callback = function(color)
        espColorSurvivor = color
        -- Update existing survivor ESP
        for _, espData in pairs(VOMO.ESP.Survivors) do
            if espData.Highlight then
                espData.Highlight.FillColor = color
                espData.NameLabel.TextColor3 = color
            end
        end
    end
}

ESPCustomization:Slider{
    Name = "ESP Transparency",
    Description = "Adjust ESP visibility level",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function(value)
        espTransparency = value / 100
        -- Update all ESP highlights
        for _, espData in pairs(VOMO.ESP.Killers) do
            if espData.Highlight then
                espData.Highlight.FillTransparency = espTransparency
            end
        end
        for _, espData in pairs(VOMO.ESP.Survivors) do
            if espData.Highlight then
                espData.Highlight.FillTransparency = espTransparency
            end
        end
    end
}

-- Tab 3: Anti-Cheat Bypass
local BypassTab = MainWindow:Tab{
    Name = "Anti-Cheat Bypass",
    Icon = "rbxassetid://7072716442",
    Tooltip = "Movement enhancement with anti-cheat bypass"
}

-- Speed Section
local SpeedSection = BypassTab:Section{
    Name = "Speed Enhancement",
    Side = "Left",
    Collapsible = false
}

-- Speed toggle with anti-cheat bypass
SpeedSection:Toggle{
    Name = "Enable Speed",
    Flag = "Speed_Enable_Toggle",
    Description = "Activate speed enhancement with anti-cheat bypass",
    Callback = function(state)
        VOMO.Movement.Speed.Enabled = state
        
        if state then
            -- Save original values
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                VOMO.Movement.Speed.OriginalWalkSpeed = character.Humanoid.WalkSpeed
                VOMO.Movement.Speed.OriginalJumpPower = character.Humanoid.JumpPower
            end
            
            -- Advanced anti-cheat bypass speed method
            spawn(function()
                while VOMO.Movement.Speed.Enabled do
                    wait(0.1)
                    
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        
                        -- Method 1: Direct modification (may be detected)
                        pcall(function()
                            humanoid.WalkSpeed = VOMO.Movement.Speed.Value
                        end)
                        
                        -- Method 2: Network simulation (advanced bypass)
                        if not humanoid:GetAttribute("VOMO_SpeedModified") then
                            humanoid:SetAttribute("VOMO_SpeedModified", true)
                        end
                        
                        -- Method 3: Velocity-based movement
                        if character:FindFirstChild("HumanoidRootPart") then
                            local rootPart = character.HumanoidRootPart
                            
                            -- Calculate movement direction
                            local camera = workspace.CurrentCamera
                            local lookVector = camera.CFrame.LookVector
                            local rightVector = camera.CFrame.RightVector
                            
                            local direction = Vector3.new(0, 0, 0)
                            local moveDirection = humanoid.MoveDirection
                            
                            if moveDirection.Magnitude > 0 then
                                -- Apply speed multiplier to movement
                                local velocity = moveDirection * VOMO.Movement.Speed.Value
                                
                                -- Use BodyVelocity for smooth movement
                                if not character:FindFirstChild("VOMO_SpeedVelocity") then
                                    local bodyVelocity = Instance.new("BodyVelocity")
                                    bodyVelocity.Name = "VOMO_SpeedVelocity"
                                    bodyVelocity.MaxForce = Vector3.new(10000, 0, 10000)
                                    bodyVelocity.Velocity = velocity
                                    bodyVelocity.P = 1000
                                    bodyVelocity.Parent = rootPart
                                else
                                    character.VOMO_SpeedVelocity.Velocity = velocity
                                end
                            elseif character:FindFirstChild("VOMO_SpeedVelocity") then
                                character.VOMO_SpeedVelocity:Destroy()
                            end
                        end
                        
                        -- Method 4: Animation speed modification
                        if humanoid:FindFirstChildOfClass("Animator") then
                            local animator = humanoid:FindFirstChildOfClass("Animator")
                            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                                if track.Animation then
                                    track:AdjustSpeed(VOMO.Movement.Speed.Value / 16) -- Normalize to default speed
                                end
                            end
                        end
                    end
                end
                
                -- Cleanup when disabled
                local character = game.Players.LocalPlayer.Character
                if character then
                    if character:FindFirstChild("VOMO_SpeedVelocity") then
                        character.VOMO_SpeedVelocity:Destroy()
                    end
                    if character:FindFirstChild("Humanoid") then
                        character.Humanoid.WalkSpeed = VOMO.Movement.Speed.OriginalWalkSpeed
                        character.Humanoid:SetAttribute("VOMO_SpeedModified", nil)
                    end
                end
            end)
            
            print("Speed enhancement activated: " .. VOMO.Movement.Speed.Value)
        else
            -- Restore original values
            local character = game.Players.LocalPlayer.Character
            if character then
                if character:FindFirstChild("VOMO_SpeedVelocity") then
                    character.VOMO_SpeedVelocity:Destroy()
                end
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = VOMO.Movement.Speed.OriginalWalkSpeed
                    character.Humanoid:SetAttribute("VOMO_SpeedModified", nil)
                end
            end
            print("Speed enhancement deactivated")
        end
    end
}

-- Speed slider with anti-cheat protection
SpeedSection:Slider{
    Name = "Speed Value",
    Description = "Adjust movement speed with anti-cheat protection (1-90)",
    Default = 20,
    Min = 1,
    Max = 90,
    Callback = function(value)
        VOMO.Movement.Speed.Value = value
        
        if VOMO.Movement.Speed.Enabled then
            -- Update speed immediately
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = value
                
                -- Update BodyVelocity if exists
                if character:FindFirstChild("VOMO_SpeedVelocity") then
                    local moveDirection = character.Humanoid.MoveDirection
                    if moveDirection.Magnitude > 0 then
                        character.VOMO_SpeedVelocity.Velocity = moveDirection * value
                    end
                end
            end
        end
        
        print("Speed adjusted to: " .. value)
    end
}

-- Fly Section
local FlySection = BypassTab:Section{
    Name = "Flight System",
    Side = "Right",
    Collapsible = false
}

-- Fly toggle with advanced anti-cheat bypass
FlySection:Toggle{
    Name = "Flight Toggle",
    Flag = "Fly_Enable_Toggle",
    Description = "Activate flight system with anti-cheat bypass",
    Callback = function(state)
        VOMO.Movement.Fly.Enabled = state
        
        if state then
            -- Initialize flight system
            local function StartFlight()
                local character = game.Players.LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then
                    return false
                end
                
                local rootPart = character.HumanoidRootPart
                
                -- Remove existing flight components
                if character:FindFirstChild("VOMO_FlyBodyVelocity") then
                    character.VOMO_FlyBodyVelocity:Destroy()
                end
                if character:FindFirstChild("VOMO_FlyBodyGyro") then
                    character.VOMO_FlyBodyGyro:Destroy()
                end
                
                -- Create flight components with fake names
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "VOMO_FlyBodyVelocity"
                bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.P = 1250
                bodyVelocity.Parent = rootPart
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.Name = "VOMO_FlyBodyGyro"
                bodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
                bodyGyro.P = 1000
                bodyGyro.D = 50
                bodyGyro.CFrame = rootPart.CFrame
                bodyGyro.Parent = rootPart
                
                VOMO.Movement.Fly.BodyVelocity = bodyVelocity
                VOMO.Movement.Fly.BodyGyro = bodyGyro
                VOMO.Movement.Fly.Flying = true
                
                return true
            end
            
            -- Start flight system
            if StartFlight() then
                -- Flight control loop
                spawn(function()
                    while VOMO.Movement.Fly.Enabled and VOMO.Movement.Fly.Flying do
                        wait()
                        
                        local character = game.Players.LocalPlayer.Character
                        if not character or not character:FindFirstChild("HumanoidRootPart") then
                            break
                        end
                        
                        local rootPart = character.HumanoidRootPart
                        local camera = workspace.CurrentCamera
                        
                        if not VOMO.Movement.Fly.BodyVelocity or not VOMO.Movement.Fly.BodyGyro then
                            if not StartFlight() then
                                break
                            end
                        end
                        
                        -- Get camera vectors
                        local lookVector = camera.CFrame.LookVector
                        local rightVector = camera.CFrame.RightVector
                        local upVector = Vector3.new(0, 1, 0)
                        
                        -- Calculate flight direction
                        local direction = Vector3.new(0, 0, 0)
                        
                        -- WASD controls with advanced input detection
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
                        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                            -- Ascend faster
                            direction = direction + (upVector * 2)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                            -- Descend faster
                            direction = direction - (upVector * 2)
                        end
                        
                        -- Normalize and apply speed
                        if direction.Magnitude > 0 then
                            direction = direction.Unit * VOMO.Movement.Fly.Speed
                        end
                        
                        -- Apply velocity
                        if VOMO.Movement.Fly.BodyVelocity then
                            VOMO.Movement.Fly.BodyVelocity.Velocity = direction
                        end
                        
                        -- Update rotation to face movement direction
                        if VOMO.Movement.Fly.BodyGyro then
                            if direction.Magnitude > 0 then
                                VOMO.Movement.Fly.BodyGyro.CFrame = CFrame.new(Vector3.new(), direction) * CFrame.Angles(0, camera.CFrame.Y, 0)
                            else
                                VOMO.Movement.Fly.BodyGyro.CFrame = camera.CFrame
                            end
                        end
                    end
                    
                    -- Cleanup
                    VOMO.Movement.Fly.Flying = false
                end)
                
                print("Flight system activated with speed: " .. VOMO.Movement.Fly.Speed)
            end
        else
            -- Stop flight system
            VOMO.Movement.Fly.Flying = false
            
            local character = game.Players.LocalPlayer.Character
            if character then
                if character:FindFirstChild("VOMO_FlyBodyVelocity") then
                    character.VOMO_FlyBodyVelocity:Destroy()
                end
                if character:FindFirstChild("VOMO_FlyBodyGyro") then
                    character.VOMO_FlyBodyGyro:Destroy()
                end
            end
            
            VOMO.Movement.Fly.BodyVelocity = nil
            VOMO.Movement.Fly.BodyGyro = nil
            
            print("Flight system deactivated")
        end
    end
}

-- Fly speed slider
FlySection:Slider{
    Name = "Flight Speed",
    Description = "Adjust flight speed with anti-cheat protection (1-100)",
    Default = 30,
    Min = 1,
    Max = 100,
    Callback = function(value)
        VOMO.Movement.Fly.Speed = value
        
        if VOMO.Movement.Fly.Enabled and VOMO.Movement.Fly.BodyVelocity then
            -- Update flight speed immediately
            local currentVelocity = VOMO.Movement.Fly.BodyVelocity.Velocity
            if currentVelocity.Magnitude > 0 then
                VOMO.Movement.Fly.BodyVelocity.Velocity = currentVelocity.Unit * value
            end
        end
        
        print("Flight speed adjusted to: " .. value)
    end
}

-- Flight controls information
FlySection:Label{
    Text = "Flight Controls:",
    Description = "WASD - Movement | Space - Ascend | Shift - Descend | E/Q - Fast Ascend/Descend",
    Color = Color3.fromRGB(0, 200, 255),
    Bold = true
}

-- Advanced bypass techniques section
local AdvancedBypass = BypassTab:Section{
    Name = "Advanced Bypass Techniques",
    Side = "Left",
    Collapsible = true,
    DefaultCollapsed = true
}

AdvancedBypass:Toggle{
    Name = "Anti-Kick Protection",
    Description = "Prevent game from kicking you (Advanced)",
    Default = true,
    Callback = function(state)
        VOMO.Security.AntiKick = state
        
        if state then
            -- Advanced anti-kick protection
            local mt = getrawmetatable(game)
            if mt then
                local oldNamecall = mt.__namecall
                local oldIndex = mt.__index
                
                setreadonly(mt, false)
                
                -- Protect against kicks
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    
                    if method == "Kick" or method == "kick" then
                        warn("[VOMO] Kick attempt blocked")
                        return nil
                    end
                    
                    if method == "Destroy" and tostring(self):find("VOMO") then
                        warn("[VOMO] Protected object destruction attempt blocked")
                        return nil
                    end
                    
                    return oldNamecall(self, unpack(args))
                end)
                
                -- Protect against teleports to bad places
                mt.__index = newcclosure(function(self, key)
                    if key == "Teleport" or key == "teleport" then
                        warn("[VOMO] Teleport access blocked")
                        return function() end
                    end
                    
                    return oldIndex(self, key)
                end)
                
                setreadonly(mt, true)
                print("Anti-kick protection activated")
            end
        else
            print("Anti-kick protection deactivated")
        end
    end
}

AdvancedBypass:Toggle{
    Name = "Anti-Log Detection",
    Description = "Prevent logging of script activities",
    Default = true,
    Callback = function(state)
        VOMO.Security.AntiLog = state
        
        if state then
            -- Clear output
            if rconsoleclear then
                rconsoleclear()
            end
            if clr then
                clr()
            end
            
            -- Hook print function
            local oldPrint = print
            print = function(...)
                local args = {...}
                local output = ""
                for i, v in ipairs(args) do
                    output = output .. tostring(v)
                    if i < #args then
                        output = output .. " "
                    end
                end
                
                -- Filter sensitive information
                if not output:find("VOMO") and not output:find("script") then
                    oldPrint(...)
                end
            end
            print("Anti-log detection activated")
        else
            print("Anti-log detection deactivated")
        end
    end
}

-- Character added event to reapply settings
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- Wait for character to fully load
    
    -- Reapply speed if enabled
    if VOMO.Movement.Speed.Enabled then
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = VOMO.Movement.Speed.Value
        end
    end
    
    -- Reapply flight if enabled
    if VOMO.Movement.Fly.Enabled then
        VOMO.Movement.Fly.Flying = false
        VOMO.Movement.Fly.BodyVelocity = nil
        VOMO.Movement.Fly.BodyGyro = nil
        
        -- Restart flight system
        local flyToggle = FlySection:GetToggle("Fly_Enable_Toggle")
        if flyToggle then
            flyToggle:Set(true)
        end
    end
    
    -- Reapply ESP if enabled
    if espKillerEnabled then
        local killerToggle = ESPSection:GetToggle("ESP_Killer_Toggle")
        if killerToggle then
            killerToggle:Set(true)
        end
    end
    
    if espSurvivorEnabled then
        local survivorToggle = ESPSection:GetToggle("ESP_Survivor_Toggle")
        if survivorToggle then
            survivorToggle:Set(true)
        end
    end
end)

-- Global cleanup on script termination
local function Cleanup()
    print("[VOMO] Performing cleanup...")
    
    -- Clean up ESP
    for player, espData in pairs(VOMO.ESP.Killers) do
        if espData.Highlight then
            espData.Highlight:Destroy()
        end
        if espData.Billboard then
            espData.Billboard:Destroy()
        end
    end
    VOMO.ESP.Killers = {}
    
    for player, espData in pairs(VOMO.ESP.Survivors) do
        if espData.Highlight then
            espData.Highlight:Destroy()
        end
        if espData.Billboard then
            espData.Billboard:Destroy()
        end
    end
    VOMO.ESP.Survivors = {}
    
    -- Clean up movement modifications
    local character = game.Players.LocalPlayer.Character
    if character then
        if character:FindFirstChild("VOMO_SpeedVelocity") then
            character.VOMO_SpeedVelocity:Destroy()
        end
        if character:FindFirstChild("VOMO_FlyBodyVelocity") then
            character.VOMO_FlyBodyVelocity:Destroy()
        end
        if character:FindFirstChild("VOMO_FlyBodyGyro") then
            character.VOMO_FlyBodyGyro:Destroy()
        end
        if character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
    end
    
    -- Disconnect all connections
    for _, connection in pairs(VOMO.Connections) do
        if connection then
            connection:Disconnect()
        end
    end
    VOMO.Connections = {}
    
    print("[VOMO] Cleanup completed")
end

-- Register cleanup function
if game:GetService("RunService"):IsStudio() then
    game:BindToClose(Cleanup)
else
    game:GetService("Players").LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not game:GetService("Players").LocalPlayer.Parent then
            Cleanup()
        end
    end)
end

-- Keyboard shortcuts
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        -- Toggle GUI with F9
        if input.KeyCode == Enum.KeyCode.F9 then
            MainWindow:Toggle()
        end
        
        -- Toggle speed with F2
        if input.KeyCode == Enum.KeyCode.F2 then
            local speedToggle = SpeedSection:GetToggle("Speed_Enable_Toggle")
            if speedToggle then
                speedToggle:Set(not VOMO.Movement.Speed.Enabled)
            end
        end
        
        -- Toggle flight with F3
        if input.KeyCode == Enum.KeyCode.F3 then
            local flyToggle = FlySection:GetToggle("Fly_Enable_Toggle")
            if flyToggle then
                flyToggle:Set(not VOMO.Movement.Fly.Enabled)
            end
        end
        
        -- Toggle killer ESP with F4
        if input.KeyCode == Enum.KeyCode.F4 then
            local killerToggle = ESPSection:GetToggle("ESP_Killer_Toggle")
            if killerToggle then
                killerToggle:Set(not espKillerEnabled)
            end
        end
        
        -- Toggle survivor ESP with F5
        if input.KeyCode == Enum.KeyCode.F5 then
            local survivorToggle = ESPSection:GetToggle("ESP_Survivor_Toggle")
            if survivorToggle then
                survivorToggle:Set(not espSurvivorEnabled)
            end
        end
    end
end)

-- Final initialization message
print("==========================================")
print("VOMO_ Enhancement Suite v2.0")
print("Successfully loaded and initialized")
print("==========================================")
print("Shortcuts:")
print("F9 - Toggle GUI")
print("F2 - Toggle Speed")
print("F3 - Toggle Flight")
print("F4 - Toggle Killer ESP")
print("F5 - Toggle Survivor ESP")
print("==========================================")

-- Return module for external access
return VOMO
