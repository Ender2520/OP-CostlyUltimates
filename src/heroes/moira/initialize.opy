#!mainFile "../../main.opy"

rule "[Moira] Info":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Coalnado"
    eventPlayer.ultDesc = " Moira summons a Coalescence tornado that travels forwards\n and damages enemies within the radius and heals teammates\n within the radius."
    eventPlayer.ultTooltip = null