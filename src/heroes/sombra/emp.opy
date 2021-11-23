#!mainFile "../../main.opy"

rule "[Sombra] Apply vulnerabled effect":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    
    # initialize emp
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0)
    eventPlayer.empRadius = 0
    eventPlayer.i = 0
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.PURPLE, evalOnce(eventPlayer.getPosition()), eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, evalOnce(eventPlayer.getPosition()), eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    # make that little floating effect when using default EMP
    wait()
    eventPlayer.applyImpulse(Vector.UP, 0.5, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setGravity(10)
    eventPlayer.setKnockbackReceived(25)
    # sound/visual queue
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_LOGO_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    wait(0.35)
    # expand sphere
    chase(eventPlayer.empRadius, 15, duration=0.25, ChaseReeval.NONE)
    eventPlayer.vulnerabledVictims = getPlayersInRadius(eventPlayer, 15, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES)
    wait(0.1)
    # give vulnerability and player-specific queues to victims
    for eventPlayer.i in range(len(eventPlayer.vulnerabledVictims)):
        createEffect(getAllPlayers(), Effect.SOMBRA_HACKED_LOOPING, eventPlayer.getTeam(), eventPlayer.vulnerabledVictims[evalOnce(eventPlayer.i)], 1, EffectReeval.VISIBILITY)
        eventPlayer.victimEffects.append(getLastCreatedEntity())
        playEffect(eventPlayer.vulnerabledVictims[evalOnce(eventPlayer.i)], DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.WHITE, eventPlayer.vulnerabledVictims[evalOnce(eventPlayer.i)].getPosition(), 200)
    eventPlayer.vulnerabledVictims.damageReceived *= 1.50
    eventPlayer.vulnerabledVictims.isStatused[4] = true
    eventPlayer.vulnerabledVictims.vulnerabledSTIMER = 5
    wait(0.1)
    # revert floating effect
    eventPlayer.setGravity(100)
    eventPlayer.setKnockbackReceived(100)
    wait()
    # destroy effect
    destroyEffect(eventPlayer.empEffect)
    eventPlayer.empEffect = null
    wait(4.9)
    # revert changes
    destroyEffect(eventPlayer.victimEffects)
    eventPlayer.vulnerabledVictims.isStatused[4] = false
    eventPlayer.victimEffects = null
    eventPlayer.vulnerabledVictims.damageReceived /= 1.50
    eventPlayer.i = 0
    wait()
    eventPlayer.vulnerabledVictims = null
    eventPlayer.usingUltimateREAL = false
