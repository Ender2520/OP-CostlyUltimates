#!mainFile "../../main.opy"

rule "[Doomfist] On Elimination SECONDARY":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventAbility == Button.SECONDARY_FIRE

    # damage boost depending on current damage boost
    if eventPlayer.damageIncrease == 1:
        eventPlayer.damageDealt *= 1.25
        eventPlayer.damageIncrease = 1.25
    elif eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt *= 1.2
        eventPlayer.damageIncrease = 1.5
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt *= 1.16666
        eventPlayer.damageIncrease = 1.75
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt *= 1.14285
        eventPlayer.damageIncrease = 2.0
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt *= 1.125
        eventPlayer.damageIncrease = 2.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt *= 1.11111
        eventPlayer.damageIncrease = 2.5
    # reset cooldowns
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0.1, 9999)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)

rule "[Doomfist] On Elimination ABILITY 1":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventAbility == Button.ABILITY_1

    # damage boost depending on current damage boost
    if eventPlayer.damageIncrease == 1:
        eventPlayer.damageDealt *= 1.25
        eventPlayer.damageIncrease = 1.25
    elif eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt *= 1.2
        eventPlayer.damageIncrease = 1.5
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt *= 1.16666
        eventPlayer.damageIncrease = 1.75
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt *= 1.14285
        eventPlayer.damageIncrease = 2.0
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt *= 1.125
        eventPlayer.damageIncrease = 2.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt *= 1.11111
        eventPlayer.damageIncrease = 2.5
    # reset cooldowns
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1, 9999)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)

rule "[Doomfist] On Elimination ABILITY 2":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventAbility == Button.ABILITY_2

    # damage boost depending on current damage boost
    if eventPlayer.damageIncrease == 1:
        eventPlayer.damageDealt *= 1.25
        eventPlayer.damageIncrease = 1.25
    elif eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt *= 1.2
        eventPlayer.damageIncrease = 1.5
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt *= 1.16666
        eventPlayer.damageIncrease = 1.75
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt *= 1.14285
        eventPlayer.damageIncrease = 2.0
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt *= 1.125
        eventPlayer.damageIncrease = 2.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt *= 1.11111
        eventPlayer.damageIncrease = 2.5
    # reset cooldowns
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.1, 9999)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)

rule "[Doomfist] On Elimination ANY":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true

    # damage boost depending on current damage boost
    if eventPlayer.damageIncrease == 1:
        eventPlayer.damageDealt *= 1.25
        eventPlayer.damageIncrease = 1.25
    elif eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt *= 1.2
        eventPlayer.damageIncrease = 1.5
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt *= 1.16666
        eventPlayer.damageIncrease = 1.75
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt *= 1.14285
        eventPlayer.damageIncrease = 2.0
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt *= 1.125
        eventPlayer.damageIncrease = 2.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt *= 1.11111
        eventPlayer.damageIncrease = 2.5
    # reset cooldowns
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)