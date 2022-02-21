local WallManager = {}

Lst_Walls = {}

wallTrigger = {}

function WallManager.add(WorldAttachement, mode,x,y,w,h, vx, vy,bodytype, name, color)

  local function update(self, dt)
  end
  --

  local function draw(self)
    love.graphics.setColor(self.color)
    love.graphics.polygon(self.mode, self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.setColor(1,1,1,1)
  end
  --

  local wall = {mode=mode, x=x, y=y, w=w, h=h, ox=w/2,oy=h/2, vx=vx, vy=vy, update=update, draw=draw, color=color or {1,1,1,1}}
  wall.body = love.physics.newBody(WorldAttachement, x, y, bodytype)
  wall.shape = love.physics.newRectangleShape(w, h)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)
  wall.fixture:setUserData(name)

  table.insert(Lst_Walls, wall)
  return wall
end
--

function WallManager.load()
  WallManager.add(World, "fill", 0, 300, 20, 620, 0, 0, "static", "wall", {1,0,1,1})
  WallManager.add(World, "fill", 800, 300, 20, 620, 0, 0, "static", "wall", {1,0,1,1})
  WallManager.add(World, "fill", 400, 0, 820, 20, 0, 0, "static", "wall", {1,0,1,1})
  wallTrigger = WallManager.add(World, "fill", 400, 600, 820, 20, 0, 0, "static", "wall", {0,0,0.6,1})
end
--

function WallManager.update(dt)
  for n=1, #Lst_Walls do
    local wall = Lst_Walls[n]
    wall:update(dt)
  end
end
--

function WallManager.draw()
  for n=1, #Lst_Walls do
    local wall = Lst_Walls[n]
    wall:draw()
  end
end
--

function WallManager.keypressed(key)
end
--

function WallManager.mousepressed(x,y,button)
end
--

return WallManager