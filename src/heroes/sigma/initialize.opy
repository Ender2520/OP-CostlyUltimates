#!mainFile "../../main.opy"

rule "[Sigma] Info":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Gravitic Flux"
    eventPlayer.ultDesc = " Enemies slightly outside the range of Gravitic Flux\n get pulled towards the center."
    eventPlayer.ultTooltip = null