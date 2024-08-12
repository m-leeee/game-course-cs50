PlayerMelee = Class{}

function PlayerMelee:init(player)
    self.player = player

    self.x = player.hitx
    self.y = player.hity



    self.radius = 20


    self.damage = 1

    --self.traveled = 0 --for projectiles with a limit 
    self.done = false --check for deletion

end

function PlayerMelee:hits(target)

    --TODO:
end


function PlayerMelee:update(dt)




end

function PlayerMelee:render()--(adjacentOffsetX,adjacentOffsetY)
--[[     love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY) ]]
        
        love.graphics.setColor(100, 100, 225, 200)

        love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius) --FIXME: this is the bullet render

end