local BallManager = {}

ball = {}

function BallManager.new(WorldAttachement, x, y, mass, radius, restitution, vx, vy, name, state, color)
  local function update(self,dt)
    self.x, self.y = self.body:getPosition()
    --
    if self.state == "wait" then
      self.body:setAwake(false)
      self.x = pad.x
      self.y = (pad.y-(pad.h/2) )-(self.radius+2)
    elseif self.state == "launch" then
      local angle = self.body:getAngularVelocity( )
      self.vx = math.cos(angle)
      self.vy = math.sin(angle)
      if self.body:isTouching(pad.body) then
        self.body:setLinearVelocity(0,0)
        angle = math.angle(pad.x+pad.offset.x,pad.y+pad.offset.y   ,self.x,self.y)
        self.vx = math.cos(angle)
        self.vy = math.sin(angle)
        self.body:applyLinearImpulse(self.vx * self.speed, self.vy * self.speed)
      elseif self.body:isTouching(wallTrigger.body) then
        self.state = "wait"
      end
    end
    --
    self.body:setPosition(self.x, self.y)
  end
  --
  local function draw(self)
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.print(self.state, self.x, self.y - 25)
    love.graphics.setColor(1,1,1,1)
  end
  --
  local ball = {update=update, draw=draw,world=WorldAttachement, x=x, y=y,speed=450, vx=vx, vy=vy, name=name, state=state,mass=mass, restitution=restitution,restitution_def=restitution, radius=radius, color=color or {1,1,1,1}}
  ball.body = love.physics.newBody(WorldAttachement, x, y, "dynamic")
  ball.body:setMass(mass)
  ball.body:setAwake(false)
  ball.shape = love.physics.newCircleShape(radius)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape)
  ball.fixture:setRestitution(restitution)    -- make it bouncy 0.4, return full force 1
  ball.fixture:setUserData(name)
  --
  return ball
  --
end
--


function BallManager.load()
  ball = BallManager.new(World, 400,300, 10, 12, 1, 1, -1, "ball", "wait", {0,1,0.5,1}) -- (x,y)
end
--

function BallManager.update(dt)
  ball:update(dt)
end
--

function BallManager.draw()
  ball:draw()
end
--

function BallManager.keypressed(key)
  if key == "space" then
    if ball.state == "wait" then
      ball.state = "launch"
      ball.body:setAwake(true)
      ball.body:setPosition(ball.x, ball.y)
      ball.body:applyLinearImpulse(ball.vx * ball.speed, ball.vy * ball.speed)
    end
  end
end
--

function BallManager.mousepressed(x,y,button)
end
--

return BallManager