#!mainFile "../../main.opy"

rule "[D.VA] Info":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Atomic Bomb"
    eventPlayer.ultDesc = " Deals damage through walls"
    eventPlayer.ultTooltip = "Atomic Bomb is not blocked by shields."