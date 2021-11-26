#!mainFile "../../main.opy"

rule "[Zenyatta] Info":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Blinding Light"
    eventPlayer.ultDesc = " Blinding Light will blind any enemies that can see Zenyatta."
    eventPlayer.ultTooltip = null