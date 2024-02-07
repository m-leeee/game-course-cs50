--[[
    GD50
    Super Mario Bros. Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_GROUND
    
    -- whether we should draw our tiles with toppers
    local topper = true
    local tileset = math.random(20)
    local topperset = math.random(20)

    local keycolor = math.random(4)
    local keyspawned = false
    local lockspawned = false

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    -- column by column generation instead of row; sometimes better for platformers
    for x = 1, width do
        local tileID = TILE_ID_EMPTY
        
        -- lay out the empty space
        for y = 1, 6 do
            table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
        end

        -- chance to just be emptiness
        local keyforcer = false --if key hasnt spawned by width, forces level maker to spawn ground on the last tile for key generation
        if x == width and keyspawned == false then
            keyforcer = true
        end

        if math.random(7) == 1 and keyforcer == false then -- could and x>1 to fix the first problem
            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, nil, tileset, topperset))
            end
        else
            tileID = TILE_ID_GROUND

            -- height at which we would spawn a potential jump block
            local blockHeight = 4

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end

            -- chance to generate a pillar
            if math.random(8) == 1 then
                blockHeight = 2
                
                -- chance to generate bush on pillar
                if math.random(8) == 1 then
                    table.insert(objects,
                        GameObject {
                            texture = 'bushes',
                            x = (x - 1) * TILE_SIZE,
                            y = (4 - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,
                            
                            -- select random frame from bush_ids whitelist, then random row for variance
                            frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                            collidable = false
                        }
                    )
                end
                
                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            
            -- chance to generate bushes
            elseif math.random(8) == 1 then
                table.insert(objects,
                    GameObject {
                        texture = 'bushes',
                        x = (x - 1) * TILE_SIZE,
                        y = (6 - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,
                        frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                        collidable = false
                    }
                )
            end

            local blockcreated = false
            local pillarcreated = blockHeight == 2 
            -- chance to spawn a block
            if math.random(10) == 1 then
                blockcreated = true 
                table.insert(objects,

                    -- jump block
                    GameObject {
                        texture = 'jump-blocks',
                        x = (x - 1) * TILE_SIZE,
                        y = (blockHeight - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,

                        -- make it a random variant
                        frame = math.random(#JUMP_BLOCKS),
                        collidable = true,
                        hit = false,
                        solid = true,

                        -- collision function takes itself
                        onCollide = function(player, obj)

                            -- spawn a gem if we haven't already hit the block
                            if not obj.hit then

                                -- chance to spawn gem, not guaranteed
                                if math.random(5) == 1 then

                                    -- maintain reference so we can set it to nil
                                    local gem = GameObject {
                                        texture = 'gems',
                                        x = (x - 1) * TILE_SIZE,
                                        y = (blockHeight - 1) * TILE_SIZE - 4,
                                        width = 16,
                                        height = 16,
                                        frame = math.random(#GEMS),
                                        collidable = true,
                                        consumable = true,
                                        solid = false,

                                        -- gem has its own function to add to the player's score
                                        onConsume = function(player, object)
                                            gSounds['pickup']:play()
                                            player.score = player.score + 100
                                        end
                                    }
                                    
                                    -- make the gem move up from the block and play a sound
                                    Timer.tween(0.1, {
                                        [gem] = {y = (blockHeight - 2) * TILE_SIZE}
                                    })
                                    gSounds['powerup-reveal']:play()

                                    table.insert(objects, gem)
                                end

                                obj.hit = true
                            end

                            gSounds['empty-block']:play()
                        end
                    }
                )
            end


            if (math.random(width) >= width/7*6 or x==width) and lockspawned ==false then 
                local lock = GameObject {
                    texture = 'keys', 
                    x = (x - 1) * TILE_SIZE,
                    y = 1 * TILE_SIZE - 4,
                    width = 16,
                    height = 16,
                    frame = keycolor+4,
                    collidable = true,
                    consumable = false,
                    solid = true,



                    -- collision function takes itself
                    onCollide = function(obj, player)

                        if player.keyobtained then
                            gSounds['empty-block']:play()
                            player.openLock = true
                        end

                    end

                }

                table.insert(objects, lock)
                lockspawned = true
            end



            if keyspawned == false then

                if x==width or math.random(width) <= x then --arbitraryish key spawn distribution to favor key spawns closer to start of stage 
                    --spawn a key
                    local keyy = 4 
                    if pillarcreated == true then
                        keyy = 2
                        if blockcreated == true then
                            keyy = 1
                        end
                    else
                        if blockcreated == true then
                            keyy = 2
                        end
                    end

                    local key = GameObject {
                        texture = 'keys', 
                        x = (x - 1) * TILE_SIZE,
                        y = keyy * TILE_SIZE - 4,
                        width = 16,
                        height = 16,
                        frame = keycolor,
                        collidable = true,
                        consumable = true,
                        solid = false,



                        onConsume = function(player, object)
                            gSounds['pickup']:play()
                            player.keyobtained = true
                        end
                    }

                    table.insert(objects, key)
                    keyspawned = true
                end


            end


        end
    end

    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end