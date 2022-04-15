#!mainFile "../../main.opy"

rule "[Zarya] Graviton Pit Cast":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.usingUltimateREAL == false
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.pitPosition = eventPlayer.getPosition()
    chase(eventPlayer.pitPosition, raycast(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30, null, eventPlayer, true).getHitPosition() + Vector.UP, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 20, null, eventPlayer, true).getHitPosition() + worldVector(vect(false, -100, -20), eventPlayer, Transform.ROTATION), null, eventPlayer, true).getHitPosition(), rate=9999, ChaseReeval.DESTINATION_AND_RATE)
    createEffect(eventPlayer, Effect.RING, Color.PURPLE, eventPlayer.pitPosition, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.pitEffects[0] = getLastCreatedEntity()
    createEffect(eventPlayer, Effect.RING, Color.BLACK, eventPlayer.pitPosition, 7.75, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.pitEffects[1] = getLastCreatedEntity()
    createInWorldText(eventPlayer, "CREATE {0} |                   | {1} CANCEL".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE)), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10 + vect(0, -0.65, 0)), 1.3, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
    eventPlayer.pitTexts[0] = getLastCreatedText()
    wait(0.128)
    waitUntil(eventPlayer.isDead() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 99999)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true:
        destroyInWorldText(eventPlayer.pitTexts[0])
        stopChasingVariable(eventPlayer.pitPosition)
        eventPlayer.setUltCharge(ultBoost)
        # pit animation
        playEffect(getAllPlayers(), DynamicEffect.TRACER_RECALL_REAPPEAR_SOUND, Color.WHITE, eventPlayer.pitPosition, 200)
        playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION_SOUND, Color.WHITE, eventPlayer.pitPosition, 150)
        playEffect(getAllPlayers(), DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.WHITE, eventPlayer.pitPosition, 75)
        playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.pitPosition, 50)
        eventPlayer.pitEffects[2] = getLastCreatedEntity()
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.PURPLE, eventPlayer.pitPosition, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[3] = getLastCreatedEntity()
        createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, eventPlayer.pitPosition, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[4] = getLastCreatedEntity()
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.PURPLE, eventPlayer.pitPosition, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[5] = getLastCreatedEntity()
        createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.RING, Color.RED, eventPlayer.pitPosition, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[6] = getLastCreatedEntity()
        wait(2)
        eventPlayer.usingUltimateREAL = true
        # pit actual effects
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.LIGHT_SHAFT, Color.PURPLE, eventPlayer.pitPosition - vect(0,12,0), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[7] = getLastCreatedEntity()
        createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.LIGHT_SHAFT, Color.RED, eventPlayer.pitPosition - vect(0,12,0), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[8] = getLastCreatedEntity()
        createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.pitPosition, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.pitEffects[9] = getLastCreatedEntity()
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer.pitPosition, 200)
        playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_PICKUP_EFFECT, Color.PURPLE, eventPlayer.pitPosition, 8)
        playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_PICKUP_EFFECT, Color.RED, eventPlayer.pitPosition, 8)
        wait(0.032)
        eventPlayer.allowButton(Button.PRIMARY_FIRE)
        eventPlayer.allowButton(Button.SECONDARY_FIRE)
        #graviton pit duration
        wait(7.5)
        destroyEffect(eventPlayer.pitEffects)
        destroyInWorldText(eventPlayer.pitTexts[0])
        eventPlayer.usingUltimateREAL = false
    else:
        destroyEffect(eventPlayer.pitEffects)
        destroyInWorldText(eventPlayer.pitTexts[0])
        stopChasingVariable(eventPlayer.pitPosition)
        wait(0.032)
        eventPlayer.allowButton(Button.PRIMARY_FIRE)
        eventPlayer.allowButton(Button.SECONDARY_FIRE)

rule "[Zarya] Explosion Effects":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.usingUltimateREAL == true
    
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer.pitPosition, 16)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.pitPosition, 16)
    playEffect(getAllPlayers(), DynamicEffect.SIGMA_HYPERSPHERE_IMPLOSION_SOUND, Color.RED, eventPlayer.pitPosition, 150)
    wait(0.5)
    if RULE_CONDITION:
        goto RULE_START

rule "[Zarya] Sink Enemies":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).usingUltimateREAL == true
    @Condition distance(getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition * vect(1,0,1), eventPlayer.getPosition() * vect(1,0,1)) <= 7.5
    @Condition eventPlayer.getPosition().y - getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition.y < 0.5
    
    # apply debuffs
    eventPlayer.disableEnvironmentCollision(true)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.moveSpeed[false] *= 0.6
    # create pit effects
    createEffect(getAllPlayers(), Effect.WIDOWMAKER_VENOM_MINE_TARGET, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.pitSinkEffect = getLastCreatedEntity()
    while (distance(getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition * vect(1,0,1), eventPlayer.getPosition() * vect(1,0,1)) <= 7.5) and getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).usingUltimateREAL == true and eventPlayer.getPosition().y - getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition.y < 0.5:
        # impulse downwards
        eventPlayer.applyImpulse(directionTowards(eventPlayer, getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition - vect(0,5,0)), 0.2, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        wait(0.04)
        # prevent infinite drop
        eventPlayer.applyImpulse(Vector.UP, 0.1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        # damage player if deep enough
        if distance(getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition * vect(0,1,0), eventPlayer.getPosition() * vect(0,1,0)) > 1.5 and eventPlayer.getPosition().y < getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition.y:
            eventPlayer.startDoT(getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())), 0.12, 100)
        wait(0.08)
    waitUntil(distance(getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()).pitPosition * vect(1,0,1), eventPlayer.getPosition() * vect(1,0,1)) > 7.5 or getPlayersOnHero(Hero.ZARYA, eventPlayer.getTeam()).usingUltimateREAL == false, 7.5)
    destroyEffect(eventPlayer.pitSinkEffect)
    # revert debuffs
    eventPlayer.enableEnvironmentCollision()
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.moveSpeed[false] /= 0.6
    # bring enemy back to surface if they survived
    eventPlayer.teleport(vect(eventPlayer.getPosition().x,getPlayersOnHero(Hero.ZARYA, getOppositeTeam(eventPlayer.getTeam())).pitPosition.y,eventPlayer.getPosition().z))