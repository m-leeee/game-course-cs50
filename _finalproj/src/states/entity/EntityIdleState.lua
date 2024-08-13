--[[
    This is base class for all Entity (player and boss) idle/default states.
]]

EntityIdleState = Class { __includes = BaseState }

function EntityIdleState:init(entity)
    self.entity = entity
end

function EntityIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.entity.x,
        self.entity.y,
        0, .1, .1, 1, 1)
end
