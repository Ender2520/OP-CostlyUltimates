#!mainFile "../../main.opy"

rule "[Lucio] Info":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Sound Barrier"
    eventPlayer.ultDesc = " Provides teammates with a large pool of temporary overhealth."
    eventPlayer.ultTooltip = "Lasts until damaged."
