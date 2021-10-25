#!mainFile "../../main.opy"

rule "[Mercy] Initialize":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.goldenGunReloaded = true
    chase(eventPlayer.goldenGunCooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)