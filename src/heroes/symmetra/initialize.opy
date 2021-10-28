#!mainFile "../../main.opy"

rule "[Symmetra] Info":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Super Turret"
    eventPlayer.ultDesc = " Locks onto nearby enemies within LoS, deals constant\n damage, and provides a movement debuff to the target."

rule "[Symmetra] Initialize":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.turretPos = vect(0,-1000,0)
    eventPlayer.turretEffects = []
    eventPlayer.turretTarget = null