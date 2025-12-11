<local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/FengYu-ui/refs/heads/main/UI.lua"))()
end)

if not success then
print("Wan脚本")  
    return
end

local playerName = game.Players.LocalPlayer.Name
local window = library:new("Wan┋" .. playerName)

local FengYu = window:Tab("关于",'84830962019412')

local Feng =FengYu:section("通用",true)

Feng:Button("文本", function()
    
end)

Feng:Toggle("开关", "FengYu", false, function(a)
    
end)

Feng:Slider('滑块', 'FengYu', 0, 0, 9999,false, function(b)
    
end)

Feng:Textbox("输入", "FengYu", "输入", function(c)
  
end)

Feng:Dropdown("下拉式", "FengYu", {
    "额"
    "2"
}, function(d)
    
end)
