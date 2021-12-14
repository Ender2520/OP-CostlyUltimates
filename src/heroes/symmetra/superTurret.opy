#!mainFile "../../main.opy"

rule "[Symmetra] Create Super Turret":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30, BarrierLos.PASS_THROUGH_BARRIERS) == false

    # get turret position
    eventPlayer.turretPos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30, null, getAllPlayers(), false).getHitPosition()
    # initalize
    wait()
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0)
    eventPlayer.turretTimer = 1
    eventPlayer.turretTexts = []
    # create/play effects (ACTUAL TURRET)
    wait()
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.AQUA, eventPlayer.turretPos, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.AQUA, eventPlayer.turretPos, 15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.AQUA, eventPlayer.turretPos, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, eventPlayer.turretPos, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, eventPlayer.turretPos, 15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, eventPlayer.turretPos, 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    # create/play effects (ORBS)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.turretPos, 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.turretPos + ((angleToDirection(/*rotation*/180 + getTotalTimeElapsed() * 180, 0)) * /*top distance*/1), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.turretPos + ((angleToDirection(getTotalTimeElapsed() * 180, 0)) * /*top distance*/1), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.turretPos + vect(0,1,0) + ((angleToDirection(/*rotation*/180 + getTotalTimeElapsed() * 450, 0)) * /*top distance*/0.5), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.turretPos - vect(0,1,0) + ((angleToDirection(getTotalTimeElapsed() * 270, 0)) * /*top distance*/0.5), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    # create/play effects (BEAMS)
    wait()
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, eventPlayer.getTeam(), eventPlayer.turretPos, 70, EffectReeval.VISIBILITY)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers() if eventPlayer.turretTarget != null else null, Effect.BEACON_SOUND, eventPlayer.getTeam(), eventPlayer.turretPos, 200, EffectReeval.VISIBILITY)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers() if eventPlayer.turretTarget != null else null, Beam.TORBJORN_TURRET_SIGHT, eventPlayer.turretPos, eventPlayer.turretTarget, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers() if eventPlayer.turretTarget != null else null, Beam.SYMMETRA_TURRET, eventPlayer.turretPos + ((angleToDirection(/*rotation*/180 + getTotalTimeElapsed() * 180, 0)) * /*top distance*/1), eventPlayer.turretTarget, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers() if eventPlayer.turretTarget != null else null, Beam.SYMMETRA_TURRET, eventPlayer.turretPos + ((angleToDirection(getTotalTimeElapsed() * 180, 0)) * /*top distance*/1), eventPlayer.turretTarget, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers() if eventPlayer.turretTarget != null else null, Beam.SYMMETRA_TURRET, eventPlayer.turretPos + vect(0,1,0) + ((angleToDirection(/*rotation*/180 + getTotalTimeElapsed() * 450, 0)) * /*top distance*/0.5), eventPlayer.turretTarget, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers() if eventPlayer.turretTarget != null else null, Beam.SYMMETRA_TURRET, eventPlayer.turretPos - vect(0,1,0) + ((angleToDirection(getTotalTimeElapsed() * 270, 0)) * /*top distance*/0.5), eventPlayer.turretTarget, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.turretEffects.append(getLastCreatedEntity())
    # create/play effects (HP BAR)
    createProgressBarInWorldText([p for p in getPlayers(eventPlayer.getTeam()) if distance(p, eventPlayer.turretPos) <= 25 or isInLoS(p, eventPlayer.turretPos, BarrierLos.PASS_THROUGH_BARRIERS)], updateEveryTick((eventPlayer.turretEntity.getHealth() / 600) * 100), "Super Turret Health", eventPlayer.turretPos + vect(0,1,0), 0.8, Clip.NONE, Color.AQUA, Color.AQUA, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.turretTexts[0] = getLastCreatedText()
    createProgressBarInWorldText([p for p in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(p, eventPlayer.turretPos) <= 25 or isInLoS(p, eventPlayer.turretPos, BarrierLos.PASS_THROUGH_BARRIERS)], updateEveryTick((eventPlayer.turretEntity.getHealth() / 600) * 100), "Super Turret Health", eventPlayer.turretPos + vect(0,1,0), 0.8, Clip.NONE, Color.RED, Color.RED, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.turretTexts[1] = getLastCreatedText()
    # create/play effects (SPAWN EFFECTS)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.AQUA, eventPlayer.turretPos, 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.turretPos, 2)
    # create entity
    #createDummy(Hero.HAMMOND, getOppositeTeam(eventPlayer.getTeam()), -1, vect(0,100,0), vect(0,100,0))
    createDummy(Hero.HAMMOND, eventPlayer.getTeam(), -1, vect(0,100,0), vect(0,100,0))
    eventPlayer.turretEntity = getLastCreatedEntity()
    # modify entity received
    wait()
    eventPlayer.turretEntity.setDamageReceived(70)
    eventPlayer.turretEntity.setHealingReceived(0)
    # modify entity stats
    eventPlayer.turretEntity.setInvisibility(Invis.ALL)
    eventPlayer.turretEntity.startModifyingVoicelinePitch(0.01, false)
    eventPlayer.turretEntity.setStatusEffect(null, Status.UNKILLABLE, 9999)
    eventPlayer.turretEntity.startForcingPosition(eventPlayer.turretPos - vect(0,1.425,0), false)
    eventPlayer.turretEntity.disableEnvironmentCollision(true)
    eventPlayer.turretEntity.startScalingSize(1.68, false)
    eventPlayer.turretEntity.startForcingName("Super Turret")
    eventPlayer.turretEntity.setGravity(0)
    wait()
    while not eventPlayer.turretEntity.isInAlternateForm():
        eventPlayer.turretEntity.forceButtonPress(Button.ABILITY_1)
        wait(0.05)
    # start timer
    chase(eventPlayer.turretTimer, 0, duration=20, ChaseReeval.NONE)
    waitUntil(eventPlayer.turretTimer == 0 or eventPlayer.turretEntity.getHealth() < 5 and eventPlayer.turretEntity != null, 25)
    # revert changes
    eventPlayer.usingUltimateREAL = false
    destroyEffect(eventPlayer.turretEffects)
    destroyProgressBarInWorldText(eventPlayer.turretTexts[0])
    destroyProgressBarInWorldText(eventPlayer.turretTexts[1])
    destroyDummy(eventPlayer.turretEntity.getTeam(), eventPlayer.turretEntity.getSlot())
    eventPlayer.turretEffects = []
    eventPlayer.turretTexts = []
    eventPlayer.turretEntity = null

rule "[Symmetra] Ultimate Loop":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.usingUltimateREAL == true

    # sounds
    playEffect(getAllPlayers(), DynamicEffect.ECHO_STICKY_BOMB_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.turretPos, 40)
    eventPlayer.turretTarget = sorted([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer.turretPos) <= 15 and isInLoS(eventPlayer.turretPos, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player != eventPlayer.turretEntity and player.isAlive()], lambda i: distance(eventPlayer.turretPos, i))[0]
    eventPlayer.turretTarget.startDoT(eventPlayer, 0.256, 100)
    wait(0.256)
    eventPlayer.turretTarget = sorted([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer.turretPos) <= 15 and isInLoS(eventPlayer.turretPos, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player != eventPlayer.turretEntity and player.isAlive()], lambda i: distance(eventPlayer.turretPos, i))[0]
    eventPlayer.turretTarget.startDoT(eventPlayer, 0.256, 100)
    wait(0.256)
    if RULE_CONDITION:
        goto RULE_START

rule "[Symmetra] Slow Turret Target":
    @Event eachPlayer
    @Condition eventPlayer == [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.getCurrentHero() == Hero.SYMMETRA and player.usingUltimateREAL == true].turretTarget

    eventPlayer.moveSpeed[false] *= 0.6
    waitUntil(eventPlayer != [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.getCurrentHero() == Hero.SYMMETRA and player.usingUltimateREAL == true].turretTarget, 9999)
    eventPlayer.moveSpeed[false] /= 0.6
