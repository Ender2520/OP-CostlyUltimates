#!mainFile "../../main.opy"

rule "[Junkrat] Info":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " RIP-Tire"
    eventPlayer.ultDesc = " Instantly kills enemies in the radius.\n Movement speed increased by 25%."