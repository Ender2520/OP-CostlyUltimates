#!mainFile "../../main.opy"

rule "[Reaper] Teleport in Death Blossom":
    @Event playerEarnedElimination
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate()

    # check if there is at least 1 player in LOS (so reaper doesn't tp to 0,0,0)
    if len([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) and player.isAlive()]) > 0:
        playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.BLUE, evalOnce(eventPlayer.getPosition()), 2)
        playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, evalOnce(eventPlayer.getPosition()), 2)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.BLACK, evalOnce(eventPlayer.getPosition()), 3)
        # teleport to the closest player to reaper thats within LOS
        eventPlayer.teleport(sorted([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) and player.isAlive()], lambda i: distance(eventPlayer, i)))
    