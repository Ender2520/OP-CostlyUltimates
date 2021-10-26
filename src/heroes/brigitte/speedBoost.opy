#!mainFile "../../main.opy"

rule "[Brigitte] Self Speed Increase":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.moveSpeed[false] *= 1.154
    waitUntil(not eventPlayer.isUsingUltimate() or eventPlayer.isDead(), 99999)
    getPlayers(eventPlayer.getTeam()).brigSpeedBoost = false
    eventPlayer.moveSpeed[false] /= 1.154

rule "[Brigitte] Ally Speed Boost Assignment":
    @Event eachPlayer
    @Condition any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player != eventPlayer for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())])

    eventPlayer.brigSpeedBoost = true
    waitUntil(([player.isDead() or not player.isUsingUltimate() or distance(player, eventPlayer) >= 8.5 or not isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]), 8.5)
    wait(1, Wait.RESTART_WHEN_TRUE)
    eventPlayer.brigSpeedBoost = false

rule "[Brigitte] Ally Speed Boost":
    @Event eachPlayer
    @Condition eventPlayer.brigSpeedBoost == true

    eventPlayer.moveSpeed[false] *= 1.5
    waitUntil(eventPlayer.brigSpeedBoost != true, 999)
    eventPlayer.moveSpeed[false] /= 1.5