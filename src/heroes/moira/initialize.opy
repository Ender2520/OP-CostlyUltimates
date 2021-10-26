#!mainFile "../../main.opy"

rule "[Moira] Info":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Coalnado"
    eventPlayer.ultDesc = " Creates a Coalescence tornado that travels in a straight path\n that damages enemies within the radius and heals teammates\n within the radius."