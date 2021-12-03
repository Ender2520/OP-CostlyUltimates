#!mainFile "../../main.opy"

rule "[Zenyatta] Blinding Light Effects":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer.isUsingUltimate()
    
    eventPlayer.blindVictims = getPlayers(getOppositeTeam(eventPlayer.getTeam()))
    eventPlayer.i = 0
    # create blinding effects
    wait()
    for eventPlayer.i in range(len(eventPlayer.blindVictims)):
        createEffect(eventPlayer.blindVictims[evalOnce(eventPlayer.i)] if eventPlayer.blindVictims[evalOnce(eventPlayer.i)].zenVisible == true else null, Effect.SPHERE, Color.YELLOW, eventPlayer.blindVictims[evalOnce(eventPlayer.i)], 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.lightEffects.append(getLastCreatedEntity())
    waitUntil(eventPlayer.isUsingUltimate() != true, 6)
    destroyEffect(eventPlayer.lightEffects)
    eventPlayer.lightEffects = null
    eventPlayer.blindVictims = null

rule "[Zenyatta] Detect Zen Visibility":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())).isUsingUltimate()
    @Condition isInLoS(eventPlayer, getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())), BarrierLos.PASS_THROUGH_BARRIERS)
    @Condition eventPlayer.isInViewAngle(getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())), 59)

    eventPlayer.zenVisible = true
    getAllPlayers().startForcingOutlineFor(eventPlayer, false, Color.WHITE, OutlineVisibility.DEFAULT)
    eventPlayer.disableHeroHUD()
    wait(0.128)
    waitUntil(isInLoS(eventPlayer, getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())), BarrierLos.PASS_THROUGH_BARRIERS) != true or eventPlayer.isInViewAngle(getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())), 59) != true or eventPlayer.isDead() or getPlayersOnHero(Hero.ZENYATTA, getOppositeTeam(eventPlayer.getTeam())).isUsingUltimate() != true, 6)
    eventPlayer.zenVisible = false
    getPlayers(getOppositeTeam(eventPlayer.getTeam())).stopForcingOutlineFor(eventPlayer)
    eventPlayer.enableHeroHud()