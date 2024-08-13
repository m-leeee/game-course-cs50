AOEBox = Class { __includes = AOE }

function AOEBox:init(def)
    AOE.init(self, def)
    self.xlength = def.xlength --box only
    self.ylength = def.ylength --box only
end

function AOEBox:hits(target)
    --if snapshot active and hitbox collides with AOE, deducts damage from target HP and returns true; else, returns false

    if self.snapshot then
        --compare hitbox to corners of box
        if (self.x < target.hitx) and (self.x + self.xlength > target.hitx) and (self.y < target.hity) and (self.y + self.ylength > target.hity) then
            target.health = target.health - self.damage
            self.snapshot = false
            return true --check lowerxlimit < x < upperxlimit and lowerylimit< y < upperylimit
        end
    end

    return false
end

function AOEBox:update(dt)
    AOE.update(self, dt)
end

function AOEBox:render()
    --render a warning telegraph (mechanical indicator standard), then the actual AOE (visual flair w sfx when i have assets)
    --damage should snapshot the moment the telegraph disappears
    if self.teleactive then
        love.graphics.setColor(255, 100, 0, 200)
        love.graphics.rectangle("fill", self.x, self.y, self.xlength, self.ylength)

        love.graphics.setColor(255, 0, 0, 200)
        love.graphics.rectangle("line", self.x, self.y, self.xlength, self.ylength)
    end
end
