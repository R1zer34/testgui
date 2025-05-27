local utils = require "GUI.utils"

local scrollbar = utils.createWidjet( {
    w = 125,
    childs = {},
    percent = 0,
    dir = true
} )

local added_pos
local old_w=scrollbar.w
local old_h=scrollbar.h

local function dir_update(self, b)
    if self.dir then
        self.w = old_w
        self.h = old_h

        b:setSize(self.h, self.h)
        local _, pos_y = utils.rectInRect( self.x, self.y, self.w, self.h, b.h-8, b.h-8)
        b:setPos( self.x+4, pos_y )
        
        local max_pos = self.x+4+self.w-self.h
        local min_pos = self.x+4

        b.onGrabed = function ( x, _ )
            if not added_pos then
                added_pos = x-b.x
            end
            b:setX( x-added_pos )
        
            if b.x > max_pos then b.x = max_pos end
            if b.x < min_pos then b.x = min_pos end
            self.percent = (b.x-self.x-4)/(max_pos-self.x-4)
            if self.onScrolled then self.onScrolled( self.percent ) end
        end
    else
        self.w = old_h
        self.h = old_w

        b:setSize(self.w, self.w)
        local pos_x, _ = utils.rectInRect( self.x, self.y, self.w, self.h, b.w-8, b.w-8)
        b:setPos( pos_x, self.y+4 )

        local max_pos = self.y+4+self.h-self.w
        local min_pos = self.y+4

        b.onGrabed = function ( _, y )
            if not added_pos then
                added_pos = y-b.y
            end
            b:setY( y-added_pos )
        
            if b.y > max_pos then b.y = max_pos end
            if b.y < min_pos then b.y = min_pos end
            self.percent = (b.y-self.y-4)/(max_pos-self.y-4)
            if self.onScrolled then self.onScrolled( self.percent ) end
        end
    end
end

function scrollbar:init()
    local b = {}
    b.__index = b
    setmetatable( b, require( "GUI.widjets.button" ) )
    table.insert( self.childs, b )
    dir_update(self, b)
end

scrollbar.old_update2 = scrollbar.update

function scrollbar:update( dt )
    self:old_update2( dt )
    if not self.childs[1].grabed then added_pos = nil end
end

function scrollbar:setDirection( direction )
    self.dir = direction
    dir_update(self, self.childs[1])
    return self
end

function scrollbar:getDirection()
    return self.dir
end

function scrollbar:swithDirection()
    if self.dir then
        self.dir = false
    else
        self.dir = true
    end
    
    dir_update(self, self.childs[1])

    return self
end

return scrollbar