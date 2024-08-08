PlayerKnockbackState = Class{__includes = BaseState}

function PlayerKnockbackState:init(player)
    self.player = player
    self.direction = 0 --give this in degrees, similar to BossBullet. radians are not real to me
    self.duration = 0 --how many seconds to KB for 

    
    self.speed = 300
    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0
    --self.player:changeAnimation('idle') --TODO: update animation when i have it 
    
    self.timercheck = 0

end


function PlayerKnockbackState:update(dt)
    self.direction = self.player.knockbacktracker[1]
    self.duration = self.player.knockbacktracker[2]
    self.rad = math.rad(self.direction)
    self.player.y = self.player.y + math.cos(self.rad) * self.speed * dt
    self.player.x = self.player.x + math.sin(self.rad) * self.speed * dt
    
    if self.timercheck == 0 then
        self.timercheck = 1
        Timer.after(self.duration,function()--self.duration, function() 
            self.player:changeState('default')
        end)
    end

    --if love.keyboard.wasPressed('space') and (self.entity.holding == false) then
    --    self.entity:changeState('swing-sword')
    --end

    --if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    --    self.entity:changeState('swing-sword')
    --end

    -- perform base collision detection against walls
    --EntityWalkState.update(self, dt)


--[[     if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        
        if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
            self.bumped = true
        end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

        if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then 
            self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.entity.y + self.entity.height >= bottomEdge then
            self.entity.y = bottomEdge - self.entity.height
            self.bumped = true
        end
    end
 ]]

end

function PlayerKnockbackState:render()
    local anim = self.player.currentAnimation
    --love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --    math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    love.graphics.draw(gTextures[anim.texture],gFrames[anim.texture][anim:getCurrentFrame()],self.player.x,self.player.y,
        0,.1,.1,1,1)
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end