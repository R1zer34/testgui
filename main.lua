love.graphics.setDefaultFilter("nearest", "nearest")
local Gui = require "GUI"
require "GUI.utils"

local l = Gui:newLayer()
local b1 = Gui:newWidjet( l,  "button", { w=160, h=130, icon=love.graphics.newImage( "icon.png" ) } )
local buttons = {
    Gui:newWidjet( l,  "button", { x=170, w=160, h=40, title="Кнопка 2", visible=false } ),
    Gui:newWidjet( l,  "button", { x=170, y=50, w=160, h=40, title="Кнопка 3", visible=false } ),
    Gui:newWidjet( l,  "button", { x=170, y=95, w=160, h=40, title="Кнопка 4", visible=false } )
}
local b5 = Gui:newWidjet( l,  "button", { y=415, w=320, h=40, icon=love.graphics.newImage( "icon.png" ) } )
local lb = Gui:newWidjet( l,  "label", { y=170, w=320, h=240, title="Текстовое поле", visible=false,
    text=[[
Съешь еще этих мягких французких булочек, да выпей чаю!
]]
})
local cb = Gui:newWidjet( l,  "checkbox", { x=340, w=130, variants={"1 кнопка", "2 кнопка", "3 кнопка"}, visible=false } )
local sb = Gui:newWidjet( l, "switchbox", {x=340, y=95, w=130, variants={1, 2, 3}, visible=false } )
cb.onSwitched = function ( i, v, d )
    buttons[i].visible = d
end
local texts = {
"Съешь еще этих мягких французких булочек, да выпей чаю!",
"Съел бы ёж лимонный пьезокварц, где электрическая юла яшму с туфом похищает.",
"Твёрдый, как ъ, но и мягкий, словно ь, юноша из Бухары ищет фемину-москвичку для просмотра цветного экрана жизни."
}
sb.onSwitched = function ( i, v )
    lb.text = texts[i]
end
b5.onClicked = function ()
    lb:switchVisible()
end
b1.onClicked = function ()
    cb:switchVisible()
    sb:switchVisible()
end
local clicks = {0, 0, 0}
for index, button in ipairs(buttons) do
    button.onClicked = function ()
        clicks[index] = clicks[index] + 1
        button:setTitle( "Кнопка " .. index+1 .. "(" .. clicks[index] .. ")" )
    end
end
local swt = Gui:newWidjet( l, "switcher", {x=340,y=422,dir=false} )
local colors = {
    back_color = hex( "#bd3131" ),
    collided_color = hex( "#630909" ),
    clicked_color = hex( "#592222" )
}
swt.onSwitched = function ( state )
    if state then
        Gui:setColorscheme(colors)
    else
        Gui:setColorscheme(Gui.default_colorscheme)
    end
end

function love.update( dt )
    Gui:update( dt )
end

function love.mousemoved( x, y, dx, dy )
    Gui:mousemoved( x, y, dx, dy )
end

function love.mousepressed( x , y , button , isTouch )
    Gui:mousepressed( x, y, button, isTouch )
end

function love.mousereleased( x , y , button , isTouch )
    Gui:mousereleased( x, y, button, isTouch )
end

function love.keypressed( key , scancode , isrepeat )
    Gui:keypressed( key, scancode, isrepeat )
end

function love.keyreleased( key )
    Gui:keyreleased( key )
end

function love.textinput( text )
    Gui:textinput( text )
end

function love.draw()
    love.graphics.clear( hex( "#373a36" ) )
    Gui:draw()
end