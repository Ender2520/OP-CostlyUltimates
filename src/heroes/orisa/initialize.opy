#!mainFile "../../main.opy"

rule "[Orisa] Info":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Supercharger"
    eventPlayer.ultDesc = " Orisa takes control of a large area of the map that weakens enemies\n within the radius and strengthens teammates\n within the radius."
    eventPlayer.ultTooltip = null
