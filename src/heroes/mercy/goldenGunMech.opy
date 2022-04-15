#!mainFile "../../main.opy"

rule "[Mercy] Golden Gun Fire Rate":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    chase(eventPlayer.goldenGunCooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setWeapon(2)
    while eventPlayer.isUsingUltimate() and eventPlayer.isAlive():
        eventPlayer.goldenGunReloaded = false
        if eventPlayer.megaBoosted == true:
            eventPlayer.goldenGunCooldown = 1.25
        else:
            eventPlayer.goldenGunCooldown = 2.5
        waitUntil(eventPlayer.goldenGunCooldown == 0, 9999)
        eventPlayer.allowButton(Button.PRIMARY_FIRE)
        eventPlayer.goldenGunReloaded = true
        waitUntil(eventPlayer.isFiringPrimaryFire(), 9999)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    stopChasingVariable(eventPlayer.goldenGunCooldown)

rule "[Mercy] Golden Gun Insta-Kill":
    @Event playerDealtDamage
    @Hero mercy
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition attacker.isUsingUltimate()

    kill(victim, attacker)
