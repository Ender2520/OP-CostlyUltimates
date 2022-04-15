#!mainFile "../../main.opy"

rule "[Genji] Cooldown Decrease DASH":
    @Event eachPlayer
    @Hero genji
    # detect dash on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.67
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0.67 if eventPlayer.megaBoosted != true else 0)

rule "[Genji] Cooldown Decrease DEFLECT":
    @Event eachPlayer
    @Hero genji
    # detect deflect on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.67
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0.67 if eventPlayer.megaBoosted != true else 0)

rule "[Genji] Increase Damage":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate()
    
    eventPlayer.damageDealt[false] *= 1.0909
    waitUntil(eventPlayer.isUsingUltimate() != true or eventPlayer.isDead(), 9999)
    eventPlayer.damageDealt[false] /= 1.0909
