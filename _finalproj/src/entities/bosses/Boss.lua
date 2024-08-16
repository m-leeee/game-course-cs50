--[[
    This is the base class for all Bosses.
]]

Boss = Class { __includes = Entity }

function Boss:init(def)
    Entity.init(self, def)
    self.bullets = {}
    self.phase = 0
    self.hitradius = def.hitradius
end

function Boss:update(dt)
    Entity.update(self, dt)

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end

    for k, bullet in pairs(self.bullets) do
        if bullet.done then
            table.remove(self.bullets, k)
        end
    end
end

function Boss:addBullet(bullet)
    table.insert(self.bullets, bullet)
end

function Boss:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2

    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Boss:render()
    Entity.render(self)
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 1) --(34/255, 34/255, 34/255, 1)
    local hptruncate = math.floor(self.hppercent * 1000)/10
    love.graphics.printf(hptruncate .. '%', self.x, self.y - 10, 100, 'left')

    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end
end
