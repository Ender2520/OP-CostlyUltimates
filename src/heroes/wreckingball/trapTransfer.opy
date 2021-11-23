#!mainFile "../../main.opy"

rule "[Wrecking Ball] Trap Transfer Activated":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition len([p for p in getPlayersInRadius(eventPlayer.getPosition(), 15, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if p.isAlive()]) > 0

    # initialize trap
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0)
    eventPlayer.i = 0
    eventPlayer.trapTime = 1
    eventPlayer.trappedEffects = []
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.disallowButton(Button.CROUCH)
    # define trapped players
    wait()
    eventPlayer.trappedPlayers = [p for p in getPlayersInRadius(eventPlayer.getPosition(), 15, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if p.isAlive()]
    # create eventPlayer text
    progressBarHud(eventPlayer, eventPlayer.trapTime * 100, "{0} Trap Transfer {0}".format(iconString(Icon.DIZZY)), HudPosition.TOP, 19, rgb(235 * eventPlayer.trapTime + 200 * (1-eventPlayer.trapTime), 150 * eventPlayer.trapTime + 30 * (1-eventPlayer.trapTime), 20 * (1-eventPlayer.trapTime)), Color.ORANGE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.trappedText = getLastCreatedText()
    # create *per player* beam/text effects
    wait()
    for eventPlayer.i in range(len(eventPlayer.trappedPlayers)):
        createBeam(getAllPlayers() if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, Beam.GRAPPLE, updateEveryTick(eventPlayer.getPosition() + Vector.UP * 0.8), eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getPosition() + Vector.UP * 0.8, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.trappedEffects.append(getLastCreatedEntity())
        createBeam(getPlayers(eventPlayer.getTeam()) if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, Beam.GOOD, updateEveryTick(eventPlayer.getPosition() + Vector.UP * 0.8), eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getPosition() + Vector.UP * 0.8, Color.BLUE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.trappedEffects.append(getLastCreatedEntity())
        createBeam(getPlayers(getOppositeTeam(eventPlayer.getTeam())) if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, Beam.BAD, updateEveryTick(eventPlayer.getPosition() + Vector.UP * 0.8), eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getPosition() + Vector.UP * 0.8, Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.trappedEffects.append(getLastCreatedEntity())
        createEffect(getAllPlayers() if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getPosition(), (1-eventPlayer.trapTime) * 100 + 20, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.trappedEffects.append(getLastCreatedEntity())
    # stun, burn & slow(eventPlayer)
    eventPlayer.moveSpeed[false] *= 1 - (10/*percent per enemy*/ * len(eventPlayer.trappedPlayers) / 100)
    eventPlayer.trappedPlayers.moveSpeed[false] *= 0.35
    eventPlayer.trappedPlayers.setStatusEffect(eventPlayer, Status.STUNNED, 0.5)
    eventPlayer.trappedPlayers.setStatusEffect(eventPlayer, Status.BURNING, 9999)
    eventPlayer.trappedPlayers.startDoT(eventPlayer, 9999, 13.33333)
    eventPlayer.trappedPlayers.trappedSTIMER = 7.5
    eventPlayer.trappedPlayers.isStatused[5] = true
    smallMessage(eventPlayer.trappedPlayers, "{0} ELIMINATE THE HAMSTER {0}".format(abilityIconString(Hero.HAMMOND, Button.ULTIMATE)))
    eventPlayer.trapDOT = getLastDoT()
    # start timer
    chase(eventPlayer.trapTime, 0, duration=7.5, ChaseReeval.NONE)
    eventPlayer.i = 0
    waitUntil(eventPlayer.isDead() or eventPlayer.trapTime == 0, 9999)
    if eventPlayer.isAlive():
        damage(eventPlayer.trappedPlayers, eventPlayer, 600 if eventPlayer.megaBoosted == true else 400)
        for eventPlayer.i in range(len(eventPlayer.trappedPlayers)):
            playEffect(getAllPlayers() if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, DynamicEffect.GOOD_EXPLOSION, Color.ORANGE, eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getEyePosition(), 2)
            playEffect(getAllPlayers() if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, Color.WHITE, eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getEyePosition(), 150)
            playEffect(getAllPlayers() if eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].isAlive() else null, DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.WHITE, eventPlayer.trappedPlayers[evalOnce(eventPlayer.i)].getEyePosition(), 50)
    eventPlayer.moveSpeed[false] /= 1 - (10/*percent per enemy*/ * len(eventPlayer.trappedPlayers) / 100)
    eventPlayer.trappedPlayers.moveSpeed[false] /= 0.35
    eventPlayer.trappedPlayers.isStatused[5] = false
    eventPlayer.trappedPlayers.clearStatusEffect(Status.ROOTED)
    eventPlayer.trappedPlayers.clearStatusEffect(Status.BURNING)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.CROUCH)
    stopDoT(eventPlayer.trapDOT)
    destroyEffect(eventPlayer.trappedEffects)
    destroyProgressBarHud(eventPlayer.trappedText)
    wait()
    eventPlayer.usingUltimateREAL = false
    eventPlayer.trappedEffects = null
    eventPlayer.trappedText = null
