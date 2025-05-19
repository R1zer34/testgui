require "GUI.utils"

local font24 = love.graphics.newFont( "GUI/src/Audexitalic.ttf", 24 )
local font20 = love.graphics.newFont( "GUI/src/Audex.ttf", 20 )

return {

    base = function ( widjet, colorscheme )
        love.graphics.setColor( colorscheme.back_color )
        love.graphics.rectangle( "line", widjet:getRect() )
        love.graphics.line( widjet.x, widjet.y, widjet.x+widjet.w, widjet.y+widjet.h )
        love.graphics.line( widjet.x+widjet.w, widjet.y, widjet.x, widjet.y+widjet.h )
    end,

    button = function ( widjet, colorscheme )
        love.graphics.setFont( font24 )

        love.graphics.setColor( colorscheme.back_color )
        if widjet.collided and (not love.mouse.isDown(1) or widjet.grabed) then
            love.graphics.setColor( colorscheme.collided_color )
        end
        if widjet.clicked then
            love.graphics.setColor( colorscheme.clicked_color )
        end

        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.h, 8, 8 )

        love.graphics.setScissor( widjet.x+5, widjet.y+5, widjet.w-10, widjet.h-10 )
        if widjet.icon then
            local ix, iy
            local icon_scale

            if widjet.w > widjet.h then
                ix, iy = rectInRect( widjet.x, widjet.y, widjet.w, widjet.h, widjet.h-10, widjet.h-10)
                if widjet.icon:getHeight() > widjet.h then
                    icon_scale = ( widjet.h-16 )/widjet.icon:getHeight()
                else
                    icon_scale = widjet.icon:getHeight()/( widjet.h )
                end
            else
                ix, iy = rectInRect( widjet.x, widjet.y, widjet.w, widjet.h, widjet.w-10, widjet.w-10)
                if widjet.icon:getWidth() > widjet.w then
                    icon_scale = ( widjet.w-25 )/widjet.icon:getWidth()
                else
                    icon_scale = widjet.icon:getWidth()/( widjet.w )
                end
            end

            love.graphics.draw( widjet.icon, ix, iy, 0, icon_scale )
        elseif widjet.title then
            love.graphics.setColor( colorscheme.text_color )
            love.graphics.print( widjet.title, rectInRect( widjet.x, widjet.y, widjet.w, widjet.h, font24:getWidth( widjet.title ), font24:getHeight() ) )
        end
        love.graphics.setScissor()
    end,

    label = function ( widjet, colorscheme )
        love.graphics.setFont( font20 )
        if widjet.title then
            local title_bar_w = font20:getWidth( widjet.title )+16
            if title_bar_w > widjet.w-16 then
                title_bar_w = widjet.w-16
            end

            love.graphics.setColor( colorscheme.back2_color )
            love.graphics.rectangle( "fill", widjet.x + (widjet.w-title_bar_w)/2, widjet.y-26, title_bar_w, 36, 8, 8)
            love.graphics.setColor( colorscheme.back_color )
            love.graphics.setScissor( widjet.x + (widjet.w-title_bar_w)/2, widjet.y-26, title_bar_w, 36 )
            love.graphics.print( widjet.title, rectInRect( widjet.x + (widjet.w-title_bar_w)/2, widjet.y-26, title_bar_w, 36, font20:getWidth( widjet.title ), font20:getHeight() ) )
            love.graphics.setScissor()
        end
        love.graphics.setColor( colorscheme.back2_color )
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.h, 8, 8)
        love.graphics.setColor( colorscheme.text_color )
        love.graphics.setScissor( widjet.x+5, widjet.y, widjet.w-10, widjet.h-5 )
        love.graphics.printf( widjet.text, widjet.x+5, widjet.y+8, widjet.w-10)
        love.graphics.setScissor()
    end,

    checkbox = function ( widjet, colorscheme )
        love.graphics.setFont( font20 )
        love.graphics.setColor( colorscheme.back2_color )
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.box_size*(#widjet.variants+0.8)+8, 8, 8 )

        for index, child in ipairs( widjet.childs ) do
            love.graphics.setColor( colorscheme.back_color )
            if widjet.act_variants[index] then
                love.graphics.rectangle( "fill", child.x, child.y, child.w, child.h )
            else
                love.graphics.rectangle( "line", child.x, child.y, child.w, child.h )
            end
            love.graphics.setColor( colorscheme.text_color )
            love.graphics.print( widjet.variants[index], widjet.x+widjet.box_size*1.5, widjet.y+(widjet.box_size+5)*index-font20:getHeight()+2 )
        end
    end,

    switchbox = function ( widjet, colorscheme )
        love.graphics.setFont( font20 )
        love.graphics.setColor( colorscheme.back2_color )
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.circ_size*(#widjet.variants+0.8)+8, 8, 8 )

        for index, child in ipairs( widjet.childs ) do
            love.graphics.setColor( colorscheme.back_color )
            if widjet.act_variant == index then
                love.graphics.circle( "fill", child.x+child.w/2, child.y+child.w/2, child.w/2 )
            else
                love.graphics.circle( "line", child.x+child.w/2, child.y+child.w/2, child.w/2 )
            end
            love.graphics.setColor( colorscheme.text_color )
            love.graphics.print( widjet.variants[index], widjet.x+widjet.circ_size*1.5, widjet.y+(widjet.circ_size+5)*index-font20:getHeight()+2 )
        end
    end,

    switcher = function ( widjet, colorscheme )
        local size, pos1_x, pos1_y, pos2_x, pos2_y
        if widjet.dir then
            size = widjet.h/2-3
            pos1_x = widjet.x+widjet.w-widjet.h/2
            pos1_y = widjet.y+widjet.h/2
            pos2_x = widjet.x+widjet.h/2
            pos2_y = widjet.y+widjet.h/2
        else
            size = widjet.w/2-3
            pos1_x = widjet.x+widjet.w/2
            pos1_y = widjet.y+widjet.h-widjet.w/2
            pos2_x = widjet.x+widjet.w/2
            pos2_y = widjet.y+widjet.w/2
        end

        love.graphics.setColor( colorscheme.back2_color )
        love.graphics.rectangle( "fill", widjet.x, widjet.y, widjet.w, widjet.h, 16, 16 )

        if widjet.state then
            love.graphics.setColor( colorscheme.back_color )
            love.graphics.circle( "fill", pos1_x, pos1_y , size )
        else
            love.graphics.setColor( colorscheme.back_color )
            love.graphics.circle( "line", pos2_x, pos2_y, size )
        end
    end
}