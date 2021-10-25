#!mainFile "../../main.opy"

rule "[Doomfist] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)