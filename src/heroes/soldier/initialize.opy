#!mainFile "../../main.opy"

rule "[Soldier 76] Initialize":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)