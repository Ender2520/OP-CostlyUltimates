#!mainFile "../../main.opy"

rule "[Hanzo] Fire Several Dragonstrikes":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.isUsingUltimate() == true
    
    # set number of dragon strike -1
    eventPlayer.dragonStrikeCharges = 3
    # run loop 4 times
    while eventPlayer.dragonStrikeCharges > 0:
        waitUntil(not eventPlayer.isUsingUltimate(), 99999)
        eventPlayer.setUltCharge(100)
        wait()
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        eventPlayer.dragonStrikeCharges -= 1
    wait(1)