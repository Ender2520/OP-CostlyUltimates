#!mainFile "../../main.opy"

rule "[Mccree] Deadeye Changes":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    # initialize changes
    eventPlayer.moveSpeed[false] *= 3.33333
    createDummy(Hero.BRIGITTE, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), directionTowards(eventPlayer, eventPlayer.getFacingDirection() * 50))
    eventPlayer.mccreeShieldBot = getLastCreatedEntity()
    wait()
    # modify dummy bot
    eventPlayer.mccreeShieldBot.startScalingBarriers(20, false)
    eventPlayer.mccreeShieldBot.startScalingSize(0.1, false)
    eventPlayer.mccreeShieldBot.startForcingName("Deadeye Shield")
    eventPlayer.mccreeShieldBot.attachTo(eventPlayer, vect(0,0.75,1.25))
    eventPlayer.mccreeShieldBot.startForcingPosition(updateEveryTick(worldVector(vect(0,0.75,1.25), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
    eventPlayer.mccreeShieldBot.startFacing(updateEveryTick(eventPlayer.getFacingDirection()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # shield bot hold up shield
    eventPlayer.mccreeShieldBot.startForcingButton(Button.SECONDARY_FIRE)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    # undo all changes
    destroyDummy(eventPlayer.getTeam(), eventPlayer.mccreeShieldBot.getSlot())
    eventPlayer.moveSpeed[false] /= 3.33333
