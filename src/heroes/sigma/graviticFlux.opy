#!mainFile "../../main.opy"

rule "[Sigma] Set Flux Center":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingUltimate()

    wait(0.6)
    createEffect(eventPlayer, Effect.RING, Color.BLUE, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 35, null, getAllPlayers(), false).getHitPosition()), 12, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fluxExtraRangeEffect = getLastCreatedEntity()
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or not eventPlayer.isUsingUltimate(), 9999)
    destroyEffect(eventPlayer.fluxExtraRangeEffect)
    if eventPlayer.isUsingUltimate():
        eventPlayer.fluxCenter = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 35, null, getAllPlayers(), false).getHitPosition()
        waitUntil(not eventPlayer.isUsingUltimate() or eventPlayer.isDead(), 9999)
        eventPlayer.fluxCenter = null

rule "[Sigma] Pull Enemies Towards Gravitic Flux":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))])

    waitUntil([player.fluxCenter != null for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))], 9999)
    wait(0.5)
    if any([distance(eventPlayer, player.fluxCenter) <= 12 for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))]) == true:
        eventPlayer.applyImpulse(directionTowards(eventPlayer, getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam())).fluxCenter  + vect(0, 1, 0)), 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
