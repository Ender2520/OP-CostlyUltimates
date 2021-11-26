#!mainFile "../../main.opy"

rule "[Bastion] Heat Seeking Missile":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.missileTimer = 1
    eventPlayer.missileAOEVisual = 0
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0, 3, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -5, getAllPlayers(), eventPlayer, false).getHitPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, false).getHitPosition(), 20)
    eventPlayer.setMaxHealth(25)
    eventPlayer.setHealth(99999)
    eventPlayer.addHealthPool(Health.ARMOR, 225, true, false)
    eventPlayer.armorPool = getLastCreatedHealthPool()
    wait(1.5)
    chase(eventPlayer.missileTimer, 0, duration=4, ChaseReeval.NONE)
    chase(eventPlayer.missileAOEVisual, 7, duration=4, ChaseReeval.NONE)
    eventPlayer.moveSpeed[false] *= 1.75
    #
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect([p for p in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(p, eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS)], Effect.SPHERE, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect([p for p in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(p, eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS)], Effect.BAD_AURA, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(1, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 100)
    async(animationCleanup(), AsyncBehavior.NOOP)
    wait()
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.AQUA, eventPlayer.getEyePosition(), 14)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 14)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 7 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == getOppositeTeam(eventPlayer.getTeam()) and p.isAlive()], eventPlayer, 600 if eventPlayer.megaBoosted == true else 400)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 5 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == getOppositeTeam(eventPlayer.getTeam()) and p.isAlive()], eventPlayer, 600 if eventPlayer.megaBoosted == true else 400)
