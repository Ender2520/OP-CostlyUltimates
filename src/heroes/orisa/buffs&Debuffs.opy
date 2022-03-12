#!mainFile "../../main.opy"

rule "[Orisa] Buff Teammates in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())])
    
    # STATUS
    eventPlayer.isStatused[2] = true
    # assign values to players who meet the conditions
    eventPlayer.orisaBuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.isStatused[2] = false
    eventPlayer.orisaBuffs = false

rule "[Orisa] Debuff Enemies in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))])
    
    # STATUS
    eventPlayer.isStatused[3] = true
    # assign values to players who meet the conditions
    eventPlayer.orisaDebuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.isStatused[3] = false
    eventPlayer.orisaDebuffs = false

rule "[Orisa] Apply Buffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaBuffs == true

    # apply buffs
    eventPlayer.moveSpeed[false] *= 1.20
    eventPlayer.startHoT([p for p in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())], 9999, 14)
    eventPlayer.superchargerHoT = getLastHoT()
    waitUntil(eventPlayer.orisaBuffs != true, 999)
    eventPlayer.moveSpeed[false] /= 1.20
    stopHoT(eventPlayer.superchargerHoT)

rule "[Orisa] Apply Debuffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaDebuffs == true

    # apply debuffs
    eventPlayer.moveSpeed[false] /= 1.40
    eventPlayer.setStatusEffect([p for p in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())], Status.HACKED, 9999)
    waitUntil(eventPlayer.orisaDebuffs != true, 999)
    eventPlayer.clearStatusEffect(Status.HACKED)
    eventPlayer.moveSpeed[false] *= 1.40