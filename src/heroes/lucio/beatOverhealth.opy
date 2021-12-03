#!mainFile "../../main.opy"

rule "[Lucio] Provide Health to Teammates from Beat":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.usingUltimateREAL != true
    
    # prevent pre-emptive beat
    wait(0.128)
    # dont beat until on ground
    waitUntil(eventPlayer.isOnGround(), 99999)
    # prevent multiple overhealth assignments
    eventPlayer.usingUltimateREAL = true
    # assign players meeting conditions overhealth
    for eventPlayer.i in range(len([p for p in getPlayers(eventPlayer.getTeam()) if isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and distance(eventPlayer, p) <= 30])):
        ([p for p in getPlayers(eventPlayer.getTeam()) if isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and distance(eventPlayer, p) <= 30])[eventPlayer.i].addHealthPool(Health.NORMAL, 250 if eventPlayer.megaBoosted != true else 375, false, false)
        ([p for p in getPlayers(eventPlayer.getTeam()) if isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and distance(eventPlayer, p) <= 30])[eventPlayer.i].overHealthPool = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.usingUltimateREAL = false