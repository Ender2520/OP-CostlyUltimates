#!mainFile "../../main.opy"

rule "[Hanzo] Info":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Dragon Storm"
    eventPlayer.ultDesc = " Grants Hanzo with five seperate Dragonstrikes."
