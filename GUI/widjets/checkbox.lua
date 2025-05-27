local utils = require "GUI.utils"

local checkbox = utils.createWidjet( {
    variants = {},
    box_size = 20,
    childs = {},
    act_variants = {},
} )

function checkbox:init()
    for index, variant in ipairs( self.variants ) do
        local b = { x=self.x+self.box_size/4, y=self.y+(self.box_size+self.box_size/4)*(index-1)+8, w=self.box_size, h=self.box_size}
        setmetatable( b, require( "GUI.widjets.button" ) )
        b.__index = b

        b.onClicked = function ()
            if self.act_variants[index] then
                self.act_variants[index] = false
                if self.onSwitched then self.onSwitched( index, variant, false ) end
            else
                self.act_variants[index] = true
                if self.onSwitched then self.onSwitched( index, variant, true ) end
            end
        end

        table.insert( self.childs, b )
    end
end

function checkbox:getVariants()
    return self.act_variants
end

function checkbox:setBoxSize( size )
    self.box_size = size
    for index, child in ipairs( self.childs ) do
       child:setSize( size, size )
       child:setPos( self.x+self.box_size/4, self.y+(self.box_size+self.box_size/4)*(index-1)+8 )
    end
    return self
end

function checkbox:getBoxSize()
    return self.box_size
end

return checkbox