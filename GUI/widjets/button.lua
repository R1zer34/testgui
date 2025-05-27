local utils = require "GUI.utils"

local button = utils.createWidjet( {
    icon = nil,
} )

function button:setIcon( icon )
    self.icon = icon
    return self
end

function button:getIcon()
    return self.icon
end

return button