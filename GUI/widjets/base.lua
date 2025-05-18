require "GUI.utils"

local base = {
    x=5,y=5,w=25,h=25,
    visible = true,
    clicked = false,
    collided = false,
    grabed = false,
    title = nil,
}
base.__index = base

function base:setX( x )
    local old_x = self.x
    self.x = x

    if self.childs then
        for _, child in ipairs( self.childs ) do
            local child_old_x = child.x
            child.x = child_old_x + (self.x-old_x)
        end
    end

    return self
end

function base:getX()
    return self.x
end

function base:setY( y )
    local old_y = self.y
    self.y = y

    if self.childs then
        for _, child in ipairs( self.childs ) do
            local child_old_y = child.y
            child.y = child_old_y + (self.y-old_y)
        end
    end

    return self
end

function base:getY()
    return self.y
end

function base:setPos( x, y )
    local old_y = self.y
    local old_x = self.x
    self.y = y
    self.x = x

    if self.childs then
        for _, child in ipairs( self.childs ) do
            local child_old_y = child.y
            local child_old_x = child.x
            child.y = child_old_y + (self.y-old_y)
            child.x = child_old_x + (self.x-old_x)
        end
    end

    return self
end

function base:getPos()
    return self.x, self.y
end

function base:setW( w )
    self.w = w
    return self
end

function base:getW()
    return self.w
end

function base:setH( h )
    self.h = h
    return self
end

function base:getH()
    return self.h
end

function base:setSize( w, h )
    self.w = w self.h = h
    return self
end

function base:getSize()
    return self.w, self.h
end

function base:setVisible( visible )
    self.visible = visible
    return self
end

function base:getVisible()
    return self.visible
end

function base:switchVisible()
    if self.visible then
        self.visible = false
    else
        self.visible = true
    end
end

function base:getRect()
    return self.x, self.y, self.w, self.h
end

function base:setTitle( title )
    self.title = title
    return self
end

function base:getTiele()
    return self.title
end

function base:mousemoved( _, x, y, _, _ )
    self.collided = pointRectCollide( x, y, self:getRect() )
    if not self.collided then self.clicked = false end
end

function base:mousepressed( _, _, _, button )
    if button == 1 and self.collided then
        self.clicked = true
        self.grabed = true
    end
end

function base:mousereleased( _, _, _, button )
    if button == 1 then
        if self.clicked then
            if self.onClicked then self.onClicked() end
            self.clicked = false
        elseif self.grabed and self.collided then
            if self.onClicked then self.onClicked() end
        end
        self.grabed = false
    end
end

function base:update( dt )
    if self.collided and self.onCollided then
        self.onCollided()
    end
end

return base