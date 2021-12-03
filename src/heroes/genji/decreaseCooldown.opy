#!mainFile "../../main.opy"

rule "[Genji] Cooldown Decrease DASH":
    @Event eachPlayer
    @Hero genji
    # detect dash on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.5
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0.5 if eventPlayer.megaBoosted != true else 0)

rule "[Genji] Cooldown Decrease DEFLECT":
    @Event eachPlayer
    @Hero genji
    # detect deflect on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.5
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0.5 if eventPlayer.megaBoosted != true else 0)
