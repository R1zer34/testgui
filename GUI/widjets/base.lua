require "GUI.utils"

local base = {
    x=5,y=5,w=25,h=25,
    visible = true,
    clicked = false,
    collided = false,
    activated = false,
    title = nil,
}
base.__index = base

function base:setX( x )
    self.x = x
    return self
end

function base:getX()
    return self.x
end

function base:setY( y )
    self.y = y
    return self
end

function base:getY()
    return self.y
end

function base:setPos( x, y )
    self.x = x self.y = y
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

function base:mousemoved( _, x, y, dx, dy )
    self.collided = pointRectCollide( x, y, self:getRect() )
end

function base:mousepressed( _, _, _, button )
    if button == 1 and self.collided then
        self.clicked = true
    end
end

function base:mousereleased( _, _, _, button )
    if button == 1 and self.clicked then
        if self.onClicked then self.onClicked() end
        self.clicked = false
    end
end

function base:update( dt )
    if self.collided and self.onCollided then
        self.onCollided()
    end
end

return base