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


    self.boss = Boss{
        animations = ENTITY_DEFS['shiba'].animations,
        --walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 256,
        height = 256,
        hboxw = 12,
        hboxh = 12,

        -- one heart == 2 health
        health = 6,

        -- rendering and collision offset for spaced sprites
        offsetY = 5


    }




end

function Stage:update(dt)
    self.boss:update(dt)
--[[     -- pause updating if we're in the middle of shifting
    if not self.shifting then    
        self.currentRoom:update(dt)
    else
        
        -- still update the player animation if we're shifting rooms
        self.player.currentAnimation:update(dt)
    end ]]
end

function Stage:render()
    
--[[     -- translate the camera if we're actively shifting
    if self.shifting then
        love.graphics.translate(-math.floor(self.cameraX), -math.floor(self.cameraY))
    end

    self.currentRoom:render()
    
    if self.nextRoom then
        self.nextRoom:render()
    end ]]


end

