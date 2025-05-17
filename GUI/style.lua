require "GUI.utils"

local font24 = love.graphics.newFont( "GUI/src/hemico.ttf", 24 )
local font20 = love.graphics.newFont( "GUI/src/hemico.ttf", 20 )

return {
    base = function ( widjet )
        love.graphics.rectangle( "line", widjet:getRect() )
        love.graphics.line( widjet.x, widjet.y, widjet.x+widjet.w, widjet.y+widjet.h )
        love.graphics.line( widjet.x+widjet.w, widjet.y, widjet.x, widjet.y+widjet.h )
    end,

    button = function ( widjet )
        love.graphics.setFont( font24 )

        love.graphics.setColor( hex("#d48166") )
        if widjet.collided then
            love.graphics.setColor( hex("#9e624d") )
        end
        if widjet.clicked then
            love.graphics.setColor( hex("#7a4c3c") )
        end
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.h, 8, 8 )
        love.graphics.setScissor( widjet.x+5, widjet.y+5, widjet.w-10, widjet.h-10 )
        if widjet.icon then
            local ix, iy = rectInRect( widjet.x, widjet.y, widjet.w, widjet.h, widjet.h-20, widjet.h-20)
            love.graphics.draw( widjet.icon, ix, iy, 0, widjet.icon:getWidth()/( widjet.w+20 ) )
        elseif widjet.title then
            love.graphics.setColor( hex("#e6e2dd") )
            love.graphics.print( widjet.title, rectInRect( widjet.x, widjet.y, widjet.w, widjet.h, font24:getWidth( widjet.title ), font24:getHeight() ) )
        end
        love.graphics.setScissor()
    end,

    label = function ( widjet )
        if widjet.title then
            local title_bar_w = font20:getWidth( widjet.title )+16
            if title_bar_w > widjet.w-16 then
                title_bar_w = widjet.w-16
            end

            love.graphics.setColor( hex("#d48166") )
            love.graphics.setFont( font20 )
            love.graphics.rectangle( "fill", widjet.x + 8, widjet.y-26, title_bar_w, 36, 8, 8)
            love.graphics.setColor( hex("#e6e2dd") )
            love.graphics.setScissor( widjet.x + 8, widjet.y-26, title_bar_w, 36 )
            love.graphics.print( widjet.title, rectInRect( widjet.x+8, widjet.y-26, title_bar_w, 36, font20:getWidth( widjet.title ), font20:getHeight() ) )
            love.graphics.setScissor()
        end
        love.graphics.setColor( hex("#d48166") )
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.h, 8, 8)
        love.graphics.setColor( hex("#e6e2dd") )
        love.graphics.setScissor( widjet.x+5, widjet.y, widjet.w-10, widjet.h-5 )
        love.graphics.printf( widjet.text, widjet.x+5, widjet.y, widjet.w-10)
        love.graphics.setScissor()
    end,

    checkbox = function ( widjet )
        for index, child in ipairs( widjet.childs ) do
            love.graphics.setColor( hex("#d48166") )
            if widjet.act_variant == index then
                love.graphics.rectangle( "fill", child.x, child.y, child.w, child.h )
            else
                love.graphics.rectangle( "line", child.x, child.y, child.w, child.h )
            end
            love.graphics.setColor( hex("#e6e2dd") )
            love.graphics.print( widjet.variants[index], widjet.x+24, widjet.y+(widjet.variant_size+5)*index-6 )
        end
    end
}