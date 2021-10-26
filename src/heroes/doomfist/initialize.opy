#!mainFile "../../main.opy"

rule "[Doomfist] Info":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Overdrive"
    eventPlayer.ultDesc = " Decreases Doomfist’s cooldowns to 2 seconds.\n Eliminations reset his cooldowns and increase\n his damage by 0.25x."

rule "[Doomfist] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)