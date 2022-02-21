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

function pprint(pTable, allPrint)
  for k, v in pairs(pTable) do
    if type(v) == "table" and allPrint then
      pprint(v)
    else
      print(tostring(k) .. " : " .. tostring(v))
    end
  end
end
--

function newTimer(pSpeed)
  local timer = {c=0,d=10,s=pSpeed or 60}
  --
  function timer:reset()
    self.c = 0
  end
  --
  function timer:update(dt)
    self.c = self.c + (self.s * dt)
    if self.c >= self.d then
      timer:reset()
      return true
    else
      return false
    end
  end
  --
  return timer
end
--


function newImg(pimg)
  local newImg = {imgdata=li.newImageData(pimg)}
  newImg.image=lg.newImage(newImg.imgdata)
  newImg.w, newImg.h = newImg.image:getDimensions()
  newImg.ox, newImg.oy = newImg.w/2, newImg.h/2
  newImg.x, newImg.y = 0, 0
  return newImg
end
--

function newSpriteSheet(pimg, lig, col, spritesheetOffset)
  local newSprSheet = newImg(pimg)
  newSprSheet.lig, newSprSheet.col = lig, col
  newSprSheet.cellw = newSprSheet.w / newSprSheet.col
  newSprSheet.cellh = newSprSheet.h / newSprSheet.lig
  newSprSheet.cellox, newSprSheet.celloy = newSprSheet.cellw/2, newSprSheet.cellh/2
  newSprSheet.sprites = newQuad(newSprSheet, spritesheetOffset)
  return newSprSheet
end
--

function newQuad(spritesheet, spritesheetOffset)
  local sprTab = {spritesheet=spritesheet, spritesheetOffset=spritesheetOffset}
  --
  local x = 0
  local y = 0
  local w = spritesheet.cellw
  local h = spritesheet.cellh
  local ox = spritesheet.cellox
  local oy = spritesheet.celloy
  --
  for l=1, spritesheet.lig do
    for c=1, spritesheet.col do
      local offsetx = 0
      if spritesheetOffset then
        local search = true
        local posx = x
        while search do
          posx = posx + 1
          local r, g, b, a = spritesheetOffset.imgdata:getPixel( posx, y+oy )
          if a ~= 0 then
            search = false
            offsetx = posx - (x+ox)
            print("posx : "..tostring(posx), "offsetx : "..tostring(offsetx), "\t", r,g,b,a,"\n")
          end
        end
      else
        offsetx = 0
      end
      local newQuad = {imgdata=spritesheet.imgdata,image=spritesheet.image,x=x,y=y,w=w,h=h,offsetx=offsetx,ox=w/2,oy=h/2,quad=lg.newQuad(x,y,w,h,spritesheet.w,spritesheet.h)}
      table.insert(sprTab, newQuad)
      x=x+w
    end
    x=0
    y=y+h
  end
  --
  return sprTab
end
--


function newButton(style, string,  x,y,w,h, action)
  local box = {x=x,y=y,x_def=x,y_def=y,w=w,h=h,action=action}
  --
  box.font = Font[18]
  box.string = {text=love.graphics.newText(box.font, string)}
  function box:updateText()
    box.string.w = box.string.text:getWidth()
    box.string.h = box.string.text:getHeight()
    box.string.ox, box.string.oy = box.string.w/2, box.string.h/2
  end
  box:updateText()
  --
  if box.w == 0 then box.w = box.string.w + 2 end
  if box.h == 0 then box.h = box.string.h + 2 end
  --
  box.ox = box.w/2
  box.oy = box.h/2
  box.cx = box.x + box.ox
  box.cy = box.y + box.oy
  --
  if style == "center" then
    box.x = box.x_def - box.ox
    box.cx = box.x + box.ox
  end
  --
  function box:update(dt)
    if style == "center" then
      box.x = box.x_def - box.ox
      box.cx = box.x + box.ox
    end
    box:updateText()
  end
  --
  function box:collide(arg)
    if CheckCollision(mouse.x,mouse.y,mouse.w,mouse.h,    self.x, self.y,self.w,self.h) then
      self:action(arg)
      return true
    end
  end
  --
  function box:draw(pColor)
    if pColor then love.graphics.setColor(pColor) end
    lg.rectangle("line", self.x, self.y, self.w, self.h)
    lg.draw(self.string.text, self.cx, self.cy,0,1,1,self.string.ox,self.string.oy)
    --
    love.graphics.setColor(1,1,1,1)
  end
  --
  return box
end
--