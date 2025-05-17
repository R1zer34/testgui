local Gui = {
    funcs_handels = {"update", "keypressed", "mousemoved", "mousepressed", "textinput", "keyreleased", "mousereleased"},
    layers = {},
    style = require("GUI.style"),
}

function Gui:newLayer()
    local layer = {
        widjets = {},
        visible = true,
    }

    for _, func in ipairs( Gui.funcs_handels ) do
        layer[func] = function ( ... )
            if layer.visible then
                for _, widjet in ipairs( layer.widjets ) do
                    if widjet.visible and widjet[func] then 
                        widjet[func]( widjet, ... ) 
                        if widjet.childs then
                            for index, child in ipairs(widjet.childs) do
                                if child[func] then child[func]( child, ...) end
                            end
                        end
                    end
                end
            end
        end
    end

    table.insert( Gui.layers, layer )
    return layer
end

function Gui:newWidjet( layer, widjet_name, data )
    local widjet = data or {}
    widjet.name = widjet_name
    table.insert( layer.widjets, widjet )
    setmetatable( widjet, require("GUI.widjets." .. widjet_name ) )
    if widjet.init then widjet:init() end
    return widjet
end

function Gui:draw()
    for _, layer in ipairs( Gui.layers ) do
        if layer.visible then
            for _, widjet in ipairs( layer.widjets ) do
                if Gui.style[widjet.name] then
                    Gui.style[widjet.name](widjet)
                else
                    Gui.style["base"](widjet)
                end
            end
        end
    end
end

for _, func in ipairs( Gui.funcs_handels ) do
    Gui[func] = function ( Gui, ... )
        for _, layer in ipairs( Gui.layers ) do
            layer[func]( layer, ... )
        end
    end
end

return Gui