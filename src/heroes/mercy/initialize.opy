#!mainFile "../../main.opy"

rule "[Mercy] Info":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2)
    eventPlayer.ultName = " Golden Gun"
    eventPlayer.ultDesc = " Mercy's pistol now instantly kills any enemies hit.\n Shots are on a short cooldown."
    eventPlayer.ultTooltip = null

rule "[Mercy] Initialize":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.goldenGunReloaded = true
    chase(eventPlayer.goldenGunCooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)