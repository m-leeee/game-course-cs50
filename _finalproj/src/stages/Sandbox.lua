Sandbox = Class{}
-- This class is meant as a testing space for features 

function Sandbox:init(def)
    self.player = def.player


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
    self.aoe4 = AOE{
        shape = 'triangle', 
    
        --coordinates 
        x = 150,
        y = 50,
    
        radius = 10, --circle and donut
        inradius = 0, --donut only
        xlength = 0, --box only
        ylength = 0, --box only
        x2 = 170, --triangle only
        y2 = 171, --triangle only   
        x3 = 130, --triangle only
        y3 = 180, --triangle only
    
        damage = 2, --how much damage this AOE will inflict
        snaptime = 3, -- time telegraph will show/when the snapshot occurs
        --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
        player = self.player


    }

    self.aoe5 = AOEwithEffect{
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
        player = self.player,
        effect = 'knockback', --'knockback', debuff name 
        degree = -90, --direction for knockback
        duration = .3 -- effect duration if applicable

    }

    self.bullet1 = BossBullet{
        boss = self.boss,
        --self.dungeon = dungeon 
        degree = 0, -- direction of the bullet, 0 assumes +Y directionality, 90 assumes -X, -180 to 180
        radius = 2,
        damage = 1,

        --self.traveled = 0 --for projectiles with a limit 
        speed = 10

    }
    self.bullet2 = BossBullet{
        boss = self.boss,
        --self.dungeon = dungeon 
        degree = 90, -- direction of the bullet, 0 assumes +Y directionality, 90 assumes -X, -180 to 180
        radius = 2,
        damage = 1,

        --self.traveled = 0 --for projectiles with a limit 
        speed = 10

    }
    self.bullet3 = BossBullet{
        boss = self.boss,
        --self.dungeon = dungeon 
        degree = -180, -- direction of the bullet, 0 assumes +Y directionality, 90 assumes -X, -180 to 180
        radius = 2,
        damage = 1,

        --self.traveled = 0 --for projectiles with a limit 
        speed = 10

    }
    --table.insert(self.boss.bullets, self.bullet1)
    --self.boss:addBullet(self.bullet1)
    --self.boss:addBullet(self.bullet2)
   -- self.boss:addBullet(self.bullet3)
    self.stage:addEnemy(self.boss)
    self.stage:addAOE(self.aoe1)
    --self.stage:addAOE(self.aoe2)
    --self.stage:addAOE(self.aoe3)
    --self.stage:addAOE(self.aoe4)
    self.stage:addAOE(self.aoe5)

    Timer.every(.1, function() --moving function, might want to update
    self.aoe3.x = self.aoe3.x+1
    end)
end

function Sandbox:update(dt)
    self.stage:update(dt)


    if math.random(100) == 102 then
                        
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

function Sandbox:render()
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
