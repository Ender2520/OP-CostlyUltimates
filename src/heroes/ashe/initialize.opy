#!mainFile "../../main.opy"

rule "[Ashe] Info":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " B.O.O.B."
    eventPlayer.ultDesc = " Lasts forever, unless eliminated."
    eventPlayer.ultTooltip = "B.O.O.B. can be healed by teammates."
