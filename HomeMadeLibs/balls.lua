
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
