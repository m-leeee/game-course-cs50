Stage1 = Class{}

function Stage1:init(def)
    self.player = def.player

    -- container we could use to store rooms in a static dungeon, but unused here
    --self.rooms = {}

    -- current room we're operating in
    --self.currentRoom = Room(self.player)    


    self.boss = Shiba{
        animations = ENTITY_DEFS['shiba'].animations,
        --walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
                
        width = 30,--256,
        height = 30,--256,
        hboxw = 12,
        hboxh = 12,


        health = 5,
        maxhealth = 10,

                -- rendering and collision offset for spaced sprites
        offsetY = 5



    }

    self.boss.stateMachine = StateMachine {
        --['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        --['idle'] = function() return PlayerIdleState(self.player, self.dungeon) end,
        --['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        ['default'] =  function() return EntityIdleState(self.boss) end
    }
    self.boss:changeState('default')
    self.boss:changeAnimation('idle')

    self.stage = Stage{player = self.player}
    self.aoe1 = AOE{
        shape = 'circle', 
    
        --coordinates 
        x = VIRTUAL_WIDTH / 3,
        y = VIRTUAL_HEIGHT / 3,
    
        radius = 10, --circle and donut
        inradius = 0, --donut only
        xlength = 0, --box only
        ylength = 0, --box only
    
        damage = 2, --how much damage this AOE will inflict
        snaptime = 3, -- time telegraph will show/when the snapshot occurs
        --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
        player = self.player


    }
    self.aoe2 = AOE{
        shape = 'box',
    
        --coordinates 
        x = VIRTUAL_WIDTH / 3,
        y = VIRTUAL_HEIGHT / 3 + 50,
    
        radius = 0, --circle and donut
        inradius = 0, --donut only
        xlength = 10, --box only
        ylength = 10, --box only
    
        damage = 2, --how much damage this AOE will inflict
        snaptime = 3, -- time telegraph will show/when the snapshot occurs
        --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
        player = self.player


    }

    self.aoe3 = AOE{
        shape = 'donut',
    
        --coordinates 
        x = VIRTUAL_WIDTH / 3 + 100,
        y = VIRTUAL_HEIGHT / 3,
    
        radius = 11, --circle and donut
        inradius = 6, --donut only
        xlength = 0, --box only
        ylength = 0, --box only
    
        damage = 2, --how much damage this AOE will inflict
        snaptime = 3, -- time telegraph will show/when the snapshot occurs
        --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
        player = self.player


    }

    self.stage:addEnemy(self.boss)
    self.stage:addAOE(self.aoe1)
    self.stage:addAOE(self.aoe2)
    self.stage:addAOE(self.aoe3)

    Timer.every(.1, function() --moving function, might want to update
    self.aoe3.x = self.aoe3.x+1
    end)
end

function Stage1:update(dt)
    self.boss:update(dt)
    self.stage:update(dt)


    if math.random(100) == 1 then
                        
        -- instantiate snail, declaring in advance so we can pass it into state machine
        local aoespawn
        aoespawn = AOE{
            shape = 'circle', 
        
            --coordinates 
            x = self.player.x,
            y = self.player.y,
        
            radius = 20, --circle and donut
            inradius = 0, --donut only
            xlength = 0, --box only
            ylength = 0, --box only
        
            damage = 2, --how much damage this AOE will inflict
            snaptime = 1, -- time telegraph will show/when the snapshot occurs
            --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
            player = self.player
    
        }

        self.stage:addAOE(aoespawn)
    end

    --self.aoe1:update(dt)
    --self.aoe2:update(dt)
    --self.aoe3:update(dt)

--[[     -- pause updating if we're in the middle of shifting
    if not self.shifting then    
        self.currentRoom:update(dt)
    else
        
        -- still update the player animation if we're shifting rooms
        self.player.currentAnimation:update(dt)
    end ]]
end

function Stage1:render()
    self.boss:render()
    self.stage:render()
    --self.aoe1:render()
    --self.aoe2:render()
    --self.aoe3:render()

--[[     -- translate the camera if we're actively shifting
    if self.shifting then
        love.graphics.translate(-math.floor(self.cameraX), -math.floor(self.cameraY))
    end

    self.currentRoom:render()
    
    if self.nextRoom then
        self.nextRoom:render()
    end ]]


end
