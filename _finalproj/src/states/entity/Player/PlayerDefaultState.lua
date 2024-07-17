PlayerDefaultState = Class{__includes = EntityIdleState}

function PlayerDefaultState:enter(params)
    self.entity:changeAnimation('idle')
end

function PlayerDefaultState:update(dt)
   --[[  if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end ]]

    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-down')
    --else
        
        --self.entity:changeState('idle')
    end

    if love.keyboard.isDown('x') then
        if self.entity.gcdrolled == false then
            local bullet = PlayerBullet(self.entity)
    
            table.insert(self.entity.bullets, bullet)

            self.entity.gcdrolled = true --caps the number of attack actions you can send 
            Timer.after(self.entity.gcdspeed, function() 
                self.entity.gcdrolled = false
            end)
        end
    
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