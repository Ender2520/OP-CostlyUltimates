#!mainFile "../../main.opy"

rule "[Soldier 76] Info":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.spawnedREAL == true
    @Condition not eventPlayer.isDummy()

    wait(0.2) 
    eventPlayer.ultName = " Helix Pack"
    eventPlayer.ultDesc = " Soldier equips a Helix Pack that fires several\n Helix Rockets in quick succession from\n your shoulders."
    eventPlayer.ultTooltip = "Helix Pack rockets deal 50% damage to shields."