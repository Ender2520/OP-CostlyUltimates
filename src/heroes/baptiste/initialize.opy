#!mainFile "../../main.opy"

rule "[Baptiste] Info":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Amplification Matrix"
    eventPlayer.ultDesc = " Greatly increase nearby teammates healing and damage dealt."
    eventPlayer.ultTooltip = "Teammates must be within LoS."
