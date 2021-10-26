#!mainFile "../../main.opy"

rule "[Reaper] Info":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Death Blossom"
    eventPlayer.ultDesc = " Getting an elimination teleports Reaper to the\n nearest enemy within sight."