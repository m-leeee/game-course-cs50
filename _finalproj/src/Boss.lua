Boss = Class{__includes = Entity}

function Boss:init(def)
    Entity.init(self, def)
end

function Boss:update(dt)
    Entity.update(self, dt)
end


function Boss:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Boss:render()
    Entity.render(self)
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1,1,1,1)--(34/255, 34/255, 34/255, 1)
    love.graphics.printf(self.hppercent*100 .. '%', self.x, self.y-10, 100, 'left')
end