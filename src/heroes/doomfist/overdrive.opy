#!mainFile "../../main.opy"

rule "[Doomfist] Detect Ultimate Use":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    # pre-ultimate
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setUltEnabled(false)
    eventPlayer.ultimateDuration = 15
    eventPlayer.damageIncrease = 1
    chase(eventPlayer.ultimateDuration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    # peri-ultimate
    progressBarHud(eventPlayer, updateEveryTick(100 * (eventPlayer.ultimateDuration / 15)), "{0} Overdrive | Damage Increase {1}%".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE), eventPlayer.damageIncrease * 100), HudPosition.TOP, -10, Color.RED, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.ALWAYS)
    eventPlayer.ultimateBar = getLastCreatedText()
    eventPlayer.usingUltimateREAL = true
    waitUntil(eventPlayer.ultimateDuration == 0, 99999)
    # post-ultimate
    if eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt /= 1.14285
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt /= 1.125
        eventPlayer.damageDealt /= 1.14285
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    wait()
    # post-ultimate 2
    destroyProgressBarHud(eventPlayer.ultimateBar)
    stopChasingVariable(eventPlayer.ultimateDuration)
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setUltEnabled(true)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.ultimateBar = []
    eventPlayer.damageIncrease = 1