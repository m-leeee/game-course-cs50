-- sets the stage 
-- loads anything stages will have in general such as background + score + health + other UI elements 
-- probably need to make a separate file stage_def or smth with all the info 

-- stage lists will probably have entity lists with mechanics baked into specific entities? 

Stage = Class{}

function Stage:init(def)
    self.player = def.player

    -- container we could use to store rooms in a static dungeon, but unused here
    --self.rooms = {}

    -- current room we're operating in
    --self.currentRoom = Room(self.player)    


    self.AOEs = {} --table to hold and manage all active AOEs
    self.enemies = {} --table to hold an manage all active enemies 



end

function Stage:addAOE(AOE)
    table.insert(self.AOEs, AOE)
end

function Stage:addEnemy(mob)
    table.insert(self.enemies, mob)
end

function Stage:cleanAOElist()
    for k, aoe in pairs(self.AOEs) do
        if aoe.done then
            table.remove(self.AOEs,k)
        end
    end
end

--need to add clean enemy list once deaths are implemented 

function Stage:update(dt)

    for k, aoe in pairs(self.AOEs) do
        aoe:update(dt)
    end
    self:cleanAOElist()

--[[     for k, mob in pairs(self.enemies) do
        mob:update(dt)
    end ]]
    --clean enemy list when implemented as well
    --currently stage1 handles render/update logic for boss - this needs to be updated later. 

    --if self.player:getbulletcount() > 0 then
        for b, bullet in pairs(self.player.bullets) do
            for m, mob in pairs(self.enemies) do
                if bullet:collides(mob) then
                    mob.health = mob.health - 1
                    bullet.done = true
                end
            end
        end
    --end
end

function Stage:render()

    for k, aoe in pairs(self.AOEs) do
        aoe:render()
        
--[[         love.graphics.setColor(255, 0, 255, 255) --tests cleanAOElist
        love.graphics.printf(k, 1, 10*k, 100, 'center') ]]
    end
--[[     for k, mob in pairs(self.enemies) do
        mob:render()
    end ]]

end

