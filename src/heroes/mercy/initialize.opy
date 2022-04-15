#!mainFile "../../main.opy"

rule "[Mercy] Info":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2)
    eventPlayer.ultName = " Golden Gun"
    eventPlayer.ultDesc = " Mercy's pistol now instantly kills any enemies hit.\n Shots are on a short cooldown."
    eventPlayer.ultTooltip = null
