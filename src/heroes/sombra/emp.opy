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
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.PURPLE, eventPlayer.getPosition(), eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, eventPlayer.getPosition(), eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    # make that little floating effect when using default EMP
    eventPlayer.applyImpulse(Vector.UP, 1.5, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setGravity(10)
    eventPlayer.setKnockbackReceived(25)
    # sound/visual queue
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_LOGO_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    wait(0.35)
    # expand sphere
    chase(eventPlayer.empRadius, 15, duration=0.25, ChaseReeval.NONE)
    eventPlayer.vulnerabledVictims = getPlayersInRadius(eventPlayer, 15, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES)
    wait(0.25)
    # revert floating effect
    eventPlayer.setGravity(100)
    eventPlayer.setKnockbackReceived(100)
    # give vulnerability and player-specific queues to victims
    playEffect(eventPlayer.vulnerabledVictims, DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.WHITE, eventPlayer.vulnerabledVictims.getPosition(), 200)
    for eventPlayer.i in range(len(eventPlayer.vulnerabledVictims)):
        createEffect(getAllPlayers(), Effect.SOMBRA_HACKED_LOOPING, eventPlayer.getTeam(), eventPlayer.vulnerabledVictims[evalOnce(eventPlayer.i)].getPosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.victimEffects.append(getLastCreatedEntity())
        #createEffect(getAllPlayers(), Effect.SOMBRA_HACKED_SOUND, eventPlayer.getTeam(), eventPlayer.vulnerabledVictims[evalOnce(eventPlayer.i)].getPosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.victimEffects.append(getLastCreatedEntity())
        eventPlayer.vulnerabledVictims.damageReceived *= 1.65
    # destroy effect
    destroyEffect(eventPlayer.empEffect)
    eventPlayer.empEffect = null
    wait(5)
    # revert changes
    destroyEffect(eventPlayer.victimEffects)
    eventPlayer.victimEffects = null
    eventPlayer.vulnerabledVictims.damageReceived /= 1.65
    eventPlayer.vulnerabledVictims = null
    eventPlayer.usingUltimateREAL = false
    eventPlayer.i = 0
