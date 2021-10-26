#!mainFile "../../main.opy"

rule "[Cassidy] Deadeye Changes":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    # initialize changes
    eventPlayer.moveSpeed[false] *= 3.33333
    createDummy(Hero.BRIGITTE, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), directionTowards(eventPlayer, eventPlayer.getFacingDirection() * 50))
    eventPlayer.cassidyShieldBot = getLastCreatedEntity()
    wait()
    # modify dummy bot
    eventPlayer.cassidyShieldBot.startScalingBarriers(20, false)
    eventPlayer.cassidyShieldBot.startScalingSize(0.1, false)
    eventPlayer.cassidyShieldBot.startForcingName("Deadeye Shield")
    eventPlayer.cassidyShieldBot.attachTo(eventPlayer, vect(0,0.75,1.25))
    eventPlayer.cassidyShieldBot.startForcingPosition(updateEveryTick(worldVector(vect(0,0.75,1.25), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
    eventPlayer.cassidyShieldBot.startFacing(updateEveryTick(eventPlayer.getFacingDirection()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # shield bot hold up shield
    eventPlayer.cassidyShieldBot.startForcingButton(Button.SECONDARY_FIRE)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    # undo all changes
    destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
    eventPlayer.moveSpeed[false] /= 3.33333
