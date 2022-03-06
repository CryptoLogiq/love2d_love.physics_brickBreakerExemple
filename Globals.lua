--Globals Love
lg = love.graphics
li = love.image
isDown = love.keyboard.isDown

Font = {}
for n=10, 50, 2 do
  Font[n] = love.graphics.newFont(n)
end

screen = {x=0,y=0,w=0,h=0,cx=0,cy=0}
function screen.getDimensions()
  screen.w, screen.h = lg.getDimensions()
  screen.cx, screen.cy = screen.w/2, screen.h/2
end
screen.getDimensions()
--

mouse = love.mouse
mouse.x,mouse.y = screen.cx, screen.cy
mouse.w, mouse.h = 1, 1
function mouse:getPositionXY()
  mouse.x, mouse.y = mouse.getPosition()
end
--
function mouse:setPosition(x,y)
  mouse.x, mouse.y = x, y
end
--

function pprint(pTable, allPrint) -- print table all level
  for k, v in pairs(pTable) do
    if type(v) == "table" and allPrint then
      pprint(v, allPrint)
    else
      print(tostring(k) .. " : " .. tostring(v))
    end
  end
end
--