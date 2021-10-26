#!mainFile "../../main.opy"

rule "[Baptiste] Info":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Amplification Matrix"
    eventPlayer.ultDesc = " Creates a zone that increases any visible teammates damage by 200%."