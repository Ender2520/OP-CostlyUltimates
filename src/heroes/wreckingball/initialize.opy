#!mainFile "../../main.opy"

rule "[Wrecking Ball] Info":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Trap Transfer"
    eventPlayer.ultDesc = " Stun nearby enemies in place who if do not kill you,\n after a short duration will explode!"
    eventPlayer.ultTooltip = null

rule "[Wrecking Ball] Initialize":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
