--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    

end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')
    else
        self.entity:changeState('idle')
    end

    if love.keyboard.wasPressed('space') and (self.entity.holding == false) then
        self.entity:changeState('swing-sword')
    end

    --if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    --    self.entity:changeState('swing-sword')
    --end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        if self.entity.direction == 'left' then
            
            -- temporarily adjust position into the wall, since bumping pushes outward
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-left')
                end
            end

            -- readjust
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-right')
                end
            end

            -- readjust
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            
            -- temporarily adjust position
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-up')
                end
            end

            -- readjust
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            
            -- temporarily adjust position
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-down')
                end
            end

            -- readjust
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end



    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
       
        local grabboxX, grabboxY, grabboxWidth, grabboxHeight
        if self.entity.direction == 'left' then
            grabboxWidth = 8
            grabboxHeight = 16
            grabboxX = self.entity.x - grabboxWidth
            grabboxY = self.entity.y + 2
        elseif self.entity.direction == 'right' then
            grabboxWidth = 8
            grabboxHeight = 16
            grabboxX = self.entity.x + self.entity.width
            grabboxY = self.entity.y + 2
        elseif self.entity.direction == 'up' then
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

        --self.entity:changeState('potidle')
        

        --define a hitbox, check if hitbox hits pots on enter, if so, enter hold pot 
                -- check if hitbox collides with any entities in the scene
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if self.dungeon.currentRoom.objects[k].type == 'pot' and self.grabHitbox:collides(object) then
                self.entity.holding = true
                self.entity:changeState('liftpot')
--                self.entity:changeAnimation('potlift-' .. self.entity.direction)
            end
        end



    end

--[[     if self.entity.currentAnimName ==('potlift-' .. self.entity.direction) and 
    (self.entity.currentAnimation.timesPlayed > 0 or
    self.entity.currentAnimation:getCurrentFrame()%3 ==0) then

        self.entity:changeState('potidle')
    end ]]

end