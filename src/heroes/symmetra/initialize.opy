#!mainFile "../../main.opy"

rule "[Symmetra] Info":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Super Turret"
    eventPlayer.ultDesc = " Symmetra creates a large turret that locks onto nearby\n enemies within LoS, deals constant damage, and\n provides a movement debuff to the target."

rule "[Symmetra] Initialize":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.turretPos = vect(0,-1000,0)
    eventPlayer.turretEffects = []
    eventPlayer.turretTarget = null
