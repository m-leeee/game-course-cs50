Stage1 = Class{}

function Stage1:init(def)
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


        health = 60,
        maxhealth = 60,

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
    
    self.stage:addEnemy(self.boss)

end

function Stage1:update(dt)
    self.stage:update(dt)

    if self.boss.phase == 1 then

        Timer.every(2, function()
            local bullet1= BossBullet{
                boss = self.boss,
    
                degree = 0,
                radius = 5,
                damage = 1,
        
    
                speed = 40
            }
            local bullet2= BossBullet{
                boss = self.boss,
    
                degree = 45,
                radius = 5,
                damage = 1,
        
                speed = 40
            }
            local bullet3= BossBullet{
                boss = self.boss,
    
                degree = 90,
                radius = 5,
                damage = 1,
        
    
                speed = 40
            }
            local bullet4= BossBullet{
                boss = self.boss,
    
                degree = 135,
                radius = 5,
                damage = 1,
        
    
                speed = 40
            }
            local bullet5= BossBullet{
                boss = self.boss,
    
                degree = 180,
                radius = 5,
                damage = 1,
        
                speed = 40
            }
            local bullet6= BossBullet{
                boss = self.boss,
    
                degree = -45,
                radius = 5,
                damage = 1,
        
    
                speed = 40
            }
            local bullet7= BossBullet{
                boss = self.boss,
    
                degree = -90,
                radius = 5,
                damage = 1,
        
                speed = 40
            }
            local bullet8= BossBullet{
                boss = self.boss,
    
                degree = -135,
                radius = 5,
                damage = 1,
        
    
                speed = 40
            }
    
            self.boss:addBullet(bullet1)
            self.boss:addBullet(bullet2)
            self.boss:addBullet(bullet3)
            self.boss:addBullet(bullet4)
            self.boss:addBullet(bullet5)
            self.boss:addBullet(bullet6)
            self.boss:addBullet(bullet7)
            self.boss:addBullet(bullet8)
    
        end)

        
    end
    if self.boss.phase == 2 then
    end
    if self.boss.phase == 3 then
    end
    if self.boss.phase == 4 then
    end
    if self.boss.phase == 5 then
    end


    -- generate AOEs & projectiles depending on the phase and mechanics, then load them into Stage's appropriate tables 

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


end

function Stage1:render()
    self.stage:render()


end
