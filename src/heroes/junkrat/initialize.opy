#!mainFile "../../main.opy"

rule "[Junkrat] Info":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " RIP-Tire"
    eventPlayer.ultDesc = " Instantly kills enemies within range.\n Increased RIP-Tire speed."
    eventPlayer.ultTooltip = null
