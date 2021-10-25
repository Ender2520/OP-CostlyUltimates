#!mainFile "../../main.opy"

rule "[Mei] Blizzard Instantly Freezes":
    @Event playerTookDamage
    @Condition attacker.getCurrentHero() == Hero.MEI
    @Condition attacker.getTeam() != victim.getTeam()
    @Condition eventAbility == Button.ULTIMATE

    # set victim as frozen
    victim.setStatusEffect(attacker, Status.FROZEN, 9999)
    waitUntil(not attacker.isUsingUltimate(), 9999)
    wait(1)
    victim.clearStatusEffect(Status.FROZEN)