PlayerHoldPotIdleState = Class{__includes = PlayerIdleState}

function PlayerHoldPotIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    self.entity:changeAnimation('potidle-' .. self.entity.direction)
    self.entity.holding = true
end

function PlayerHoldPotIdleState:update(dt)
    --if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
    --   love.keyboard.isDown('up') or love.keyboard.isDown('down') then
    --    self.entity:changeState('walk')
    --end

    --if love.keyboard.wasPressed('space') and (self.entity.holding == false) then
    --    self.entity:changeState('swing-sword')
    --end
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if self.dungeon.currentRoom.objects[k].type == 'pot' then
            
            object.x = self.entity.x
            object.y = self.entity.y-8
        end
    end




end