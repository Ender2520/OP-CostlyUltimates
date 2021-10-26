#!mainFile "../../main.opy"

rule "[Moira] Initialize":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.strikePos = vect(0,-1000,0)

# CREDITS GO TO Alomare FOR ALL OF THE MATH AND CONCEPT
rule "[Moira] Call Coalescene Strike":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 40, BarrierLos.PASS_THROUGH_BARRIERS) == false
    @Condition angleBetweenVectors(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 40, getAllPlayers(), eventPlayer, false).getNormal(), Vector.UP) <= 30
    
    # activate coalnado
    eventPlayer.allowButton(Button.ULTIMATE)
    wait()
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(0.5)
    # initialize
    eventPlayer.usingUltimateREAL = true
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.cancelPrimaryAction() 
    eventPlayer.strikePos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 40, getAllPlayers(), eventPlayer, false).getHitPosition()
    eventPlayer.strikeHeight = 0
    wait()
    # create effects
    createEffect(getAllPlayers(), Effect.RING, Color.RED, updateEveryTick(raycast(eventPlayer.strikePos + vect(0,1,0), eventPlayer.strikePos - vect(0,1000,0), null, getAllPlayers(), false).getHitPosition()), 3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.RING, Color.YELLOW, updateEveryTick(raycast(eventPlayer.strikePos + vect(0,1,0), eventPlayer.strikePos - vect(0,1000,0), null, getAllPlayers(), false).getHitPosition()), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.SIGMA_GRAVITIC_FLUX_TARGET_SOUND, eventPlayer.getTeam(), eventPlayer.strikePos, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.strikePos + angleToDirection(getTotalTimeElapsed() * 120, 0) * 2 + Vector.UP * eventPlayer.strikeHeight, eventPlayer.strikePos + angleToDirection(120 * getTotalTimeElapsed(), 0) * 0.5, eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.strikePos + ((angleToDirection(120 + getTotalTimeElapsed() * 120, 0)) * 2) + Vector.UP * eventPlayer.strikeHeight, eventPlayer.strikePos + ((angleToDirection(120 + getTotalTimeElapsed() * 120, 0)) * 0.5), eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.MOIRA_COALESCENCE, eventPlayer.strikePos + ((angleToDirection(240 + getTotalTimeElapsed() * 120, 0)) * 2) + Vector.UP * eventPlayer.strikeHeight, eventPlayer.strikePos + ((angleToDirection(240 + getTotalTimeElapsed() * 120, 0)) * 0.5), eventPlayer.getTeam(), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "C: Alomare", eventPlayer.strikePos + ((angleToDirection(getTotalTimeElapsed() * 120, 0)) * 2) + Vector.UP * (eventPlayer.strikeHeight * 0.5), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.ALWAYS)
    createInWorldText(getAllPlayers(), "C: Alomare", eventPlayer.strikePos + ((angleToDirection(120 + getTotalTimeElapsed() * 120, 0)) * 2) + Vector.UP * (eventPlayer.strikeHeight * 0.4), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.ALWAYS)
    createInWorldText(getAllPlayers(), "C: Alomare", eventPlayer.strikePos + ((angleToDirection(240 + getTotalTimeElapsed() * 120, 0)) * 2) + Vector.UP * (eventPlayer.strikeHeight * 0.3), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.ALWAYS)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.VIOLET, eventPlayer.strikePos, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, eventPlayer.strikePos, 8)
    # chase pos and height
    chase(eventPlayer.strikePos, eventPlayer.strikePos + vect(eventPlayer.getFacingDirection().x, 0, eventPlayer.getFacingDirection().z) * 100, rate=3.3, ChaseReeval.NONE)
    chase(eventPlayer.strikeHeight, 75, duration=2, ChaseReeval.NONE)
    # duration
    wait(10)
    # stop ultimate
    eventPlayer.usingUltimateREAL = false
    wait()
    # stop animation
    chase(eventPlayer.strikeHeight, 0, duration=2, ChaseReeval.NONE)
    wait(2)
    stopChasingVariable(eventPlayer.strikeHeight)
    stopChasingVariable(eventPlayer.strikePos)
    eventPlayer.strikePos = vect(0,-1000,0)

rule "[Moira] Looping Ultimate Effects":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.usingUltimateREAL == true

    # sounds
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.VIOLET, eventPlayer.strikePos, 16)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer.strikePos, 15)
    playEffect(getAllPlayers(), DynamicEffect.MOIRA_FADE_REAPPEAR_SOUND, Color.TEAM_1, eventPlayer.strikePos, 40)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, Color.TEAM_1, eventPlayer.strikePos, 15)
    # damage and heal over time
    [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player.getPosition() * vect(1,0,1), eventPlayer.strikePos * vect(1,0,1)) < 8].startDoT(eventPlayer, 0.5, 100)
    [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player.getPosition() * vect(1,0,1), eventPlayer.strikePos * vect(1,0,1)) < 3].startDoT(eventPlayer, 0.5, 300)
    [player for player in getPlayers(eventPlayer.getTeam()) if distance(player.getPosition() * vect(1,0,1), eventPlayer.strikePos * vect(1,0,1)) < 8].startHoT(eventPlayer, 0.5, 50)
    [player for player in getPlayers(eventPlayer.getTeam()) if distance(player.getPosition() * vect(1,0,1), eventPlayer.strikePos * vect(1,0,1)) < 3].startHoT(eventPlayer, 0.5, 150)
    if distance(eventPlayer.strikePos, raycast(eventPlayer.strikePos + vect(0,1,0), eventPlayer.strikePos - vect(0,6,0), null, getAllPlayers(), false).getHitPosition()) >= 0.25 and distance(eventPlayer.strikePos, raycast(eventPlayer.strikePos + vect(0,1,0), eventPlayer.strikePos - vect(0,6,0), null, getAllPlayers(), false).getHitPosition()) < 5:
        eventPlayer.strikePos = raycast(eventPlayer.strikePos, eventPlayer.strikePos - vect(0,5,0), null, getAllPlayers(), false).getHitPosition()
    wait(0.5)
    if RULE_CONDITION:
        goto RULE_START