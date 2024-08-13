AOEBoxKnockback = Class { __includes = AOEBox }

function AOEBoxKnockback:init(def)
    AOEBox.init(self, def)
    self.degree = def.degree     --direction for knockback
    self.duration = def.duration -- effect duration if applicable
end

function AOEBoxKnockback:hits(target)
    if AOEBox.hits(self, target) then
        self.player.knockbacktracker = { self.degree, self.duration }
        self.player:changeState('kb')
    end
end

function AOEBoxKnockback:update(dt)
    if self.snapshot then
        self:hits(self.player)
    end
end

function AOEBoxKnockback:render()
    AOEBox.render(self)
end
