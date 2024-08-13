AOE = Class {}
-- This class is meant to be a general template for all AOE type classes.

function AOE:init(def)
    --coordinates
    self.x = def.x
    self.y = def.y

    self.damage = def.damage     --how much damage this AOE will inflict
    self.teleactive = true       --is the telegraph visual active
    self.snaptime = def.snaptime -- time telegraph will show/when the snapshot occurs
    self.snapshot = false        -- is damage snapshot active

    self.timepast = 0            -- time tracker
    self.done = false            -- check for deletion

    self.player = def.player

    Timer.after(self.snaptime, function()
        self.teleactive = false
        if not self.done then
            self.snapshot = true
        end
        self.done = true
    end)
    --for persistent AOE, use Timer.every. This will be implemented in a separate class, most likely.
end

function AOE:hits(target)
    --This function determines whether the AOE hits the given target. Implementation varies depending on the geometry of the AOE, and there is no general implementation at this time.
    --Ensure this is defined for all AOE subclasses.
end

function AOE:update(dt)
    if self.snapshot then
        self:hits(self.player)
    end
end

function AOE:render()
    --At the given time, there is no general render for AOEs as they are shape dependent using LOVE2D's draw functions.
    --Later, when swapping over to actual sprites/assets, there will likely be a general implementation for renders.
end
