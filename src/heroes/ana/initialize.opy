#!mainFile "../../main.opy"

rule "[Ana] Info":
    @Event eachPlayer
    @Hero ana
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Mega Boost"
    eventPlayer.ultDesc = " Now makes the boosted player invincible."