#!mainFile "../../main.opy"

rule "[Soldier 76] Info":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Automatic Helix"
    eventPlayer.ultDesc = " Automatically fires several Helix Rockets quickly."

rule "[Soldier 76] Initialize":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)