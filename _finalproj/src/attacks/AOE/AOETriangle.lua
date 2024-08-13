AOETriangle = Class { __includes = AOE }

function AOETriangle:init(def)
    AOE.init(self, def) --define the first vertex x,y values with the default x y initiatlization that AOEs have
    self.x2 = def.x2    --2nd vertex x coordinate
    self.y2 = def.y2    --2nd vertex y coordinate
    self.x3 = def.x3    --3rd vertex x coordinate
    self.y3 = def.y3    --3rd vertex y coordinate
end

function AOETriangle:hits(target)
    --if snapshot active and hitbox collides with AOE, deducts damage from target HP and returns true; else, returns false

    if self.snapshot then
        --calculate AOE triangle area
        local tri0 = self.x * (self.y2 - self.y3) + self.x2 * (self.y3 - self.y) + self.x3 * (self.y - self.y2)
        --calculate area of 3 triangles forming vertices with target hitbox and 2 of the original AOE vertices
        local thx = target.hitx
        local thy = target.hity
        local tri1 = thx * (self.y2 - self.y3) + self.x2 * (self.y3 - thy) + self.x3 * (thy - self.y2) --replacing x y
        local tri2 = self.x * (thy - self.y3) + thx * (self.y3 - self.y) + self.x3 * (self.y - thy) --replacing x2 y2
        local tri3 = self.x * (self.y2 - thy) + self.x2 * (thy - self.y) + thx * (self.y - self.y2) --replacing x3 y3
        --if these two are equal, then the hitbox  is in the AOE
        if math.abs(tri0) >= math.abs(tri1) + math.abs(tri2) + math.abs(tri3) then
            target.health = target.health - self.damage
            self.snapshot = false
            return true
        end
    end

    return false
end

function AOETriangle:update(dt)
    AOE.update(self, dt)
end

function AOETriangle:render()
    --render a warning telegraph (mechanical indicator standard), then the actual AOE (visual flair w sfx when i have assets)
    --damage should snapshot the moment the telegraph disappears
    if self.teleactive then
        love.graphics.setColor(255, 100, 0, 200)

        love.graphics.polygon("fill", self.x, self.y, self.x2, self.y2, self.x3, self.y3)

        love.graphics.setColor(255, 0, 0, 200)
        love.graphics.polygon("line", self.x, self.y, self.x2, self.y2, self.x3, self.y3)
    end
end
