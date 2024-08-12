


PlayerLiftPotState = Class{__includes = PlayerIdleState}

function PlayerLiftPotState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    --self.entity:changeAnimation('potlift-' .. self.entity.direction)

    self.entity:changeAnimation('potlift-' .. self.entity.direction)
end

function PlayerLiftPotState:update(dt)

    

    --if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
    --   love.keyboard.isDown('up') or love.keyboard.isDown('down') then
    --    self.entity:changeState('walk')
    --end

    --if love.keyboard.wasPressed('space') and (self.entity.holding == false) then
    --    self.entity:changeState('swing-sword')
    --end

    if self.entity.currentAnimName ==('potlift-' .. self.entity.direction) and 
    (self.entity.currentAnimation.timesPlayed > 0 or
    self.entity.currentAnimation:getCurrentFrame()%3 ==0) then

        self.entity:changeState('potidle')
    end





end