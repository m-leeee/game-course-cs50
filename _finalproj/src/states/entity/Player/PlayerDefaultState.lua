PlayerDefaultState = Class{__includes = EntityIdleState}

function PlayerDefaultState:enter(params)
    self.entity:changeAnimation('idle')
end

function PlayerDefaultState:update(dt)


    if love.keyboard.isDown('left') then --TODO: Update with animations whenever I get the assets done
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        --self.entity:changeAnimation('walk-down')

    end

    if love.keyboard.isDown('x') then
        if self.entity.gcdrolled == false then
            local bullet = PlayerBullet(self.entity)
    
            table.insert(self.entity.bullets, bullet)

            self.entity.gcdrolled = true --caps the number of attack actions you can send 
            Timer.after(self.entity.gcdspeed, function() 
                self.entity.gcdrolled = false
            end)
        end
    
    end

end

