#!mainFile "../../main.opy"

rule "[Bastion] Heat Seeking Missile":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.missileTimer = 1
    eventPlayer.missileAOEVisual = 0
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0, 3, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -5, getAllPlayers(), eventPlayer, false).getHitPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, false).getHitPosition(), 20)
    wait(1.5)
    chase(eventPlayer.missileTimer, 0, duration=4, ChaseReeval.DESTINATION_AND_DURATION)
    chase(eventPlayer.missileAOEVisual, 7.5, duration=4, ChaseReeval.DESTINATION_AND_DURATION)
    eventPlayer.moveSpeed[false] *= 1.75
    #
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(1, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait()
    async(animationCleanup(), AsyncBehavior.RESTART)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.AQUA, eventPlayer.getEyePosition(), 16)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 16)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 7.5 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == getOppositeTeam(eventPlayer.getTeam()) and p.isAlive()], eventPlayer, 1000)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 7.5 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == eventPlayer.getTeam() and p.isAlive()], eventPlayer, 100)
