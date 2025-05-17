local Gui = require "GUI"
require "GUI.utils"

local l = Gui:newLayer()
local b1 = Gui:newWidjet( l,  "button", { w=160, h=40, title="Кнопка", icon=love.graphics.newImage( "icon.png" ) } )
local b2 = Gui:newWidjet( l,  "button", { x=170, w=160, h=40, title="Кнопка 2" } )
local lb = Gui:newWidjet( l,  "label", { y=100, w = 300, h=240, title="Текстовое поле",
    text=[[
линия1
линия2
...
...
...
и т.д
]]
})
local cb = Gui:newWidjet( l,  "checkbox", { x=340, w=120, variants={"пункт1", "пункт2", "пункт3"}} )
cb.onSwitched = function ( i, v )
    print( i, v )
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