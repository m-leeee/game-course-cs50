--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.ball = params.ball
    self.level = params.level

    self.recoverPoints = 5000
    self.powerUp = PowerUp()

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
    
    brickHit = 0
    ballUp = false
    ballCount = 1


    ballActive = true 
    ballAActive = false

    --powerup balls
    self.ballA = Ball()
    self.ballA.x = 0
    self.ballA.y = 0
    self.ballB = Ball()
    self.ballA.skin = math.random(7)

    --self.ballB.x = 0
    --self.ballB.y = 10


    self.ball.isActive = true
    self.ballA.isActive = false
    self.ballB:reset()
    self.ballB.skin = math.random(7)
    self.ballB.isActive = false
end

function PlayState:update(dt)

    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)
    if self.ball.isActive == true then
        self.ball:update(dt)
    end
    self.powerUp:update(dt)

    if ballUp == true and self.ballA.isActive == true then
        self.ballA:update(dt)
    end

    if ballUp == true and self.ballB.isActive == true then
        self.ballB:update(dt)
    end
    --self.ballB:update(dt)

    if self.ball:collides(self.paddle) then
        -- raise ball above paddle in case it goes below it, then reverse dy
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

        --
        -- tweak angle of bounce based on where it hits the paddle
        --

        -- if we hit the paddle on its left side while moving left...
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        
        -- else if we hit the paddle on its right side while moving right...
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

        gSounds['paddle-hit']:play()
    end


    if self.ballA:collides(self.paddle) then
        -- raise ball above paddle in case it goes below it, then reverse dy
        self.ballA.y = self.paddle.y - 8
        self.ballA.dy = -self.ballA.dy

        --
        -- tweak angle of bounce based on where it hits the paddle
        --

        -- if we hit the paddle on its left side while moving left...
        if self.ballA.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ballA.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ballA.x))
        
        -- else if we hit the paddle on its right side while moving right...
        elseif self.ballA.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ballA.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ballA.x))
        end

        gSounds['paddle-hit']:play()
    end


    if self.ballB:collides(self.paddle) then
        -- raise ball above paddle in case it goes below it, then reverse dy
        self.ballB.y = self.paddle.y - 8
        self.ballB.dy = -self.ballB.dy

        --
        -- tweak angle of bounce based on where it hits the paddle
        --

        -- if we hit the paddle on its left side while moving left...
        if self.ballB.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ballB.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ballB.x))
        
        -- else if we hit the paddle on its right side while moving right...
        elseif self.ballB.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ballB.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ballB.x))
        end

        gSounds['paddle-hit']:play()
    end


    if self.powerUp:collides(self.paddle) then
        --spawn a new ball
        self.powerUp.inPlay = false
        ballUp = true
        self.ballA.isActive = true 
        self.ballB.isActive = true
        --ballAActive = true
        ballCount = 3
        
        self.ballA.x = self.paddle.x + (self.paddle.width / 2) - 4
        self.ballA.y = self.paddle.y - 8
        self.ballA.dx = math.random(-200, 200)
        self.ballA.dy = math.random(-50, -60)

        self.ballB.x = self.paddle.x + (self.paddle.width / 2) - 4
        self.ballB.y = self.paddle.y - 8
        self.ballB.dx = math.random(-200, 200)
        self.ballB.dy = math.random(-50, -60) 

        self.powerUp.x = 0
        self.powerUp.y = 0
        self.powerUp.dx = 0

    end

    -- detect collision across all bricks with the ball
    for k, brick in pairs(self.bricks) do

        -- only check collision if we're in play
        if brick.inPlay and self.ball:collides(brick) then

            -- add to score
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
            brickHit = brickHit + 1

            -- trigger the brick's hit function, which removes it from play
            brick:hit()

            -- if we have enough points, recover a point of health
            if self.score > self.recoverPoints then
                -- can't go above 3 health
                self.health = math.min(3, self.health + 1)

                -- multiply recover points by 2
                self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                -- play recover sound effect
                gSounds['recover']:play()
            end

            -- go to our victory screen if there are no more bricks left
            if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    highScores = self.highScores,
                    ball = self.ball,
                    recoverPoints = self.recoverPoints
                })
            end
            


            self.ball:collisionUpdate(brick)

            if brickHit == 3 then
                --brickHit = 0 --resets the counter for a new powerup, but will recycle the powerup thats active 
                self.powerUp:activate(brick.x,brick.y)
            end



            -- only allow colliding with one brick, for corners
            break

        end

                -- only check collision if we're in play
        if brick.inPlay and self.ball:collides(brick) then

            -- add to score
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
            brickHit = brickHit + 1

            -- trigger the brick's hit function, which removes it from play
            brick:hit()

            -- if we have enough points, recover a point of health
            if self.score > self.recoverPoints then
                -- can't go above 3 health
                self.health = math.min(3, self.health + 1)

                -- multiply recover points by 2
                self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                -- play recover sound effect
                gSounds['recover']:play()
            end

            -- go to our victory screen if there are no more bricks left
            if self:checkVictory() then
                gSounds['victory']:play()

                gStateMachine:change('victory', {
                    level = self.level,
                    paddle = self.paddle,
                    health = self.health,
                    score = self.score,
                    highScores = self.highScores,
                    ball = self.ball,
                    recoverPoints = self.recoverPoints
                })
            end
            


            self.ball:collisionUpdate(brick)

            if brickHit == 2 then
                --brickHit = 0 --resets the counter for a new powerup, but will recycle the powerup thats active 
                self.powerUp:activate(brick.x,brick.y)
            end


            -- only allow colliding with one brick, for corners
            break

        end

        


                -- only check collision if we're in play
                if brick.inPlay and self.ballA:collides(brick) then

                    -- add to score
                    self.score = self.score + (brick.tier * 200 + brick.color * 25)
                    brickHit = brickHit + 1
        
                    -- trigger the brick's hit function, which removes it from play
                    brick:hit()
        
                    -- if we have enough points, recover a point of health
                    if self.score > self.recoverPoints then
                        -- can't go above 3 health
                        self.health = math.min(3, self.health + 1)
        
                        -- multiply recover points by 2
                        self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)
        
                        -- play recover sound effect
                        gSounds['recover']:play()
                    end
        
                    -- go to our victory screen if there are no more bricks left
                    if self:checkVictory() then
                        gSounds['victory']:play()
        
                        gStateMachine:change('victory', {
                            level = self.level,
                            paddle = self.paddle,
                            health = self.health,
                            score = self.score,
                            highScores = self.highScores,
                            ball = self.ball,
                            recoverPoints = self.recoverPoints
                        })
                    end
                    
        
        
                    self.ballA:collisionUpdate(brick)
        
        
        
                    -- only allow colliding with one brick, for corners
                    break
        
                end


                
                -- only check collision if we're in play
                if brick.inPlay and self.ballB:collides(brick) then

                    -- add to score
                    self.score = self.score + (brick.tier * 200 + brick.color * 25)
                    brickHit = brickHit + 1
        
                    -- trigger the brick's hit function, which removes it from play
                    brick:hit()
        
                    -- if we have enough points, recover a point of health
                    if self.score > self.recoverPoints then
                        -- can't go above 3 health
                        self.health = math.min(3, self.health + 1)
        
                        -- multiply recover points by 2
                        self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)
        
                        -- play recover sound effect
                        gSounds['recover']:play()
                    end
        
                    -- go to our victory screen if there are no more bricks left
                    if self:checkVictory() then
                        gSounds['victory']:play()
        
                        gStateMachine:change('victory', {
                            level = self.level,
                            paddle = self.paddle,
                            health = self.health,
                            score = self.score,
                            highScores = self.highScores,
                            ball = self.ball,
                            recoverPoints = self.recoverPoints
                        })
                    end
                    
        
        
                    self.ballB:collisionUpdate(brick)
        
        
        
                    -- only allow colliding with one brick, for corners
                    break
        
                end
                

                --implement this better but this works for now
                if brickHit >0 and brickHit % 5 == 0 then
                    brickHit = brickHit + 1
                    self.paddle:sizeChange(1)
                end


    end

    

    if self.ball.y >= VIRTUAL_HEIGHT then
        ballCount = ballCount - 1
        self.ball.y = 0
        self.ball.dx = 0
        self.ball.dy = 0
        self.ball.isActive = false
        --ballActive = false
    end
    if self.ballA.y >= VIRTUAL_HEIGHT then
        ballCount = ballCount - 1
        self.ballA.y = 0
        self.ballA.dx =0
        self.ballA.dy = 0 
        self.ballA.isActive = false
        --ballAActive = false
    end
    if self.ballB.y >= VIRTUAL_HEIGHT then
        ballCount = ballCount - 1
        self.ballB.y = 0
        self.ballB.dx = 0
        self.ballB.dy = 0
        self.ballB.isActive = false
        --ballActive = false
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    if ballCount <1 then
        self.health = self.health - 1
        gSounds['hurt']:play()
        
        self.paddle:sizeChange(-1)

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                recoverPoints = self.recoverPoints
            })
        end
    end



    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end


end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()

    if self.ball.isActive == true then
        self.ball:render()
    end

    self.powerUp:render()

    if ballUp == true and self.ballA.isActive == true then
        self.ballA:render()
    end

    if ballUp == true and self.ballB.isActive == true then
        self.ballB:render()
    end
    --self.ballB.render()
    --love.graphics.draw(gTextures['main'], gFrames['balls'][self.ballB.skin],self.ballB.x, self.ballB.y)

    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end

    --love.graphics.printf(ballCount, 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    --debug purposes

end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
    
end