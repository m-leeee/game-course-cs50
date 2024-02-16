--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    local direction = self.entity.direction
    local grabboxX, grabboxY, grabboxWidth, grabboxHeight

    if direction == 'left' then
        grabboxWidth = 8
        grabboxHeight = 16
        grabboxX = self.entity.x - grabboxWidth
        grabboxY = self.entity.y + 2
    elseif direction == 'right' then
        grabboxWidth = 8
        grabboxHeight = 16
        grabboxX = self.entity.x + self.entity.width
        grabboxY = self.entity.y + 2
    elseif direction == 'up' then
        grabboxWidth = 16
        grabboxHeight = 8
        grabboxX = self.entity.x
        grabboxY = self.entity.y - grabboxHeight
    else
        grabboxWidth = 16
        grabboxHeight = 8
        grabboxX = self.entity.x
        grabboxY = self.entity.y + self.entity.height
    end

    -- separate hitbox for the player's sword; will only be active during this state
    self.grabHitbox = Hitbox(grabboxX, grabboxY, grabboxWidth, grabboxHeight)
    
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') and (self.entity.holding == false) then
        self.entity:changeState('swing-sword')
    end
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        

        --self.entity:changeState('potidle')
        

        --define a hitbox, check if hitbox hits pots on enter, if so, enter hold pot 
                -- check if hitbox collides with any entities in the scene
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if self.dungeon.currentRoom.objects[k].type == 'pot' and self.grabHitbox:collides(object) then
                self.entity.holding = true
                self.entity:changeState('liftpot')
                --self.entity:changeAnimation('potlift-' .. self.entity.direction)

            end
        end



    end
--[[     if self.entity.currentAnimName ==('potlift-' .. self.entity.direction) and 
    (self.entity.currentAnimation.timesPlayed > 0 or
    self.entity.currentAnimation:getCurrentFrame()%3 ==0) then

        self.entity:changeState('potidle')
    end ]]

end