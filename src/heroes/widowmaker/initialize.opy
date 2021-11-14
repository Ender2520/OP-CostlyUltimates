#!mainFile "../../main.opy"

rule "[Widowmaker] Info":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Chamber"
    eventPlayer.ultDesc = " Widowmaker is given a new sniper that a massive\n amount of damage through walls. She also keeps her Infra-Sight."