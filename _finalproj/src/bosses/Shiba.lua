Shiba = Class{__includes = Boss}

function Shiba:init(def)
        Entity.init(self, def)
--[[     self.animations = ENTITY_DEFS['shiba'].animations
            --walkSpeed = ENTITY_DEFS['player'].walkSpeed,
            
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 11
            
    self.width = 256
    self.height = 256
    self.hboxw = 12
    self.hboxh = 12

            -- one heart == 2 health
    self.health = 6

            -- rendering and collision offset for spaced sprites
    self.offsetY = 5

    self.stateMachine = StateMachine {
        --['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        --['idle'] = function() return PlayerIdleState(self.player, self.dungeon) end,
        --['swing-sword'] = function() return PlayerSwingSwordState(self.player, self.dungeon) end,
        ['default'] =  function() return EntityIdleState(self) end
    }
    self:changeState('default')
    self:changeAnimation('idle') ]]
end


function Shiba:update(dt)
        --Entity.update(self, dt)
end



function Shiba:render()
        Boss.render(self)

        -- love.graphics.setColor(255, 0, 255, 255)
        -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        -- love.graphics.setColor(255, 255, 255, 255)
end