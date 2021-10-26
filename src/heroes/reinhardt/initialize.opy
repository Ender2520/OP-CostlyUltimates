#!mainFile "../../main.opy"

rule "[Reinhardt] Info":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Earthshatter"
    eventPlayer.ultDesc = " Stuns enemies for 12 seconds."