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
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
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

        love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius)

end