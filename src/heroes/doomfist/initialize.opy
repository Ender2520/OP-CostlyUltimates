#!mainFile "../../main.opy"

rule "[Doomfist] Info":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Overdrive"
    eventPlayer.ultDesc = " Shortens the cooldown of Doomfist's abilities.\n Eliminations reset his cooldowns and increase\n his strength, increasing damage."

rule "[Doomfist] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
