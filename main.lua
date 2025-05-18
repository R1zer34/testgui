love.graphics.setDefaultFilter("nearest", "nearest")
local Gui = require "GUI"
require "GUI.utils"

local l = Gui:newLayer()
local b1 = Gui:newWidjet( l,  "button", { w=160, h=160, icon=love.graphics.newImage( "icon.png" ) } )
local b2 = Gui:newWidjet( l,  "button", { x=170, w=160, h=40, title="Кнопка 2" } )
local b3 = Gui:newWidjet( l,  "button", { x=170, y=50, w=160, h=40, title="Кнопка 3" } )
local b4 = Gui:newWidjet( l,  "button", { x=170, y=95, w=160, h=40, title="Кнопка 4" } )
local lb = Gui:newWidjet( l,  "label", {y=200, w = 300, h=240, title="Текстовое поле",
    text=[[
Съешь еще этих мягких французких булочек, да выпей чаю!
]]
})
local cb = Gui:newWidjet( l,  "checkbox", { x=340, w=120, variants={"+1 px", "+1 px", "+2 px"}} )
cb.onSwitched = function ( i, v, d )
    if d then
        if i == 1 then
            cb:setBoxSize(cb:getBoxSize()+1)
        elseif i==2 then
            cb:setBoxSize(cb:getBoxSize()+1)
        else
            cb:setBoxSize(cb:getBoxSize()+2)
        end
    else
        if i == 1 then
            cb:setBoxSize(cb:getBoxSize()-1)
        elseif i==2 then
            cb:setBoxSize(cb:getBoxSize()-1)
        else
            cb:setBoxSize(cb:getBoxSize()-2)
        end
    end
end

b1.onClicked = function ()
    print(1)
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