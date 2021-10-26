#!mainFile "../../main.opy"

rule "[Echo] Info":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Counterpoise"
    eventPlayer.ultDesc = " Decreases the ultimate charges of enemies by a\n certain amount depending on their distance from Echo"

rule "[Echo] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)