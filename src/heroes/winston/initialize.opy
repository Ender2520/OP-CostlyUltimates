#!mainFile "../../main.opy"

rule "[Widowmaker] Info":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Primal Rage"
    eventPlayer.ultDesc = " Primal Rage now has greatly increased knockback\n and deals a large amount of damage."
    eventPlayer.ultTooltip = null