#!mainFile "../../main.opy"

rule "[Pharah] Info":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Artillery Strike"
    eventPlayer.ultDesc = " Pharah calls down several air strikes on her opponents\n that deal massive damage to enemies within range."
    eventPlayer.ultTooltip = "Artillery Strike can be used only when\n there is enough space above you!"

rule "[Pharah] Initialize":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
