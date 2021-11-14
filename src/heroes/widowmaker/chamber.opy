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
    eventPlayer.chamberCast_DistRemaining = 100
    # create effect
    #createBeam(getAllPlayers(), Beam.MOIRA_ORB_DAMAGE, evalOnce(eventPlayer.chamberCast_Start), evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction), eventPlayer.getTeam(), EffectReeval.VISIBILITY)
    # run raycast calculations
    # If our raycast hit something (raycast hit point != end point), handle it with this code
    while (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() != evalOnce(eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction)):
        # Check if raycast hit a player
        if (raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit() != null): # We hit a player, do stuff and stop raycasting
            createBeam(getAllPlayers(), Beam.MOIRA_ORB_DAMAGE, evalOnce(eventPlayer.chamberCast_Start), evalOnce(raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition()), eventPlayer.getTeam(), EffectReeval.VISIBILITY)
            damage(raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getPlayerHit(), eventPlayer, 500)
            break
        else: # If we didn't hit a player, we hit a wall. Update our raycast to start a little past the wall.
            createBeam(getAllPlayers(), Beam.MOIRA_ORB_DAMAGE, evalOnce(eventPlayer.chamberCast_Start), evalOnce(raycast(eventPlayer.chamberCast_Start, eventPlayer.chamberCast_Start + eventPlayer.chamberCast_DistRemaining * eventPlayer.chamberCast_Direction, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition()), eventPlayer.getTeam(), EffectReeval.VISIBILITY)
            eventPlayer.chamberCast_DistRemaining = eventPlayer.chamberCast_DistRemaining - distance(eventPlayer.chamberCast_Start, raycast(eventPlayer.chamberCast_Start, eventPlayer.getFacingDirection() * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition()) - 0.2
            eventPlayer.chamberCast_Start = raycast(eventPlayer.chamberCast_Start, eventPlayer.getFacingDirection() * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), false).getHitPosition() + (eventPlayer.chamberCast_Direction * 0.2)