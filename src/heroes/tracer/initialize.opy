#!mainFile "../../main.opy"

rule "[Tracer] Info":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Manipulative Reality"
    eventPlayer.ultDesc = " Tracer gains complete control of reality,\n and can teleport around at will."

rule "[Tracer] Initialize":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)
