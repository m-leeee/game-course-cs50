AOEwithEffect= Class{__includes = AOE}

function AOEwithEffect:init(def)
    AOE.init(self,def)
    self.effect = def.effect --'knockback', debuff name 
    self.degree = def.degree --direction for knockback
    self.duration = def.duration -- effect duration if applicable
end

function AOEwithEffect:hits(target)
    if AOE.hits(self,target) then

        if self.effect == 'knockback' then
            self.player.knockbacktracker ={self.degree,self.duration}
            self.player:changeState('kb')
        end

    end

end

function AOEwithEffect:update(dt)
    --AOE.update(self,dt)
    if self.snapshot then
        self:hits(self.player)
    end
end

function AOEwithEffect:render()
    AOE.render(self)

end