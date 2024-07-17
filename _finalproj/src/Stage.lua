-- sets the stage 
-- loads anything stages will have in general such as background + score + health + other UI elements 
-- probably need to make a separate file stage_def or smth with all the info 

-- stage lists will probably have entity lists with mechanics baked into specific entities? 

Stage = Class{}

function Stage:init(player)
    self.player = player

    -- container we could use to store rooms in a static dungeon, but unused here
    --self.rooms = {}

    -- current room we're operating in
    --self.currentRoom = Room(self.player)    


    self.AOEs = {} --table to hold and manage all AOEs




end

function Stage:addAOE(AOE)
    table.insert(self.AOEs, AOE)
end

function Stage:cleanAOElist()
    for k, aoe in pairs(self.AOEs) do
        if aoe.done then
            table.remove(self.AOEs,k)
        end
    end
end

function Stage:update(dt)

    for k, aoe in pairs(self.AOEs) do
        aoe:update(dt)
    end
    self:cleanAOElist()
end

function Stage:render()

    for k, aoe in pairs(self.AOEs) do
        aoe:render()
        
--[[         love.graphics.setColor(255, 0, 255, 255) --tests cleanAOElist
        love.graphics.printf(k, 1, 10*k, 100, 'center') ]]
    end

end

