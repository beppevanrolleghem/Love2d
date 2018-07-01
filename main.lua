--- vars ...
wheight = 0
wwidth = 0
x = 0
y = 0
bdt = 1
offset = 0
xArray={}
yArray={}
nStraal = 0





--- objects ...
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


balls = {
  xcors = {},
  ycors = {},
  dia = {},
  segs = {},
  spesh = {},
  mov = {},
  spd = {},
  tresh = {},
  tmptresh = {},
  update = function(self, val, len)
    for i,v in ipairs(self.dia) do
      if (val > self.tresh[i])then
        self.tresh[i] = self.tresh[i] +self.tmptresh[i]
        self.dia[i] = math.sin((val/self.spesh[i]) * math.pi) * len
        if self.mov[i] >= .5 then
          self.xcors[i] = self.xcors[i] + math.random(-1 * self.spd[i], self.spd[i])
          self.ycors[i] = self.ycors[i] + math.random(-1 * self.spd[i], self.spd[i])
          if self.xcors[i] > wwidth then self.xcors[i] = wwidth end
          if self.ycors[i] > wheight then self.ycors[i] = wheight end
          if self.xcors[i] < 0 then self.xcors[i] = 0 end
          if self.ycors[i] < 0 then self.ycors[i] = 0 end
        end
      end
    end
  end
}



---homeFunctions ...




---mainFunctions ...

--loadVars
function love.load()
  r = 1
  g = 1
  b = 1
  a = .8
  nStraal = 30
  arrayOfPoints = {}
  canvas = love.graphics.newCanvas(800, 600)
  wheight = love.graphics.getHeight()
  wwidth = love.graphics.getWidth()
  love.graphics.setCanvas(canvas)
       love.graphics.clear()
       love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
  bdt = 1
  for i=1,150 do
    balls.xcors[i] = math.random(0, wwidth)
    balls.ycors[i] = math.random(0, wheight)
    balls.dia[i] = math.random(0,50)
    balls.segs[i] = math.random(0,500)
    balls.spesh[i] = math.random(0,300)
    balls.mov[i] = math.random(0,1)
    balls.spd[i] = math.random(0,20)
    balls.tresh[i] = math.random(0,.001)
    balls.tmptresh[i] = balls.tresh[i]
  end
end




--- updateVars
function love.update(dt)
  player.physics:Update()
  x = x + 1
  if (x > wwidth) then
    offset = x - wwidth
  end
  y=math.sin(bdt * math.pi)*wheight/2 + wheight/2
  r = math.cos((bdt / 10) * math.pi)
  g = math.sin((bdt / 10) * math.pi)
  b = math.cos((bdt / 100)* math.pi)
  balls:update(bdt, nStraal)
  bdt = bdt + dt
  print(bdt)
  ---[[
  ---[[print("r: "..r)
---[[  print("g: "..g)
---[[  print("b: "..b)]]
  table.insert(xArray, x)
  table.insert(yArray, y)

  if (table.getn(arrayOfPoints) < (wwidth *2)) then
    table.insert(arrayOfPoints, x)
    table.insert(arrayOfPoints, y)
  else
    table.remove(arrayOfPoints, 2)
    table.insert(arrayOfPoints, x)
    table.insert(arrayOfPoints, y)
    for i,v in ipairs(arrayOfPoints) do
      if (math.fmod(i, 2) == 0) then
        arrayOfPoints[i-1] = arrayOfPoints[i-1] - offset
      end
    end
  end
end





---darwFunction
function love.draw()
  love.graphics.setBlendMode("alpha", "premultiplied")

  --print("height = " .. wheight .. "\nwidth = " .. wwidth .. "\nx = " .. x .. "\ny = " .. y .. "\nframes: " .. bdt)
  love.graphics.draw(canvas)
  love.graphics.setBackgroundColor(r, g, b, a)
  love.graphics.setColor(1-r, 1-b, 1-g, 1)
  for i,v in ipairs(balls.xcors) do
    love.graphics.circle("fill", balls.xcors[i], balls.ycors[i], balls.dia[i], balls.segs[i])
  end
  --[[ EXPERIMENT OF ME TRYING TO GET A SCROLLING SINUS FUNCTION (when x reaches edge of screen, screen starts scrolling)
  if (not (table.getn(arrayOfPoints) < 4)) and (math.fmod(table.getn(arrayOfPoints), 2) == 0) then
    love.graphics.line(arrayOfPoints)
  end]]



end
