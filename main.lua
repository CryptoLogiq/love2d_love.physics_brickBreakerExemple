
require("Globals")
require("Maths")

WorldManager = require("WorldManager")
BallManager = require("BallManager")
PadManager = require("PadManager")
BrickManager = require("BrickManager")
WallManager = require("WallManager")

function love.load()
  WorldManager.load() -- load world environnement (gravity, etc)
  WallManager.load() -- load Walls body static (CCD)
  BallManager.load() -- load ball body dynamic
  PadManager.load() -- load pad body kinematic
  BrickManager.load() -- load brick body kinematic (change to dynamic when is break)
end
--

function love.update(dt)
  WorldManager.update(dt) -- update all physics and collisions events
  WallManager.update(dt) -- my logic
  BallManager.update(dt) -- my logic
  PadManager.update(dt) -- my logic
  BrickManager.update(dt) -- my logic
end
--

function love.draw()
  WorldManager.draw() -- debug only if necessarry
  BallManager.draw() -- my draw
  WallManager.draw() -- my draw
  PadManager.draw() -- my draw
  BrickManager.draw() -- my draw
end
--

function love.keypressed(key)
  BallManager.keypressed(key) -- space for launch
end
--