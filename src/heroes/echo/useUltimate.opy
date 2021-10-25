#!mainFile "../../main.opy"

rule "[Echo] Detect Ultimate Use":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0+ultBoost)
    wait(0.1)
    eventPlayer.usingUltimateREAL = false

rule "[Echo] Decrease Enemy Ultimate Charge":
    @Event eachPlayer
    @Condition any([player.isAlive() and player.usingUltimateREAL == true for player in getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()))])

    # decrease enemy ult charge by a certain percent of their current charge depending on there distance from echo.
    # graph demo here: https://www.desmos.com/calculator/wudcnjsrwc
    eventPlayer.setUltCharge(eventPlayer.getUltCharge() * (1-((1.5**(-0.05*(distance(eventPlayer, getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()))))+11.35775))/100)))
