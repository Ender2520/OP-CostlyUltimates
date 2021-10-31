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
    # create effects
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.WINSTON_TESLA_CANNON_TARGET, eventPlayer.getTeam(), eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.overdriveEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.WINSTON_TESLA_CANNON_TARGET, getOppositeTeam(eventPlayer.getTeam()), eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.overdriveEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.BAD_AURA_SOUND, eventPlayer.getTeam(), eventPlayer, 120, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.overdriveEffects.append(getLastCreatedEntity())
    # play effects
    # activation visuals
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, getOppositeTeam(eventPlayer.getTeam()), eventPlayer.getEyePosition(), 2)
    # activation audio
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 80)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 90)
    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 70)
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
    destroyEffect(eventPlayer.overdriveEffects)
    stopChasingVariable(eventPlayer.ultimateDuration)
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setUltEnabled(true)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.ultimateBar = []
    eventPlayer.overdriveEffects = []
    eventPlayer.damageIncrease = 1