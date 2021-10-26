#!mainFile "../../main.opy"

rule "[Sombra] Info":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " VMP"
    eventPlayer.ultDesc = " Enemies within the range become vulnerable.\n Vulnerable players take 200% damage."

rule "[Sombra] Initialize":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)