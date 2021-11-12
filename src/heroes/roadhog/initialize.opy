#!mainFile "../../main.opy"

rule "[Roadhog] Info":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Whole Hog"
    eventPlayer.ultDesc = " Enemies damaged get pulled towards Roadhog."
