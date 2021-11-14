#!mainFile "../../main.opy"

rule "[Widowmaker] Chamber Activated":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setMaxAmmo(0, 5)
    eventPlayer.setAmmo(0, 5)
    waitUntil(eventPlayer.isUsingUltimate() != true or eventPlayer.isDead(), 9999)
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
    playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 100)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_PILEDRIVER_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 150)
    playEffect(getAllPlayers(), DynamicEffect.MCCREE_FLASHBANG_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.BLUE, eventPlayer.getEyePosition(), 1)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 1)
    # run raycast calculations
    # If our raycast hit something (raycast hit point != end point), handle it with this code
    while (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() != evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction)):
        wait()
        # Check if raycast hit a player
        if (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit() != null): # We hit a player, do stuff and stop raycasting
            damage(raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit(), eventPlayer, 500)
            break
        else: # If we didn't hit a player, we hit a wall. Update our raycast to start a little past the wall.
            eventPlayer.chamberCast_DistRemaining = eventPlayer.chamberCast_DistRemaining - distance(eventPlayer.chamberCast_Start, raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Direction * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition()) - 0.25
            eventPlayer.chamberCast_Start = raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_Direction * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() + (eventPlayer.chamberCast_Direction * 0.25)
    wait(0.5)
    # remove effects
    destroyEffect(eventPlayer.chamberEffects)
    eventPlayer.chamberEffects = []
    