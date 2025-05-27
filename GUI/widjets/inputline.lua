local utils = require "GUI.utils"
local utf8 = require "utf8"
love.keyboard.setKeyRepeat(true)

local inputline = utils.createWidjet({
    edited_text = "",
    text = "",
    w=125,
    h=30,
    limit = 999,
})

function inputline:textinput( _, t )
    if not self.activated or self.grabed or utf8.len(self.edited_text) >= self.limit then return end
    self.edited_text = self.edited_text .. t
end

function inputline:keypressed( _, key )
    if not self.activated or self.grabed then return end
    if key == "backspace" then
        local byteoffset = utf8.offset(self.edited_text, -1)

        if byteoffset then
            self.edited_text = string.sub( self.edited_text, 1, byteoffset - 1 )
        end
    elseif key == "return" then
        self.activated = false
        if self.onDisActivated then self.onDisActivated() end
        self.text = self.edited_text
    end
end

function inputline:setText( text )
    self.edited_text = text
    self.text = text
    return self
end

function inputline:getText( )
    return self.text
end

function inputline:getEditedText( )
    return self.edited_text
end

return inputline