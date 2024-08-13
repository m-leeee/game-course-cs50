BossBullet = Class {}

function BossBullet:init(def)
    self.boss = def.boss

    self.x = self.boss.x + self.boss.width / 2
    self.y = self.boss.y + self.boss.height / 2
    self.degree = def.degree -- direction of the bullet, 0 is +Y, 90 is +X

    self.radius = def.radius
    self.width = self.radius * 2
    self.height = self.radius * 2

    self.damage = def.damage
    --self.traveled = 0 --for projectiles with a limit
    self.speed = def.speed
    self.done = false --check for deletion
end

function BossBullet:collides(target)
    local centerx = self.x + self.radius
    local centery = self.y + self.radius
    if ((target.hitx - centerx) ^ 2 + (target.hity - centery) ^ 2) ^ (1 / 2) < self.radius then
        target.health = target.health - self.damage
        self.done = true
        return true --if radius < distance, then true
    end

    return false
end

function BossBullet:update(dt)
    --position update

    local rad = math.rad(self.degree)
    self.y = self.y + math.cos(rad) * self.speed * dt
    self.x = self.x + math.sin(rad) * self.speed * dt

    --self.traveled = self.traveled + dt --for projectiles with a limit. this may or may not be implemented later.

    if (self.x + self.width <= 0) or
        (self.x >= VIRTUAL_WIDTH) or
        (self.y + self.height <= 0) or
        (self.y >= VIRTUAL_HEIGHT) then
        self.done = true
    end
end

function BossBullet:render() --(adjacentOffsetX,adjacentOffsetY)
    love.graphics.setColor(100, 0, 0, 225)
    love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius)
end
