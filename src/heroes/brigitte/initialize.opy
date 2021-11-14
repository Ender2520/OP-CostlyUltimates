#!mainFile "../../main.opy"

rule "[Brigitte] Info":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Rally"
    eventPlayer.ultDesc = " Greatly increases the speed of Brigitte and nearby allies.\n Brigitte and nearby ally cooldowns are shortened."
    eventPlayer.ultTooltip = null
