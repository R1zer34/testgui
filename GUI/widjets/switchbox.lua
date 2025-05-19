local switchbox = {
    circ_size = 20,
    act_variant = 1,
    variants = {},
    childs = {},
}
setmetatable( switchbox, require( "GUI.widjets.base" ) )
switchbox.__index = switchbox

function switchbox:init()
    for index, variant in ipairs( self.variants ) do
        local b = { x=self.x+self.circ_size/4, y=self.y+(self.circ_size+self.circ_size/4)*(index-1)+8, w=self.circ_size, h=self.circ_size}
        setmetatable( b, require( "GUI.widjets.button" ) )
        b.__index = b

        b.onClicked = function ()
            self.act_variant = index
            if self.onSwitched then self.onSwitched( index, self.variants[index] ) end
        end

        table.insert( self.childs, b )
    end
end

function switchbox:setCircSize( size )
    self.circ_size = size
    for index, child in ipairs( self.childs ) do
       child:setSize( size, size )
       child:setPos( self.x+self.circ_size/4, self.y+(self.circ_size+self.circ_size/4)*(index-1)+8 )
    end
    return self
end

function switchbox:getBoxSize()
    return self.circ_size
end

return switchbox