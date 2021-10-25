#!mainFile "../../main.opy"

rule "[Orisa] Buff Teammates in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())])
    
    # assign values to players who meet the conditions
    eventPlayer.orisaBuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.orisaBuffs = false

rule "[Orisa] Debuff Enemies in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))])
    
    # assign values to players who meet the conditions
    eventPlayer.orisaDebuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.orisaDebuffs = false

rule "[Orisa] Apply Buffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaBuffs == true

    # apply buffs
    eventPlayer.damageDealt[false] *= 1.25
    eventPlayer.damageReceived[false] *= 0.75
    waitUntil(eventPlayer.orisaBuffs != true, 999)
    eventPlayer.damageDealt[false] /= 1.25
    eventPlayer.damageReceived[false] /= 0.75

rule "[Orisa] Apply Debuffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaDebuffs == true

    # apply debuffs
    eventPlayer.damageDealt[false] *= 0.75
    eventPlayer.damageReceived[false] *= 1.25
    waitUntil(eventPlayer.orisaDebuffs != true, 999)
    eventPlayer.damageDealt[false] /= 0.75
    eventPlayer.damageReceived[false] /= 1.25