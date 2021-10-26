#!mainFile "../../main.opy"

rule "[Bastion] Info":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Heat-Seeking Missile"
    eventPlayer.ultDesc = " Bastion turns into an explosive with increased movement speed\n that explodes after 4 seconds and deals massive damage to\n nearby enemies."