local BrickManager = {}

Map = {}

Lst_Bricks = {}


local function updateBrick(self, dt)
  self.x, self.y = self.body:getPosition()
  --
  if self.life >= 1 and self.body:isTouching(ball.body) then
    print("contact with brick")
    self.life = self.life - 1
  end
  --
  if self.life <= 0 then
    if self.fallen then
      if self.y + self.oy >= love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.oy
        self.remove = true
      end
    else
      self.fixture:setFilterData(0, 65535, 0) -- change group collision 1 to 0
      self.body:setType("dynamic")
      self.body:applyLinearImpulse(0,200)
      self.fallen = true
    end
  end
end
--

local function drawBrick(self)
  love.graphics.setColor(self.color)
  love.graphics.polygon(self.mode, self.body:getWorldPoints(self.shape:getPoints()))
  love.graphics.setColor(1,1,1,1)
end
--

function BrickManager.newBrick(world, x,y,w,h,ox,oy, life, color)
  local brick = {x=x+ox,y=y+oy,w=w,h=h,ox=ox,oy=oy, fallen= false, world=world,draw=drawBrick, update=updateBrick, life=life or 1, color = color or {1,1,1,1}, mode="fill"} -- brick body need center pos : x+ox and y+oy
  --
  brick.body=love.physics.newBody(world, brick.x, brick.y, "kinematic") -- body gameobjet
  brick.body:setMass(100) -- for gravity...
  --
  brick.shape=love.physics.newRectangleShape(brick.w,brick.h) -- shape forme (collider)
  --
  brick.fixture= love.physics.newFixture(brick.body, brick.shape) -- attach body witch alls shapes
  brick.fixture:setUserData("brick") -- user ID for contacts list events
  --
  table.insert(Lst_Bricks, brick)
  return brick
end
--


function BrickManager.loadMap(world, lig, col)
  local mapW = love.graphics.getWidth()-(10*2)-2 -- 10*2 walls
  local cellW = mapW / col
  --
  local mapH = (love.graphics.getHeight()-10) - (love.graphics.getHeight()-(pad.y+pad.oy))
  local cellH = 20
  local nbMaxLig = math.floor(mapH / cellH)
  --
  Map = {lig=math.min(lig, nbMaxLig), col=col, cellW=cellW, cellH=cellH, }
  --
  local startx = 10
  local starty = 10
  local x = startx
  local y = starty
  local w = cellW
  local h = cellH
  local ox=w/2
  local oy=h/2
  --
  for l=1, Map.lig do
    Map[l]={}
    for c=1, Map.col do
      local life = 1
      Map[l][c]= BrickManager.newBrick(world, x+1, y+1, w-2, h-2, ox, oy, life)
      x=x+w
    end
    x=startx
    y=y+h
  end
  --
  pprint(Map)
end
--

function BrickManager.load()
  BrickManager.loadMap(World, 3, 20)
end
--

function BrickManager.update(dt)
  for n=#Lst_Bricks, 1, -1 do
    local brick=Lst_Bricks[n]
    brick:update(dt)
    if brick.remove then
      table.remove(Lst_Bricks, n)
    end
  end
end
--

function BrickManager.draw()
  for n=#Lst_Bricks, 1, -1 do
    local brick=Lst_Bricks[n]
    brick:draw()
  end
end
--

function BrickManager.keypressed(key)
end
--

function BrickManager.mousepressed(x,y,button)
end
--

return BrickManager