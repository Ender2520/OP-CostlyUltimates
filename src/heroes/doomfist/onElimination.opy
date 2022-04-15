#!mainFile "../../main.opy"

rule "[Doomfist] On Elimination":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true

    # reset cooldowns
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)

rule "[Doomfist] On Ability Damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventAbility == Button.ABILITY_1 or eventAbility == Button.ABILITY_2 or eventAbility == Button.SECONDARY_FIRE

    # increase damage boost value
    eventPlayer.damageIncrease[false] += 0.05