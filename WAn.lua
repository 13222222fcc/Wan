*local success, library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/13222222fcc/Wanscript/refs/heads/main/UI.lua"))()
end)

if not success then
print("殺脚本")  
    return
end

local window = library:new("挽脚本")

local FengYu = window:Tab("关于",'84830962019412')

local Feng =FengYu:section("通用",true)

Feng:Button("my Fck", function()
    
end)

Feng:Toggle("开关", "FengYu", false, function(a)
    
end)

Feng:Slider('滑块', 'FengYu', 0, 0, 9999,false, function(b)
    
end)

Feng:Textbox("输入", "FengYu", "输入", function(c)
  
end)

Feng:Dropdown("下拉式", "FengYu", {
    "额"
}, function(d)
    
end)

local FengYu = window:Tab("甬用",'84830962019412')

local Feng =FengYu:section("通用",true)

Feng:Toggle("彩虹UI", "", false, function(state)
        if state then
            game:GetService("CoreGui")["frosty is cute"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty is cute"].Main.Style = "Custom"
        end
    end)
    Feng:Button("穿墙",function()
    loadstring(game:HttpGet("https://github.com/DXuwu/OK/raw/main/clip"))()
end)
credits:Button("飞行",function()
    loadstring(game:HttpGet("https://shz.al/~hhhh"))()
end)

credits:Button("防20分钟踢",function()
loadstring(game:HttpGet(('https://pastefy.app/6QUXuVkW/raw'),true))()
end)

credits:Button("龙脚本",function()
    getgenv().long = "龙脚本，加载时间长请耐心"loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\108\121\121\97\105\110\105\47\108\111\110\47\109\97\105\110\47\108\105\115\119\109\34\41\41\40\41")()
end)


