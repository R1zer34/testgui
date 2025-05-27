local utils = require "GUI.utils"

local switcher = utils.createWidjet( {
    state = false,
    setW = nil, setH = nil, setSize = nil,
    dir = true
} )

function switcher:init()
    if self.dir then
        self.w = 68
        self.h = 28
    else
        self.w = 28
        self.h = 68
    end
end

function switcher:setState( state )
    self.state = state
    return self
end

function switcher:getState()
    return self.state
end

function switcher:swithState()
    if self.state then
        self.state = false
    else
        self.state = true
    end
    return self
end

function switcher:setDirection( direction )
    self.dir = direction
    self:init()
    return self
end

function switcher:getDirection()
    return self.dir
end

function switcher:swithDirection()
    if self.dir then
        self.dir = false
    else
        self.dir = true
    end
    self:init()
    return self
end

function switcher:mousepressed( _, _, _, button )
    if button == 1 and self.collided then
        self.clicked = true
        self.grabed = true
        self:swithState()
        if self.onSwitched then self.onSwitched( self.state ) end
    end
end

return switcher