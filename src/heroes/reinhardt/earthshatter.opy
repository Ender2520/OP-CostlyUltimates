#!mainFile "../../main.opy"

rule "[Reinhardt] 12s Ultimate Duration":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 10)
