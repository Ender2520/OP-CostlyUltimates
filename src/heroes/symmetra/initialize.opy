#!mainFile "../../main.opy"

rule "[Symmetra] Info":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Super Turret"
    eventPlayer.ultDesc = " Symmetra creates a large turret that locks onto nearby\n enemies within LoS, deals constant damage, and\n provides a movement debuff to the target."
    eventPlayer.ultTooltip = "Super Turret can be destroyed by the enemy team."