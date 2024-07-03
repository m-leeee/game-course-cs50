

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 256,
        height = 256,
        hboxw = 12,
        hboxh = 12,

        -- one heart == 2 health
        health = 6,
        maxhealth = 7,

        -- rendering and collision offset for spaced sprites
        offsetY = 5
    }

    self.stage = Stage1{self.player}

    --self.dungeon = Dungeon(self.player)
    --self.currentRoom = Room(self.player)
    -- need to put stuff for Stage here 

    self.player.stateMachine = StateMachine {
        --['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        --['idle'] = function() return PlayerIdleState(self.player, self.dungeon) end,
        --['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        ['default'] =  function() return PlayerDefaultState(self.player) end
    }
    self.player:changeState('default')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)
    self.stage:update(dt)
    --self.dungeon:update(dt)
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    --self.dungeon:render()

    self.stage:render()
    self.player:render()


    love.graphics.pop()

    -- draw player hearts, top of screen
    local healthLeft = self.player.health
    local heartFrame = 1

    for i = 1, 3 do
        if healthLeft > 1 then
            heartFrame = 5
        elseif healthLeft == 1 then
            heartFrame = 3
        else
            heartFrame = 1
        end

        --love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame],
        --    (i - 1) * (TILE_SIZE + 1), 2)
        
        healthLeft = healthLeft - 2
    end
end