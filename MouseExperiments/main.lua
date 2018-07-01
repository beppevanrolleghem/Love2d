clippy = {
  image = love.graphics.newImage("sprites/Clippy.png"),
  x = 50,
  y = 50,
  r = 0,
  sx = .2,
  sy = .2,
  ox = 0,
  oy = 0,
  kx = 0,
  ky = 0,
  speed = 5,
  name = "Clippy",
  getWidth = function(self)
    return self.image:getWidth() * self.sx
  end,
  getHeight = function(self)
    return self.image:getHeight() * self.sy
  end,
  update = function(self)
    if self.x < 0 then self.x = 0 end
    if self.y < 0 then self.y = 0 end
    if self.x > love.graphics.getWidth() then self.x = love.graphics.getWidth() end
    if self.y > love.graphics.getHeight() then self.y = love.graphics.getHeight() end
    if self.speed < 0 then self.speed = 0 end
  end
}

globalFrames = 0
bgR = 0
bgG = 0
bgB = 0


function love.load(arg)
  print("loading")
  clippy.name="LOADEDclippy"
  print("loaded")
end

function love.update(dt)
  globalFrames = globalFrames + dt
  bgR = math.sin(globalFrames / 6 * math.pi)
  bgG = math.cos(globalFrames / 9 * math.pi)
  bgB = math.sin(globalFrames/12 * math.pi)
  clippy:update()
end

function love.draw()
  love.graphics.draw(clippy.image, clippy.x,clippy.y,clippy.r,clippy.sx,clippy.sy,clippy.ox,clippy.oy,clippy.kx,clippy.ky)
  love.graphics.printf(clippy.name, clippy.x, clippy.y+clippy:getHeight(), clippy:getWidth(), "center")
  love.graphics.setBackgroundColor(bgR, bgG, bgB, 1)
end



function love.keypressed( key )
  print("key "..key.." has been pressed")
  if key == "escape" then
    love.event.quit(1)
  end
  if key == "left" or key == "q" then
    clippy.x = clippy.x - clippy.speed
  end
  if key == "right" or key == "d" then
    clippy.x = clippy.x + clippy.speed
  end
  if key == "up" or key == "z" then
    clippy.y = clippy.y - clippy.speed
  end
  if key == "down" or key == "s" then
    clippy.y = clippy.y + clippy.speed
  end
  if key == "a" or key == "shift" then
    clippy.speed = clippy.speed + 5
  end
  if key == "e" or key == "ctrl" then
    clippy.speed = clippy.speed - 5
  end
  if key == "escape" then
    love.event.quit(1)
  end
end
