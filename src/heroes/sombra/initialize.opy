#!mainFile "../../main.opy"

rule "[Sombra] Info":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " EXP"
    eventPlayer.ultDesc = " Enemies within the range become vulnerable.\n Vulnerabled players take greatly increased damage."
    eventPlayer.ultTooltip = "Vulnerabled players do not become hacked as well."

rule "[Sombra] Initialize":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
