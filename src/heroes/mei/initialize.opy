#!mainFile "../../main.opy"

rule "[Mei] Info":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Blizzard"
    eventPlayer.ultDesc = " Instantly freezes enemies within the radius."
    eventPlayer.ultTooltip = null