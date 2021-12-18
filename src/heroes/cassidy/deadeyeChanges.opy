#!mainFile "../../main.opy"

rule "[Cassidy] Deadeye Changes":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    if len([p for p in getAllPlayers() if p.getCurrentHero() in [Hero.MCCREE, Hero.SOLDIER] and (p.isUsingUltimate() == true or p.usingUltimateREAL == true)]) > 0:
        smallMessage(eventPlayer, "Too many ultimates active! Try again in a moment!")
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 100)
        wait()
        return
    else:
        eventPlayer.allowButton(Button.ULTIMATE)
        wait()
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        eventPlayer.disallowButton(Button.ULTIMATE)
        # initialize changes
        eventPlayer.moveSpeed[false] *= 3.33333
        createDummy(Hero.BRIGITTE, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), directionTowards(eventPlayer, eventPlayer.getFacingDirection() * 50))
        eventPlayer.cassidyShieldBot = getLastCreatedEntity()
        wait()
        # modify dummy bot
        eventPlayer.cassidyShieldBot.startScalingBarriers(10, false)
        eventPlayer.cassidyShieldBot.startScalingSize(0.1, false)
        eventPlayer.cassidyShieldBot.startForcingName("Deadeye Shield")
        eventPlayer.cassidyShieldBot.attachTo(eventPlayer, vect(0,0.85,1))
        eventPlayer.cassidyShieldBot.startForcingPosition(updateEveryTick(worldVector(vect(0,0.85,1), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
        eventPlayer.cassidyShieldBot.startFacing(updateEveryTick(eventPlayer.getFacingDirection()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        eventPlayer.cassidyShieldBot.setStatusEffect(null, Status.PHASED_OUT, 9999)
        # shield bot hold up shield
        eventPlayer.cassidyShieldBot.startForcingButton(Button.SECONDARY_FIRE)
        waitUntil(not eventPlayer.isUsingUltimate(), 99999)
        # undo all changes
        destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
        eventPlayer.moveSpeed[false] /= 3.33333
