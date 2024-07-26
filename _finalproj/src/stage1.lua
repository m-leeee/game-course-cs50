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

    self.mech1counter = 1
    self.mech3counter = 1
    self.mech4counter = 1

end

function Stage1:mech1()
    --TENNIS BALL BARRAGE 
    local t=1
    if self.mech1counter == 1 then
        self.mech1counter = self.mech1counter + 1
        Timer.after(t, function()
            
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

        self.mech1counter = 1
        end)
    end

end

function Stage1:mech2() --FIXME:TODO:
    --TRAFFIC
    local aoe1= AOE{
        shape = 'box',
    
        --coordinates 
        x = 0,
        y = 0,
    
        radius = 0, --circle and donut
        inradius = 0, --donut only
        xlength = VIRTUAL_WIDTH, --box only
        ylength = VIRTUAL_HEIGHT/5, --box only
    
        damage = 5, --how much damage this AOE will inflict
        snaptime = .5, -- time telegraph will show/when the snapshot occurs
        --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold 
        player = self.player


    }
    self.stage:addAOE(aoe1)
end

function Stage1:mech3()
    --FRISBEE BOMB TOSS
    local t = 1.3
    if self.mech3counter == 1 then
        Timer.after(t, function()
            local aoe1= AOE{
                shape = 'circle',
            
                --coordinates 
                x = self.player.hitx,
                y = self.player.hity,
            
                radius = 20, --circle and donut
            
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player

            }
            self.stage:addAOE(aoe1)
        end)
        self.mech3counter = self.mech3counter + 1
    elseif self.mech3counter == 2 then
        Timer.after(t*2, function()
            local aoe1= AOE{
                shape = 'circle',
            
                --coordinates 
                x = self.player.hitx,
                y = self.player.hity,
            
                radius = 20, --circle and donut
            
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)
        end)
        self.mech3counter = self.mech3counter + 1
    elseif self.mech3counter == 3 then
        local xx = self.player.hitx
        local yy = self.player.hity
        Timer.after(t*3, function()

            xx = self.player.hitx
            yy = self.player.hity
            local aoe1= AOE{
                shape = 'circle',
            
                --coordinates 
                x = xx,
                y = yy,
            
                radius = 20, --circle and donut
            
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)
        end)
        self.mech3counter = self.mech3counter + 1
        Timer.after((t*3)+1, function()
            local aoe2 = AOE{
                shape = 'donut',
            
                --coordinates 
                x = xx,
                y = yy,
            
                radius = 130, --circle and donut
                inradius = 19.5, --donut only
            
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
            }
            self.stage:addAOE(aoe2)
        end)
    
        Timer.after((t*3)+3, function()
            self.mech3counter = 1
        end)
    end


end

function Stage1:mech4()
    --SANDSTORM 
    local t = 1
    if self.mech4counter == 1 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t, function()
            local aoe1= AOE{
                shape = 'triangle',
            
                --coordinates 
                x = VIRTUAL_WIDTH/2,
                y = VIRTUAL_HEIGHT/2,
            
                x2 = 0, --triangle only 
                y2 = VIRTUAL_HEIGHT, --triangle only   
                x3 = VIRTUAL_WIDTH, --triangle only
                y3 = VIRTUAL_HEIGHT, --triangle only
    
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 2 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t*2, function()
            local aoe1= AOE{
                shape = 'triangle',
            
                --coordinates 
                x = VIRTUAL_WIDTH/2,
                y = VIRTUAL_HEIGHT/2,
            
                x2 = 0, --triangle only 
                y2 = 0, --triangle only   
                x3 = 0, --triangle only
                y3 = VIRTUAL_HEIGHT, --triangle only
    
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 3 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t*3, function()
            local aoe1= AOE{
                shape = 'triangle',
            
                --coordinates 
                x = VIRTUAL_WIDTH/2,
                y = VIRTUAL_HEIGHT/2,
            
                x2 = 0, --triangle only 
                y2 = 0, --triangle only   
                x3 = VIRTUAL_WIDTH, --triangle only
                y3 = 0, --triangle only    
    
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)
        end)
    elseif self.mech4counter == 4 then
        self.mech4counter = self.mech4counter + 1
        Timer.after(t*4, function()
            local aoe1= AOE{
                shape = 'triangle',
            
                --coordinates 
                x = VIRTUAL_WIDTH/2,
                y = VIRTUAL_HEIGHT/2,
            
                x2 = VIRTUAL_WIDTH, --triangle only 
                y2 = 0, --triangle only   
                x3 = VIRTUAL_WIDTH, --triangle only
                y3 = VIRTUAL_HEIGHT, --triangle only
    
                damage = 3, --how much damage this AOE will inflict
                snaptime = 1, -- time telegraph will show/when the snapshot occurs
                player = self.player
    
            }
            self.stage:addAOE(aoe1)

            Timer.after(t, function()
                self.mech4counter = 1
            end)
    
        end)
    end


end



function Stage1:update(dt)
    self.stage:update(dt)
    --TODO: phase changes 
    self.boss.phase = 5 
    if self.boss.phase == 1 then --TENNIS BALLS BARRAGE
        self:mech1()
    elseif self.boss.phase == 2 then --TRAFFIC
        self:mech2()
    elseif self.boss.phase == 3 then --BOMB TOSS
        self:mech3()
    elseif self.boss.phase == 4 then --DUSTSTORM
        self:mech4()
    elseif self.boss.phase == 5 then --DUSTSTORM
        self:mech1()
        self:mech3()
    end


end

function Stage1:render()
    self.stage:render()


end
