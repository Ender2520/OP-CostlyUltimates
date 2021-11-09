#!mainFile "../../main.opy"

rule "[Doomfist] Cooldown Decrease SECONDARY":
    @Event eachPlayer
    @Hero doomfist
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    wait(0.256, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 1.744)

rule "[Doomfist] Cooldown Decrease ABILITY1":
    @Event eachPlayer
    @Hero doomfist
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    wait(0.256, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 1.744)

rule "[Doomfist] Cooldown Decrease ABILITY2":
    @Event eachPlayer
    @Hero doomfist
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    wait(0.256, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 1.744)