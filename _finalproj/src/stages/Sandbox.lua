--[[
    This class is meant as a testing space for new features by loading it as the stage in PlayState's constructor.
]]

Sandbox = Class {}

function Sandbox:init(def)
    self.player = def.player


    self.boss = Shiba {
        animations = ENTITY_DEFS['shiba'].animations,
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        width = 30,
        height = 30,
        hboxw = 12,
        hboxh = 12,
        health = 5,
        maxhealth = 10,
        offsetY = 5

    }

    self.boss.stateMachine = StateMachine {
        ['default'] = function() return EntityIdleState(self.boss) end
    }
    self.boss:changeState('default')
    self.boss:changeAnimation('idle')

    self.stage = Stage { player = self.player }
end

function Sandbox:update(dt)
    self.stage:update(dt)


    if math.random(100) == 102 then
        local aoespawn
        aoespawn = AOECircle {

            --coordinates
            x = self.player.x,
            y = self.player.y,

            radius = 20,

            damage = 2,   --how much damage this AOE will inflict
            snaptime = 1, -- time telegraph will show/when the snapshot occurs
            --persisttime = 0, -- how long persistent AOE lasts. set as 0 if its a 1 tick snap.  --currently on hold
            player = self.player

        }

        self.stage:addAOE(aoespawn)
    end
end

function Sandbox:render()
    self.stage:render()
end
