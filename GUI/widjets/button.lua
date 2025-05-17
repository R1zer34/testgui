local button = {
    icon = nil,
}
setmetatable(button, require( "GUI.widjets.base" ) )
button.__index = button

function button:setIcon( icon )
    self.icon = icon
    return self
end

function button:getIcon()
    return self.icon
end

return button