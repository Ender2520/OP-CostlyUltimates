#!mainFile "../../main.opy"

rule "[Moira] Info":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Coalnado"
    eventPlayer.ultDesc = " Creates a Coalescence tornado that travels in a straight path\n that damages enemies within the radius and heals teammates\n within the radius."

rule "[Moira] Initialize":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.tornadoPos = vect(0,-1000,0)
    eventPlayer.tornadoEffects = []
    eventPlayer.tornadoTexts = []