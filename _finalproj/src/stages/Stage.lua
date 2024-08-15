--[[
    This is the class that contains and handles the shared elements all specific stages will need
    such as storing and handling AOE lists, enemy lists, UI elements, etc.

    Other stages (such as stage1 and Sandbox) wilL define the specifics of what enemies and mechanics occur in each.

    Currently, Stage is an object other stages will initialize, rather than acting as a Parent/Base class.
    It may be worth changing this in the future, but currently does not seem to have issues as is.
]]

Stage = Class {}

function Stage:init(def)
    self.player = def.player
    self.AOEs = {}    --table to hold and manage all active AOEs
    self.enemies = {} --table to hold and manage all active enemies
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
            table.remove(self.AOEs, k)
        end
    end
end

--TODO: need to add clean enemy list once deaths are implemented

function Stage:update(dt)
    for k, aoe in pairs(self.AOEs) do
        aoe:update(dt)
    end
    self:cleanAOElist()

    for k, mob in pairs(self.enemies) do
        mob:update(dt)
    end
    --TODO: clean enemy list when it is implemented
    --if boss.dead == true, then can clean from EnemyList, but may want to implement an animation and clear it after the animation is done


    for b, bullet in pairs(self.player.bullets) do
        for m, mob in pairs(self.enemies) do
            if bullet:collides(mob) then
                mob.health = mob.health - 1
                bullet.done = true
            end
        end
    end

    if self.player.melee.active == true then
        for m, mob in pairs(self.enemies) do
            self.player.melee:hits(mob)
            self.player.melee.active = false
        end
    end

    for m, mob in pairs(self.enemies) do
        for b, bullet in pairs(mob.bullets) do
            bullet:collides(self.player)
        end
    end
end

function Stage:render()
    for k, aoe in pairs(self.AOEs) do
        aoe:render()
    end
    for k, mob in pairs(self.enemies) do
        mob:render()
    end
end
