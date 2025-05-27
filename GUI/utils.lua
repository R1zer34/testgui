local utils = {}

function utils.pointRectCollide( px, py, rx, ry, rw, rh )
    return (px>rx and px<rx+rw and py>ry and py<ry+rh)
end

function utils.mouseRectCollide( x, y, w, h)
    return utils.pointRectCollide( love.mouse.getX(), love.mouse.getY(), x, y, w, h )
end

function utils.pointCircleCollide( px, py, cx, cy, cr)
    return math.abs( px-cx ) < cr and math.abs( py-cy ) < cr
end

function utils.mouseCircleCollide( cx, cy, cr )
    return utils.pointCircleCollide( love.mouse.getX(), love.mouse.getY(), cx, cy, cr )
end

function utils.rectInRect( px, py, pw, ph, rw, rh )
    return px + (pw-rw)/2, py + (ph-rh)/2
end

function utils.hex (value, a)
  hexVal = string.sub(value, 2)
  hexVal = string.upper(hexVal)
  if #hexVal == 3 then
    f = hexVal:sub(1,1)
    s = hexVal:sub(2,2)
    t = hexVal:sub(3,3)
    hexVal = f..f..s..s..t..t
  end
  val = {}

  for i=1, #hexVal do
    char = hexVal:sub(i, i)
    if char == "0" then
      val[i] = tonumber(char)+1
    elseif char == "1" then
      val[i] = tonumber(char)+1
    elseif char == "2" then
      val[i] = tonumber(char)+1
    elseif char == "3" then
      val[i] = tonumber(char)+1
    elseif char == "4" then
      val[i] = tonumber(char)+1
    elseif char == "5" then
      val[i] = tonumber(char)+1
    elseif char == "6" then
      val[i] = tonumber(char)+1
    elseif char == "7" then
      val[i] = tonumber(char)+1
    elseif char == "8" then
      val[i] = tonumber(char)+1
    elseif char == "9" then
      val[i] = tonumber(char)+1
    elseif char == "A" then
      val[i] = 11
    elseif char == "B" then
      val[i] = 12
    elseif char == "C" then
      val[i] = 13
    elseif char == "D" then
      val[i] = 14
    elseif char == "E" then
      val[i] = 15
    elseif char == "F" then
      val[i] = 16
    end
  end

  r = r or 255
  g = g or 255
  b = b or 255
  a = a or 255
  r = val[1] * 16 + val[2]
  g = val[3] * 16 + val[4]
  b = val[5] * 16 + val[6]

  return {r/255, g/255, b/255, a}
end

function utils.funcsForChilds( widjet )
  widjet.old_mousemoved = widjet.mousemoved
  function widjet:mousemoved( _, x, y, _, _ )
    widjet:old_mousemoved( _, x, y, _, _ )
    for _, child in ipairs( widjet.childs ) do
      child:mousemoved( _, x, y, _, _ )
    end
  end

  widjet.old_mousepressed = widjet.mousepressed
  function widjet:mousepressed( _, _, _, button )
    widjet:old_mousepressed( _, _, _, button )
    for _, child in ipairs( widjet.childs ) do
      child:mousepressed( _, _, _, button )
    end
  end

  widjet.old_mousereleased = widjet.mousereleased
  function widjet:mousereleased( _, _, _, button )
    widjet:old_mousereleased( _, _, _, button )
    for _, child in ipairs( widjet.childs ) do
      child:mousereleased( _, _, _, button )
    end
  end

  widjet.old_update = widjet.update
  function widjet:update( dt )
    widjet:old_update( dt )
    for _, child in ipairs( widjet.childs ) do
      child:update( dt )
    end
  end
end

function utils.createWidjet( data )
  local widjet = data or {}
  setmetatable( widjet, require( "GUI.widjets.base" ) )
  widjet.__index = widjet

  if widjet.childs then
    utils.funcsForChilds( widjet )
  end

  return widjet
end

function utils.getGrid( w, h, tw, th )
  local canvas = love.graphics.newCanvas( w, h )
  love.graphics.setCanvas( canvas )
  for y = 0, h/th, 1 do
    love.graphics.line( 0, y*th, w, y*th )
  end
  for x = 0, w/tw, 1 do
      love.graphics.line( x*tw, 0, x*tw, h )
  end
  love.graphics.setCanvas()
  return love.graphics.newImage( canvas:newImageData( ) )
end

return utils