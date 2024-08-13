AOECircle = Class { __includes = AOE }

function AOECircle:init(def)
    AOE.init(self, def)
    self.radius = def.radius --circle radius
end

function AOECircle:hits(target)
    --if snapshot active and hitbox collides with AOE, deducts damage from target HP and returns true; else, returns false

    if self.snapshot then
        --distance equation from player coordinate
        local centerx = self.x
        local centery = self.y
        if ((target.hitx - centerx) ^ 2 + (target.hity - centery) ^ 2) ^ (1 / 2) < self.radius then
            target.health = target.health - self.damage
            self.snapshot = false
            return true --if radius < distance, then true
        end
    end

    return false
end

function AOECircle:update(dt)
    AOE.update(self, dt)
end

function AOECircle:render()
    --render a warning telegraph (mechanical indicator standard), then the actual AOE (visual flair w sfx when i have assets)
    --damage should snapshot the moment the telegraph disappears
    if self.teleactive then
        love.graphics.setColor(255, 100, 0, 200)
        love.graphics.circle("fill", self.x, self.y, self.radius)
        love.graphics.setColor(255, 0, 0, 200)
        love.graphics.circle("line", self.x, self.y, self.radius)
    end
end
