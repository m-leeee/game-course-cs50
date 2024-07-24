AOE = Class{}

function AOE:init(def)
    self.shape = def.shape --'circle', 'box','donut', and 'triangle' as options 
    
    --coordinates 
    self.x = def.x
    self.y = def.y

    self.radius = def.radius --circle and donut
    self.inradius = def.inradius --donut only
    self.xlength = def.xlength --box only
    self.ylength = def.ylength --box only
    self.x2 = def.x2 --triangle only
    self.y2 = def.y2 --triangle only   
    self.x3 = def.x3 --triangle only
    self.y3 = def.y3 --triangle only

    self.damage = def.damage --how much damage this AOE will inflict
    self.teleactive = true --is the telegraph visual active
    self.snaptime = def.snaptime -- time telegraph will show/when the snapshot occurs
    self.snapshot = false -- is damage snapshot active 
    --self.persisttime = def.persisttime -- how long persistent AOE lasts. set as 0 if its a 1 tick snap. --maybe don't want to implement this 

    self.timepast = 0 -- time tracker  
    self.done = false -- check for deletion

    self.player = def.player


    Timer.after(self.snaptime, function()
        self.teleactive = false
        if not self.done then
            self.snapshot = true
        end
        self.done = true
    end)
    --for persistent AOE, use Timer.every
end


function AOE:hits(target)
    --if snapshot active and hitbox collides with AOE, deducts damage from target HP and returns true; else, returns false

    if self.snapshot then
        if self.shape == 'circle' then
            --distance equation from player coordinate
            local centerx = self.x + self.radius
            local centery = self.y + self.radius
            if ((target.hitx - centerx)^2 + (target.hity - centery)^2)^(1/2) < self.radius then
                target.health = target.health - self.damage
                self.snapshot= false
                return true --if radius < distance, then true
            end
        end


        if self.shape == 'box' then
            --compare hitbox to corners of box 
            if (self.x < target.hitx) and (self.x + self.xlength > target.hitx) and (self.y < target.hity) and (self.y + self.ylength > target.hity) then
                target.health = target.health - self.damage
                self.snapshot= false
                return true --check lowerxlimit < x < upperxlimit and lowerylimit< y < upperylimit
            end
        end

        if self.shape == 'donut' then
            local centerx = self.x + self.radius
            local centery = self.y + self.radius
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

        if self.shape == 'triangle' then

            --calculate AOE triangle area
            local tri0 = self.x*(self.y2-self.y3) + self.x2*(self.y3-self.y) + self.x3*(self.y-self.y2)
            --calculate area of 3 triangles forming vertices with target hitbox and 2 of the original AOE vertices
            local thx = target.hitx
            local thy = target.hity
            local tri1 = thx*(self.y2-self.y3) + self.x2*(self.y3-thy) + self.x3*(thy-self.y2) --replacing x y 
            local tri2 = self.x*(thy-self.y3) + thx*(self.y3-self.y) + self.x3*(self.y-thy) --replacing x2 y2
            local tri3 = self.x*(self.y2-thy) + self.x2*(thy-self.y) + thx*(self.y-self.y2) --replacing x3 y3
            --if these two are equal, then the hitbox  is in the AOE 
            if math.abs(tri0) >= math.abs(tri1)+math.abs(tri2)+math.abs(tri3) then
                target.health = target.health - self.damage
                self.snapshot= false
                return true
            end
        end
    end

    return false

end



function AOE:update(dt)
    --self.timepast = self.timepast + dt -- !!! WILL WANT TO USE TIMER (This is just a quick implementation for the time being because i dont remember how to use the timer in lib)
--[[     if self.timepast > self.snaptime then
        self.teleactive = false
        if not self.done then
            self.snapshot = true
        end
        self.done = true
    end ]]


--[[     if self.timepast > self.snaptime + self.persisttime then -- Another timer implementation in the (near) future.... 
        self.snapshot = false
        self.done = true
    end ]] --changing my mind on the persistent aoe implementation so this is irrelevant for now
    if self.snapshot then
        self:hits(self.player)
    end

end

function AOE:render()
    --render a warning telegraph (mechanical indicator standard), then the actual AOE (visual flair w sfx when i have assets)
    --damage should snapshot the moment the telegraph disappears 
    if self.teleactive then
        
        love.graphics.setColor(255, 100, 0, 200)

        if self.shape == 'circle' then
            love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius)
        end

        if self.shape == 'box' then
            love.graphics.rectangle("fill", self.x, self.y, self.xlength, self.ylength)
        end

        if self.shape == 'donut' then
            --not sure if this is gonna look right with the built in love2d graphics tools but this will be addressed later if so with real assets or something idk
            love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius)
            love.graphics.setColor(0, 0, 0, 225)
            love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.inradius)
        end

        if self.shape == 'triangle' then
            love.graphics.polygon("fill", self.x,self.y, self.x2,self.y2, self.x3,self.y3 )
        end

    end

end