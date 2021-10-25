#!mainFile "../../main.opy"

rule "[Echo] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)