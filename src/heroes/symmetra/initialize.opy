#!mainFile "../../main.opy"

rule "[Symmetra] Initialize":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.turretPos = vect(0,-1000,0)
    eventPlayer.turretEffects = []
    eventPlayer.turretTarget = null