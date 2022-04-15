#!mainFile "../../main.opy"

rule "[Tracer] Info":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Manipulative Reality"
    eventPlayer.ultDesc = " Tracer gains complete control of reality.\n She is provided with infinite ammo,\n and can teleport around at will."
    eventPlayer.ultTooltip = "After Manipulating Reality, Tracer will be left with\n no ammo, no blinks, and no recall."