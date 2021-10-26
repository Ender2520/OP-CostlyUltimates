#!mainFile "../../main.opy"

rule "[Genji] Info":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Dragonblade"
    eventPlayer.ultDesc = " Grants Genji infinite Swift Strikes."