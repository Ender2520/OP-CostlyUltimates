#!mainFile "../../main.opy"

rule "[Torbjorn] Info":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.spawnedREAL == true

    wait(0.2) 
    eventPlayer.ultName = " Meteor Strike"
    eventPlayer.ultDesc = " Torbjorn forges a giant meteor that falls from the sky\n dealing lethal damage to enemies within range.\n Leaving behind a lava pit after landing."
    eventPlayer.ultTooltip = "Meteor Strike can be used only when\n there is enough space above you!"
