--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(battleState,hp,atk,def,spd)
    self.battleState = battleState
    self.pokemon = self.battleState.player.party.pokemon[1]
    
    self.expMenu = Menu {
        x = VIRTUAL_WIDTH - 128,
        y = 0,
        width = 128,
        height = VIRTUAL_HEIGHT,--180,
        items = {
            {
                text = 'HP:' .. tostring(self.pokemon.HP-hp) .. '+' .. tostring(hp) .. '='  .. tostring(self.pokemon.HP)
            },
            {
                text = 'ATK:' .. tostring(self.pokemon.attack-atk) .. '+' .. tostring(atk) .. '='  .. tostring(self.pokemon.attack)
            },
            {
                text = 'DEF:' .. tostring(self.pokemon.defense-def) .. '+' .. tostring(def) .. '='  .. tostring(self.pokemon.defense)
            },
            {
                text = 'SPD:' .. tostring(self.pokemon.speed-spd) .. '+' .. tostring(spd) .. '='  .. tostring(self.pokemon.speed)
            }
        }
    }

    self.expMenu.selection.cursoractive = false
end

function MenuState:update(dt)
    self.expMenu:update(dt)
end

function MenuState:render()
    self.expMenu:render()
end