--[[
    This is the game over state.

    Game over/loss conditions have yet to be implemented, so this is mostly a placeholder as of now.
]]

GameOverState = Class { __includes = BaseState }

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('GAME OVER', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
end
