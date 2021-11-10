#!mainFile "main.opy"

rule "[Dev] Create bots":
    @Event eachPlayer
    @Condition devTools == true
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    wait(0.333, Wait.ABORT_WHEN_FALSE)
    createDummy(random.choice(getAllHeroes()), getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getEyePosition(), eventPlayer.getFacingDirection())
    createDummy(random.choice(getAllHeroes()), eventPlayer.getTeam(), -1, eventPlayer.getEyePosition(), eventPlayer.getFacingDirection())
    #createDummy(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getEyePosition(), vect(0,100,0))
    #createDummy(Hero.SYMMETRA, eventPlayer.getTeam(), -1, eventPlayer.getEyePosition(), vect(0,100,0))
    TESTBOT = getLastCreatedEntity()
    wait()
    #TESTBOT.startForcingThrottle(1,1,0,0,0,0)
    #TESTBOT.setUltCharge(100)
    #wait(1)
    #TESTBOT.forceButtonPress(Button.ULTIMATE)

rule "[Dev] Destroy bots":
    @Event eachPlayer
    @Condition devTools == true
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    
    wait(0.333, Wait.ABORT_WHEN_FALSE)
    TESTBOT = null
    destroyAllDummies()

rule "[Dev] Free ultimate":
    @Event eachPlayer
    @Condition devTools == true
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isCommunicating(Comms.ULTIMATE_STATUS) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    getAllPlayers().setUltCharge(100)