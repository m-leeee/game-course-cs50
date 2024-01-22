
PowerUp = Class{}

function PowerUp:init()


    self.dy = 0 
    self.type = 1

    self.width = 16
    self.height = 16
    self.inPlay = false
    self.x = 0
    self.y = 0

end

function PowerUp:update(dt)
--    if self.inPlay == true then
--        self.dy = 30
--    else
--        self.dy = 0
--    end
    self.y = self.y + self.dy * dt
    if self.inPlay == false then
        self.dy = 0
    end

end


function PowerUp:collides(target)

    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true

end

function PowerUp:activate(x,y)
    self.x = x
    self.y = y

    --pass brick location 
    self.inPlay = true
    self.dy = 30 
end


function PowerUp:render()
    if self.inPlay == true then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.type], self.x, self.y)

        --love.graphics.draw(gTextures['main'], gFrames['balls'][2],
        --self.x, self.y)

    end
end