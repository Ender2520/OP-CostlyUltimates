#!mainFile "../../main.opy"

rule "[Cassidy] Info":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Deadeye"
    eventPlayer.ultDesc = " A shield appears in front of Cassidy.\n Movement speed debuff removed."
    eventPlayer.ultTooltip = null
