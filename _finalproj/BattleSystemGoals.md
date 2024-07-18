## Player battle system and Attack types
Players will recieve choices of attack styles to equip. Currently unsure of the way I'd like to present these choices (such as via different Characters with set loadouts, or allowing players to mix and match slots to their own choosing). Regardless of how these choices ultimately get presented to the player, I would like to follow a design balance that favors higher reward for actions that require higher risk and/or skill.

Terms to know: 
* Global Cooldown (GCD) - sets the cap of the amount of actions that players can send, but setting a Global Cooldown timer on all primary actions. Often times, actions on the Global Cooldowns are just referred to GCDs themselves. For example, if attacks A and B are both GCDs, activating A will deactivate the ability to use both A and B until the GCD timer completes.
* Off Global Cooldowns (oGCD) - describes actions that do not adhere to the Global Cooldown timer, hence "off" GCD. These actions can be hit at any time. Optimally they are used between GCDs (AKA "weaving" since you are "weaving" oGCDs between GCDs.) For the current scope of this game as of time of writing, oGCDs will mostly be relevant to actions for activating buffs/debuffs. As an example use case, some players could optimize GCD attack > oGCD shield > GCD attack, in order to apply a defensive boost without distrupting their damage cycle/output. 

Any values and percentages below are tentative, and will likely change with further development and playtesting. 

### Bullets
Bullets describe the ranged projectiles available to the player. Bullets will be shot one at a time as a GCD.
* Straight bullet - arbitrary damage value B
* Aimed bullet (mouse aim) - 15% less than B 
* Homing bullet (auto tracking, guaranteed hit) - 60% less than B 
### Laser
Straight line from the player directly on the y axis, hitting anything and everything in the path. 
* 1 time Laser (checks for hits once per activation) - damage L
* Persistent Laser (checks for hits multiple times over an active duration)- 20% more than L in total, assuming full uptime (eg if L is 10 damage, and Persistent ticks every second, it could have 12s long for 1 damage each tick)
### Melee
Circle AOE around the player, damaging any enemies in the radius.
* 1 time Melee - damage M 
* Persistent Melee (checking for multiple hits over an active duration) - 35% more than M in total, assuming full uptime
* Constant Melee (constantly on and checking for hits at certain game ticks, acting as an aura rather than direct action) - 70% less than M/(cooldown time) 
### Special
Special actions that work differently than other 3 base actions in execution. These will give large bonuses but trade off player mobility as a result. Some of these require the implementations of Buffs/Debuffs (see below.)
* Charge - charges attack or effect based off time passed. Players moving or using another action stops the Charge.
    * Global attack that does more damage based off charge 
    * Buff that increases damage of next attack based off charge 
* Cast - requires player to stand still and wait out a set time before action is executed (like a wizard focusing and casting a spell). Should players move early, their Cast gets cancelled and would need to be restarted entirely. 
    * Attack that has arbitrary damage C after cast
    * Buff that increases damage of next attack by set amount 
* CastLock - Attack that locks the player in cast, disabling actions and movements until the entire duration is completed (or the player dies). Essentially a cast you cannot cancel and are forced to finish. This attack should have massive damage and outscale both Cast and Charge in value reward. 

For Charge VS Cast scaling, Charge actions should mimic exponential growth in damage value, whereas Cast should be more linear. Thus, Charge playstyles will highly reward being able to stand still for a very long time, whereas Cast should reward players who are willing to plan around the set duration. For example, on a 2 second Cast, the Charge equivalent should overtake the Cast's damage/time gain at, say, 5 seconds, and progressively reward Charge even more in damage/time value if the player were able to hit 6+ seconds. Of course, Charge actions would need to have a cap as well (such that its not necessarily an infinitely growing gain). 

## Buffs/Debuffs
These describe status effects that can be inflicted on the Player (and likely on the boss as well). Debuffs will likely be inflicted on players via AOEs or other stage based triggers, while Player buffs will likely be available as oGCDs. 

### Buffs
* Regen: Some HP recovered at fixed game ticks 
* Shield: Value that acts in place of HP that can also overcap past an entity's max HP
* Mitigation: Damage taken decreased by some percentage
* Damage Up: Damage output increased by some percentage
### Debuffs
* Poison: Damage at fixed game ticks 
* Vulnerability: Damage taken increased by some percentage
* Damage Down: Damage output decreased by some percentage
* Slow: Reduces movement speed
* Snare: Stop on movements (movement speed = 0)
* Silence: Stop on all actions
* Stun: Stop on movement and all actions