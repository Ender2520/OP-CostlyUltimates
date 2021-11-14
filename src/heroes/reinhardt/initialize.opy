#!mainFile "../../main.opy"

rule "[Reinhardt] Info":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Earthshatter"
    eventPlayer.ultDesc = " Reinhardt shatters enemy spinal cords causing them\n to be stunned for a very long duration."
    eventPlayer.ultTooltip = null
