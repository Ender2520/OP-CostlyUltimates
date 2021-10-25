#!mainFile "../../main.opy"

rule "[Genji] Cooldown Decrease DASH":
    @Event eachPlayer
    # detect dash on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)