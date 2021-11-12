#!mainFile "../../main.opy"

rule "[Echo] Info":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Counterpoise"
    eventPlayer.ultDesc = " Decrease enemy ultimate charges based\n on their distance from you."

rule "[Echo] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
