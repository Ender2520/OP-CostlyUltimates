#!mainFile "../../main.opy"

rule "[Brigitte] Rally Cooldown Decrease PRIMARY":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.PRIMARY_FIRE) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.PRIMARY_FIRE, 0.75 * eventPlayer.getAbilityCooldown(Button.PRIMARY_FIRE))

rule "[Brigitte] Rally Cooldown Decrease SECONDARY":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0.75 * eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE))

rule "[Brigitte] Rally Cooldown Decrease ABILITY1":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0.75 * eventPlayer.getAbilityCooldown(Button.ABILITY_1))

rule "[Brigitte] Rally Cooldown Decrease ABILITY2":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0.75 * eventPlayer.getAbilityCooldown(Button.ABILITY_2))