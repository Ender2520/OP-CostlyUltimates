#!mainFile "../../main.opy"

rule "[Echo] Info":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Counterpoise"
    eventPlayer.ultDesc = " Decrease enemy ultimate charges based\n on their distance from you."
    eventPlayer.ultTooltip = null