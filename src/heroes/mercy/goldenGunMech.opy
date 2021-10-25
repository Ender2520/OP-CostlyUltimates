#!mainFile "../../main.opy"

rule "[Mercy] Golden Gun Fire Rate":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    waitUntil(eventPlayer.isFiringPrimaryFire(), 9999)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setWeapon(2)
    eventPlayer.goldenGunReloaded = false
    eventPlayer.goldenGunCooldown = 2
    waitUntil(eventPlayer.goldenGunCooldown == 0, 9999)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.goldenGunReloaded = true
    if RULE_CONDITION:
        goto RULE_START

rule "[Mercy] Golden Gun Insta-Kill":
    @Event playerDealtDamage
    @Hero mercy
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition attacker.isUsingUltimate()

    kill(victim, attacker)