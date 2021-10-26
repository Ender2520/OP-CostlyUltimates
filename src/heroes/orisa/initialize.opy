#!mainFile "../../main.opy"

rule "[Orisa] Info":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Supercharger"
    eventPlayer.ultDesc = " Creates a large zone that weakens enemies within the\n radius and strengthens teammates within the radius."