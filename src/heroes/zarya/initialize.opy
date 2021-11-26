#!mainFile "../../main.opy"

rule "[Zarya] Info":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Graviton Pit"
    eventPlayer.ultDesc = " Graviton Pit drags enemies within range below the ground, after\n being fully suffocated it will deal massives amount of damage."
    eventPlayer.ultTooltip = null

rule "[Zarya] Initialize":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)