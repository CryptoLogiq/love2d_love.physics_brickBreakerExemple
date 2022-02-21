local WorldManager = {currentWorld=nil}

World = {}


function WorldManager.beginContact(a, b, coll)
end
--

function WorldManager.endContact(a, b, coll)
  -- print( a:getUserData(), b:getUserData() )
end
--

function WorldManager.preSolve(a, b, coll)
end
--

function WorldManager.postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
--

function WorldManager.load()
  World = love.physics.newWorld(0, 100, true)
  World:setCallbacks(WorldManager.beginContact, WorldManager.endContact, WorldManager.preSolve, WorldManager.postSolve)
  --
  WorldManager.currentWorld = World
end
--

function WorldManager.update(dt)
  WorldManager.currentWorld:update(dt)
end
--

function WorldManager.draw()
end
--

function WorldManager.keypressed(key)
end
--

function WorldManager.mousepressed(x,y,button)
end
--

return WorldManager