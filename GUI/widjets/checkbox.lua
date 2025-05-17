local checkbox = {
    variants = {},
    variant_size = 20,
    childs = {},
    act_variants = {},
}
setmetatable( checkbox, require( "GUI.widjets.base" ) )
checkbox.__index = checkbox

function checkbox:init()
    for index, variant in ipairs( self.variants ) do
        local b = { x=self.x+8, y=self.y+(self.variant_size+5)*(index-1)+8, w=self.variant_size, h=self.variant_size}
        setmetatable( b, require( "GUI.widjets.button" ) )
        b.__index = b

        b.onClicked = function ()
            if self.act_variants[index] then
                self.act_variants[index] = false
            else
                self.act_variants[index] = true
            end

            if self.onSwitched then self.onSwitched( index, self.variants[index] ) end
        end

        table.insert( self.childs, b )
    end
end

function checkbox:getVariants()
    return self.act_variants
end

return checkbox