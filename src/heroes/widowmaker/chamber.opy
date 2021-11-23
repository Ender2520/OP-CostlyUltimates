#!mainFile "../../main.opy"

rule "[Widowmaker] Chamber Activated":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isUsingUltimate()

    #progressBarHud([p for p in eventPlayer if eventPlayer.isFiringSecondaryFire() and eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and eventPlayer.chamberCharge < 1], eventPlayer.chamberCharge * 100, "", HudPosition.TOP, 19, Color.PURPLE, Color.PURPLE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    #eventPlayer.chamberTexts = getLastCreatedText()
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setMaxAmmo(0, 5)
    eventPlayer.setAmmo(0, 5)
    #chase(eventPlayer.chamberCharge, 1, rate=10, ChaseReeval.NONE)
    waitUntil(eventPlayer.isUsingUltimate() != true or eventPlayer.isDead(), 9999)
    #destroyProgressBarHud(eventPlayer.chamberTexts)
    #stopChasingVariable(eventPlayer.chamberCharge)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.setMaxAmmo(0, 35)
    eventPlayer.setAmmo(0, 35)

rule "[Widowmaker] Chamber Shot Fired": # CREDITS TO CACTUS PUPPY
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition eventPlayer.isFiringSecondaryFire()

    #eventPlayer.chamberCharge = 0
    #playEffect(eventPlayer, DynamicEffect.TRACER_RECALL_REAPPEAR_SOUND, Color.WHITE, eventPlayer, 100)
    #wait(0.1, Wait.ABORT_WHEN_FALSE)
    # initialize
    eventPlayer.chamberCast_Start = eventPlayer.getEyePosition()
    eventPlayer.chamberCast_Direction = eventPlayer.getFacingDirection()
    eventPlayer.chamberCast_DistRemaining = 80
    eventPlayer.setAmmo(0,0)
    # create effects
    createBeam(getAllPlayers(), Beam.OMNIC_SLICER, evalOnce(eventPlayer.chamberCast_Start), evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction), eventPlayer.getTeam(), EffectReeval.VISIBILITY)
    eventPlayer.chamberEffects.append(getLastCreatedEntity())
    createBeam(getPlayers(eventPlayer.getTeam()), Beam.BAD, evalOnce(eventPlayer.chamberCast_Start), evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction), Color.BLUE, EffectReeval.VISIBILITY)
    eventPlayer.chamberEffects.append(getLastCreatedEntity())
    createBeam(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Beam.BAD, evalOnce(eventPlayer.chamberCast_Start), evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction), Color.RED, EffectReeval.VISIBILITY)
    eventPlayer.chamberEffects.append(getLastCreatedEntity())
    # play effects
    wait()
    playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 100)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 150)
    playEffect(getAllPlayers(), DynamicEffect.MCCREE_FLASHBANG_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.BLUE, eventPlayer.getEyePosition(), 1)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 1)
    # run raycast calculations
    # If our raycast hit something (raycast hit point != end point), handle it with this code
    while (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() != evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction)):
        # Check if raycast hit a player
        if (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit() != null): # We hit a player, do stuff and stop raycasting   
            damage(raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit(), eventPlayer, 450 if eventPlayer.megaBoosted == true else 300)
            eventPlayer.chamberCast_DistRemaining = 0
            break
        elif eventPlayer.chamberCast_DistRemaining < 0:
            break
        else: # If we didn't hit a player, we hit a wall. Update our raycast to start a little past the wall.
            eventPlayer.chamberCast_DistRemaining = eventPlayer.chamberCast_DistRemaining - distance(eventPlayer.chamberCast_Start, raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Direction * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition()) - 0.5
            eventPlayer.chamberCast_Start = raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_Direction * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() + (eventPlayer.chamberCast_Direction * 0.5)
            wait()
    waitUntil(eventPlayer.chamberCast_DistRemaining <= 0 or raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() == evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction), 9999)
    wait(0.5, Wait.IGNORE_CONDITION)
    # remove effects
    destroyEffect(eventPlayer.chamberEffects)
    eventPlayer.chamberEffects = []
    
