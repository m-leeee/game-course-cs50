AOEDonut = Class{__includes = AOE}

function AOEDonut:init(def)
    AOE.init(self, def)
    self.radius = def.radius --circle and donut
    self.inradius = def.inradius --donut only
end


function AOEDonut:hits(target)
    --if snapshot active and hitbox collides with AOE, deducts damage from target HP and returns true; else, returns false

    if self.snapshot then


        local centerx = self.x
        local centery = self.y
        --check if inside the donut hole
        if ((target.hitx - centerx)^2 + (target.hity - centery)^2)^(1/2) < self.inradius then
            return false --if inside inradius, then false
        end
        --check if in the greater circle
        if ((target.hitx - centerx)^2 + (target.hity - centery)^2)^(1/2) < self.radius then
            target.health = target.health - self.damage
            self.snapshot= false
            return true -- ir radius < distance, then true
        end


    end

    return false

end

function AOEDonut:update(dt)
    AOE.update(self,dt)

end

function AOEDonut:render()
    --render a warning telegraph (mechanical indicator standard), then the actual AOE (visual flair w sfx when i have assets)
    --damage should snapshot the moment the telegraph disappears 
    if self.teleactive then
        love.graphics.setColor(255, 100, 0, 200)

        --not sure if this is gonna look right with the built in love2d graphics tools but this will be addressed later if so with real assets or something idk
        love.graphics.circle("fill", self.x, self.y, self.radius)
        love.graphics.setColor(0, 0, 0, 225)
        love.graphics.circle("fill", self.x, self.y, self.inradius)

        love.graphics.setColor(255, 0, 0, 200)
        love.graphics.circle("line", self.x, self.y, self.radius)
        love.graphics.setColor(255, 0, 0, 225)
        love.graphics.circle("line", self.x, self.y, self.inradius)



    end

end