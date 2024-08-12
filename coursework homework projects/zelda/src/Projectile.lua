--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon 

    self.x = player.x
    self.y = player.y + player.height/2 - 8
    self.direction = player.direction

    self.texture = 'tiles'
    self.type = 'pot'
    self.frame = 14
    self. width = 16
    self.height = 16
    self.solid = true
    self.state = 'unbroken'
    self.states = {['unbroken'] = {frame = 14}, ['broken'] = {frame = 52}}

    self.traveled = 0

end

function Projectile:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end


function Projectile:update(dt)
    --change x or y in the given direction 
    -- if collide then ... 
    if self.direction == 'left' then
        self.x = self.x - PROJECTILE_SPEED * dt
    elseif self.direction == 'right' then
        self.x = self.x + PROJECTILE_SPEED * dt
    elseif self.direction == 'up' then
        self.y = self.y - PROJECTILE_SPEED * dt
    elseif self.direction == 'down' then
        self.y = self.y + PROJECTILE_SPEED * dt
    end

    self.traveled = self.traveled + dt

    if (self.x + self.width <= MAP_RENDER_OFFSET_X + TILE_SIZE) or
     (self.x >= VIRTUAL_WIDTH - TILE_SIZE * 2) or
     (self.y + self. height <= MAP_RENDER_OFFSET_Y + TILE_SIZE) or
     (self.y >= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE)) or
     (self.traveled * PROJECTILE_SPEED >= 4 * TILE_SIZE)then
        self.state = 'broken'
        gSounds['hit-player']:play()

    end

    
    

end

function Projectile:render(adjacentOffsetX,adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end