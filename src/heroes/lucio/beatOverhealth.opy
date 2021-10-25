#!mainFile "../../main.opy"

rule "[Lucio] Provide Health to Teammates from Beat":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.usingUltimateREAL != true
    
    # dont beat until on ground
    waitUntil(eventPlayer.isOnGround(), 99999)
    # prevent multiple overhealth assignments
    eventPlayer.usingUltimateREAL = true
    # assign players meeting conditions overhealth
    [p for p in getPlayers(eventPlayer.getTeam()) if isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and distance(eventPlayer, p) <= 30].addHealthPool(Health.NORMAL, 400, false, false)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.usingUltimateREAL = false