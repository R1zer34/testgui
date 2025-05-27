love.graphics.setDefaultFilter("nearest", "nearest")
local Gui = require "GUI"
local utils = require "GUI.utils"

local l = Gui:newLayer()

local texts = {
"Съешь еще этих мягких французких булочек, да выпей чаю!",
"Съел бы ёж лимонный пьезокварц, где электрическая юла яшму с туфом похищает.",
"Твёрдый, как ъ, но и мягкий, словно ь, юноша из Бухары ищет фемину-москвичку для просмотра цветного экрана жизни."
}
local lb = Gui:newWidjet( l,  "label", { x=10, y=190, w=320, h=240, title="Текстовое поле", visible=false, text=texts[1]})
----------------------------------------------------------------------------------------
local sb = Gui:newWidjet( l, "switchbox", {x=350, y=110, w=130, variants={1, 2, 3}, visible=false } )
sb.onSwitched = function ( i, v )
    lb.text = texts[i]
end
----------------------------------------------------------------------------------------
local b5 = Gui:newWidjet( l,  "button", { x=10, y=450, w=320, h=40, icon=love.graphics.newImage( "icon.png" ) } )
b5.onClicked = function ()
    lb:switchVisible()
end
----------------------------------------------------------------------------------------
local buttons = {
    Gui:newWidjet( l,  "button", { x=180, y=10, w=160, h=40, title="Кнопка 2", visible=false } ),
    Gui:newWidjet( l,  "button", { x=180, y=60, w=160, h=40, title="Кнопка 3", visible=false } ),
    Gui:newWidjet( l,  "button", { x=180, y=110, w=160, h=40, title="Кнопка 4", visible=false } )
}
local clicks = {0, 0, 0}
for index, button in ipairs(buttons) do
    button.onClicked = function ()
        clicks[index] = clicks[index] + 1
        button:setTitle( "Кнопка " .. index+1 .. "(" .. clicks[index] .. ")" )
    end
end
local cb = Gui:newWidjet( l,  "checkbox", { x=350, y=10, w=140, variants={"1 кнопка", "2 кнопка", "3 кнопка"}, visible=false } )
cb.onSwitched = function ( i, v, d )
    buttons[i].visible = d
end
----------------------------------------------------------------------------------------
local b1 = Gui:newWidjet( l,  "button", { x=10, y=10, w=160, h=140, icon=love.graphics.newImage( "icon.png" ) } )
b1.onClicked = function ()
    cb:switchVisible()
    sb:switchVisible()
end
----------------------------------------------------------------------------------------
local swt = Gui:newWidjet( l, "switcher", {x=350,y=250,dir=true} )
local colors = {
    back_color = utils.hex( "#bd3131" ),
    collided_color = utils.hex( "#630909" ),
    clicked_color = utils.hex( "#592222" )
}
swt.onSwitched = function ( state )
    if state then
        Gui:setColorscheme(colors)
    else
        Gui:setColorscheme(Gui.default_colorscheme)
    end
end
----------------------------------------------------------------------------------------
local sc = Gui:newWidjet( l, "scrollbar", {x=350,y=210,w=300,dir=false}):swithDirection()
local r, g, b = unpack(utils.hex( "#373a36" ))
local kr, kg, kb = 0, 0, 0
sc.onScrolled = function ( percent )
    kr = (0.1*percent)
    kg = (0.1*percent)
    kb = (0.1*percent)
end
----------------------------------------------------------------------------------------
local ip = Gui:newWidjet( l, "inputline", {x=500, y=10, limit=50})

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

--local grid = utils.getGrid( 800, 600, 10, 10)
function love.draw()
    love.graphics.clear( r+kr, g+kg, b+kb )
    --love.graphics.draw( grid, 0, 0 )
    Gui:draw()
    love.graphics.setColor( 0, 0, 0 )
end