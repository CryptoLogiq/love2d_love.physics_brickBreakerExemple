local PadManager = {}

pad = {}


function PadManager.new(WorldAttachement, mode,x,y,w,h, vx, vy,bodytype, name, color)

  local function update(self, dt)
    self.x, self.y = self.body:getPosition()
    --
    if love.keyboard.isDown("left") and love.keyboard.isDown("right") then
      -- nothing
    elseif love.keyboard.isDown("left") then
      self.x = self.x - self.vx * dt
    elseif love.keyboard.isDown("right") then
      self.x = self.x + self.vx * dt
    end

    if self.x - self.ox <= 0 then
      self.x = self.ox
    elseif self.x + self.ox >= love.graphics.getWidth() then
      self.x = love.graphics.getWidth() - self.ox
    end
    --
    self.body:setPosition(self.x, self.y)
  end
  --

  local function draw(self)
    love.graphics.setColor(self.color)
    love.graphics.polygon(self.mode, self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.setColor(1,1,1,1)
  end
  --

  local pad = {mode=mode, x=x, y=y, w=w, h=h, ox=w/2,oy=h/2, vx=vx, vy=vy, update=update, draw=draw, color=color or {1,1,1,1}}
  pad.body = love.physics.newBody(WorldAttachement, x, y, bodytype)
  pad.body:setMass(10)
--  pad.body:setGravityScale(-1)
  pad.shape = love.physics.newRectangleShape(w, h)
  pad.fixture = love.physics.newFixture(pad.body, pad.shape)
  pad.fixture:setUserData(name)
  -- for contrrols rebond
  pad.offset={x=0, y=h+20}

  return pad
end
--

function PadManager.load()
  pad = PadManager.new(World, "fill", 400, 585, 150, 20, 500, 0, "kinematic", "pad")
end
--

function PadManager.update(dt)
  pad:update(dt)
end
--

function PadManager.draw()
  pad:draw()
end
--

function PadManager.keypressed(key)
end
--

function PadManager.mousepressed(x,y,button)
end
--

return PadManager