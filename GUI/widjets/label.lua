local label = {
    text = "",
}
setmetatable( label, require("GUI.widjets.base") )
label.__index = label

function label:settext( text )
    self.text = text
    return self
end

function label:getTiele()
    return self.text
end

return label