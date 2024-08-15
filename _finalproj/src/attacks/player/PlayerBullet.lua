PlayerBullet = Class{}

function PlayerBullet:init(player)
    self.player = player

    self.x = player.hitx
    self.y = player.y

    self. width = 6
    self.height = 6


    self.radius = 3
    self.damage = 1

    --self.traveled = 0 --for projectiles with a limit 
    self.speed = 60
    self.done = false --check for deletion

end

function PlayerBullet:collides(target)
        --Implementing under the assumption all boss hitboxes will be circular. Should this design decision change, this needs to be updated. 
    --if the distance between player center (melee origin) and boss hitbox center < radius of both then hits 
        local centerx = self.x
        local centery = self.y
        if ((target.hitx - centerx) ^ 2 + (target.hity - centery) ^ 2) ^ (1 / 2) < self.radius+ target.hitradius then
            target.health = target.health - self.damage
            return true
        end
        --Collision logic gets checked in Stage 

end


function PlayerBullet:update(dt)


    self.y = self.y - self.speed * dt --position update 

    --self.traveled = self.traveled + dt 

    if (self.x + self.width <= 0) or
     (self.x >= VIRTUAL_WIDTH) or
     (self.y + self. height <= 0) or
     (self.y >= VIRTUAL_HEIGHT) then
        self.done = true
    end


end

function PlayerBullet:render()
        
        love.graphics.setColor(100, 100, 225, 200)

        love.graphics.circle("fill", self.x, self.y, self.radius)

end