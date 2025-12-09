local library = loadstring(game:HttpGet(""))(); --这里是放你UI的地方也就是你的界面

local window = library:new("脚本") --这里是你的脚本名

local Wans = window:Tab("通用",'图片ID') --这是选项卡必须加不然脚本用不了

local Wan =Wans:section("通用",true) --这个也是

Wan:Button("按钮", function()
    --当然了这里是放脚本的地方比如放皮脚本之类的东西
end)

Wan:Toggle("开关", "Wan", false, function(a)
    --这里的开关是配合定义你们自己看吧其他的也是
end)

Wan:Slider('滑块', 'Wan', 0, 0, 9999,false, function(b)
    
end)

Wan:Textbox("输入", "Wan", "输入", function(c)
  
end)

Wan:Dropdown("下拉式", "Wan", {
    "额"
}, function(d)
    
end)
