--[[
    This defines the Shiba boss. Currently similar to the base Boss, but specifics will be implemented later (such as visual assets.)
]]

Shiba = Class { __includes = Boss }

function Shiba:init(def)
        Boss.init(self, def)
        self.hitradius = 15
end

function Shiba:update(dt)
        Boss.update(self, dt)
end

function Shiba:render()
        Boss.render(self)
end
