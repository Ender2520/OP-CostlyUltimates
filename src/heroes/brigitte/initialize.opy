#!mainFile "../../main.opy"

rule "[Brigitte] Info":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Rally"
    eventPlayer.ultDesc = " Increases the speed of Brigitte and allies by 50%.\n Lowers Brigitte and ally cooldowns by 25%."