PlayerMelee = Class{}

function PlayerMelee:init(player)
    self.player = player

    self.x = player.hitx
    self.y = player.hity



    self.radius = 20


    self.damage = 1

    --self.traveled = 0 --for projectiles with a limit 
    self.done = false --check for deletion
    self.active = false
    self.showaoe = false
end

function PlayerMelee:hits(target)
    --Implementing under the assumption all boss hitboxes will be circular. Should this design decision change, this needs to be updated. 
    --if the distance between player center (melee origin) and boss hitbox center < radius of both then hits 
        local centerx = self.x
        local centery = self.y
        if ((target.hitx - centerx) ^ 2 + (target.hity - centery) ^ 2) ^ (1 / 2) < self.radius+ target.hitradius then
            target.health = target.health - self.damage
        end
        self.active = false
end


function PlayerMelee:update(dt)

    --collision logic in Stage 
    if self.active then
        self.showaoe = true
        Timer.after(.2, function()
            self.showaoe = false
        end)
    end

end

function PlayerMelee:render()
        --this is a temporary implementation to show the radius of the melee attack
        --ideally, this will be replaced with a player animation instead
        if self.showaoe == true then
            love.graphics.setColor(100, 100, 225, 200)
            love.graphics.circle("fill", self.x, self.y, self.radius) 
        end

end