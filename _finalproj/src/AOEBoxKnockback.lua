AOEBoxKnockback= Class{__includes = AOEBox}

function AOEBoxKnockback:init(def)
    AOEBox.init(self,def)
    --self.effect = def.effect --'knockback', debuff name 
    self.degree = def.degree --direction for knockback
    self.duration = def.duration -- effect duration if applicable
end

function AOEBoxKnockback:hits(target)
    if AOEBox.hits(self,target) then

        --if self.effect == 'knockback' then
            self.player.knockbacktracker ={self.degree,self.duration}
            self.player:changeState('kb')
        --end

    end

end

function AOEBoxKnockback:update(dt)
    --AOE.update(self,dt)
    if self.snapshot then
        self:hits(self.player)
    end
end

function AOEBoxKnockback:render()
    --AOE.render(self)
    AOEBox.render(self)
end