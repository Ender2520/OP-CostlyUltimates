#!mainFile "../../main.opy"

rule "[Reinhardt] Activate Earthshatter":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.usingUltimateREAL = true
    wait(10)
    eventPlayer.usingUltimateREAL = false

rule "[Reinhardt] 12s Ultimate Duration":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE

    eventPlayer.usingUltimateREAL = true
    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 10)
