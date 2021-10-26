#!mainFile "../../main.opy"

rule "[Ashe] Info":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " B.O.O.B."
    eventPlayer.ultDesc = " Now lasts forever."