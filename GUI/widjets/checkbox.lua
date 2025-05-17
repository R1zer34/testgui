local checkbox = {
    variants = {},
    variant_size = 20,
    childs = {},
    act_variant = 1
}
setmetatable( checkbox, require( "GUI.widjets.base" ) )
checkbox.__index = checkbox

function checkbox:init()
    for index, variant in ipairs( self.variants ) do
        local b = { x=self.x, y=self.y+(self.variant_size+5)*index, w=self.variant_size, h=self.variant_size}
        setmetatable( b, require( "GUI.widjets.button" ) )
        b.__index = b

        b.onClicked = function ()
            self.act_variant = index
        end

        table.insert( self.childs, b )
    end
end

function checkbox:setDefaultVariant( index )
    self.act_variant = index
    return self
end

function checkbox:getDefaultVariant()
    return self.act_variant
end

return checkbox