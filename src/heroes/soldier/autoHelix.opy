#!mainFile "../../main.opy"

rule "[Soldier 76] Spam Helix Rockets":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    eventPlayer.setUltCharge(0)
    eventPlayer.usingUltimateREAL = true
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setAmmo(0, 30)
    for eventPlayer.i in range(12):
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        wait(0.5)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
        eventPlayer.setAmmo(0, eventPlayer.getAmmo(0) - 2.5)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.setUltCharge(0)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)