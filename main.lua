
--- objects ...
wheight = 0
wwidth = 0
player = {
  properties = {
    name = "PlayerName",
    sprite = "NaN"
  },
  size = {
    width = 5,
    height = 10
  },
  physics = {
    gravity = false,
    rate = 0.1,
    grate = 0.98,
    pos = {
      x = 50,
      y = 50,
      z = 1
    },
    vel = {
      x = 1,
      y = 1,
      z = 1
    },
    Addvel = function(self, vx, vy, vz)
      self.vel.x = self.vel.x + vx
      self.vel.y = self.vel.y + vy
      self.vel.z = self.vel.z + vz
    end,
    Stopvel = function(self)
      self.vel.x = 1
      self.vel.y = 1
      self.vel.z = 1
    end,
    Update = function(self)
      self.pos.x = self.pos.x * self.vel.x
      self.pos.y = self.pos.y * self.vel.y
      self.pos.z = self.pos.z * self.vel.z
      if(self.gravity) then self.vel.y = self.vel.y + grate end
      if(self.vel.x < 1) then self.vel.x = self.vel.x + self.rate end
      if(self.vel.y < 1) then self.vel.y = self.vel.y + self.rate end
      if(self.vel.z < 1) then self.vel.z = self.vel.z + self.rate end
      if(self.vel.x > 1) then self.vel.x = self.vel.x - self.rate end
      if(self.vel.y > 1) then self.vel.y = self.vel.y - self.rate end
      if(self.vel.z > 1) then self.vel.z = self.vel.z - self.rate end
    end,
    SetPosition = function(self, x, y, z)
      self.pos.x = x
      self.pos.y = y
      self.pos.z = z
      self.vel.x = 1
      self.vel.y = 1
      self.vel.z = 1
    end
  }
}

function love.load()
  wheight = love.graphics.getHeight()
  wwidth = love.graphics.getWidth()
end
x = 0
y = 0

function love.update(dt)
  player.physics:Update()
  y = math.sin(dt) * wheight
  if (x < wwidth) then x = x + 1 else x = 0 end
end


function love.draw()
  love.graphics.setColor(255, 100, 100, 100)
  love.graphics.line(x, y, x+1, y+1)
  love.graphics.print("height = " .. wheight .. "\nwidth = " .. wwidth .. "\nx = " .. x .. "\ny = " .. y)
end
