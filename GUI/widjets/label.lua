local utils = require "GUI.utils"

local label = utils.createWidjet( {
    text = "",
} )

function label:settext( text )
    self.text = text
    return self
end

function label:getTiele()
    return self.text
end

return label