#!mainFile "../../main.opy"

# CREDITS GO TO Alomare FOR ALL OF THE MATH AND CONCEPT
rule "[Moira] Call Coalnado":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, BarrierLos.PASS_THROUGH_BARRIERS) == false
    @Condition angleBetweenVectors(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, getAllPlayers(), eventPlayer, false).getNormal(), Vector.UP) <= 30
    
    # activate coalnado
    eventPlayer.allowButton(Button.ULTIMATE)
    wait()
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(0.5)
    # initialize
    eventPlayer.usingUltimateREAL = true
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.cancelPrimaryAction() 
    eventPlayer.tornadoPos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, getAllPlayers(), eventPlayer, false).getHitPosition()
    eventPlayer.tornadoHeight = 0
    wait()
    # create effects
    createEffect(getAllPlayers(), Effect.RING, Color.RED, updateEveryTick(raycast(eventPlayer.tornadoPos + vect(0,1,0), eventPlayer.tornadoPos - vect(0,1000,0), null, getAllPlayers(), false).getHitPosition()), 4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.RING, Color.YELLOW, updateEveryTick(raycast(eventPlayer.tornadoPos + vect(0,1,0), eventPlayer.tornadoPos - vect(0,1000,0), null, getAllPlayers(), false).getHitPosition()), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.BAD_AURA_SOUND, eventPlayer.getTeam(), eventPlayer.tornadoPos, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.tornadoPos + angleToDirection(/*rotation*/getTotalTimeElapsed() * 360, 0) * /*top distance*/7 + Vector.UP * /*height*/eventPlayer.tornadoHeight, eventPlayer.tornadoPos + angleToDirection(getTotalTimeElapsed() * 120, 0) * /*bottom distance*/0.5, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.tornadoPos + ((angleToDirection(/*rotation*/120 + getTotalTimeElapsed() * 360, 0)) * /*top distance*/7) + Vector.UP * /*height*/eventPlayer.tornadoHeight, eventPlayer.tornadoPos + ((angleToDirection(120 + getTotalTimeElapsed() * 120, 0)) * /*bottom distance*/0.5), eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.tornadoPos + ((angleToDirection(/*rotation*/240 + getTotalTimeElapsed() * 360, 0)) * /*top distance*/7) + Vector.UP * /*height*/eventPlayer.tornadoHeight, eventPlayer.tornadoPos + ((angleToDirection(240 + getTotalTimeElapsed() * 120, 0)) * /*bottom distance*/0.5), eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.tornadoEffects.append(getLastCreatedEntity())
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.VIOLET, eventPlayer.tornadoPos, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, eventPlayer.tornadoPos, 8)
    # chase pos and height
    chase(eventPlayer.tornadoPos, eventPlayer.tornadoPos + vect(eventPlayer.getFacingDirection().x, 0, eventPlayer.getFacingDirection().z) * 100, rate=4.0, ChaseReeval.NONE)
    chase(eventPlayer.tornadoHeight, 70, duration=1.5, ChaseReeval.NONE)
    # duration
    wait(10)
    # stop ultimate
    eventPlayer.usingUltimateREAL = false
    wait()
    # stop animation
    chase(eventPlayer.tornadoHeight, 0, duration=1.5, ChaseReeval.NONE)
    wait(1.5)
    stopChasingVariable(eventPlayer.tornadoHeight)
    stopChasingVariable(eventPlayer.tornadoPos)
    eventPlayer.tornadoPos = vect(0,-1000,0)
    destroyEffect(eventPlayer.tornadoEffects)
    eventPlayer.tornadoEffects = []

rule "[Moira] Ultimate Loop":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.usingUltimateREAL == true

    # sounds
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.VIOLET, eventPlayer.tornadoPos, 16)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer.tornadoPos, 15)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Color.TEAM_1, eventPlayer.tornadoPos, 40)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_1, eventPlayer.tornadoPos, 15)
    # damage and heal over time
    [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player.getPosition() * vect(1,0,1), eventPlayer.tornadoPos * vect(1,0,1)) < 8].startDoT(eventPlayer, 0.512, 70)
    [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player.getPosition() * vect(1,0,1), eventPlayer.tornadoPos * vect(1,0,1)) < 4].startDoT(eventPlayer, 0.512, 35)
    [player for player in getPlayers(eventPlayer.getTeam()) if distance(player.getPosition() * vect(1,0,1), eventPlayer.tornadoPos * vect(1,0,1)) < 8].startHoT(eventPlayer, 0.512, 140)
    [player for player in getPlayers(eventPlayer.getTeam()) if distance(player.getPosition() * vect(1,0,1), eventPlayer.tornadoPos * vect(1,0,1)) < 4].startHoT(eventPlayer, 0.512, 70)
    if distance(eventPlayer.tornadoPos, raycast(eventPlayer.tornadoPos + vect(0,2,0), eventPlayer.tornadoPos - vect(0,8,0), null, getAllPlayers(), false).getHitPosition()) >= 0.25:
        if distance(eventPlayer.tornadoPos, raycast(eventPlayer.tornadoPos + vect(0,2,0), eventPlayer.tornadoPos - vect(0,8,0), null, getAllPlayers(), false).getHitPosition()) < 7:
            if (raycast(eventPlayer.tornadoPos + vect(0,2,0), eventPlayer.tornadoPos - vect(0,8,0), null, getAllPlayers(), false).getHitPosition()) * vect(0,1,0) <= eventPlayer.tornadoPos * vect(0,1,0):
            eventPlayer.tornadoPos = raycast(eventPlayer.tornadoPos + vect(0,2,0), eventPlayer.tornadoPos - vect(0,8,0), null, getAllPlayers(), false).getHitPosition()
    wait(0.512)
    if RULE_CONDITION:
        goto RULE_START
