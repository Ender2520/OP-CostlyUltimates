#!mainFile "../../main.opy"

rule "[Bastion] Info":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Heat-Seeking Missile"
    eventPlayer.ultDesc = " Turn into a speedy explosive that will explode and deal\n massive amounts of damage to nearby enemies\n after a short duration."
    eventPlayer.ultTooltip = "Bastion will die when he explodes."
