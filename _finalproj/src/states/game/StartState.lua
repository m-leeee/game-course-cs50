--[[
    This is the start menu.
]]

StartState = Class { __includes = BaseState }

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('START', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
end
