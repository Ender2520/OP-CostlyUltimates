#!mainFile "../../main.opy"

rule "[Echo] Detect Ultimate Use":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    # initialize
    eventPlayer.usingUltimateREAL = true
    eventPlayer.counterpoiseSize = 0
    eventPlayer.setUltCharge(0+ultBoost)
    wait()
    # create effects
    chase(eventPlayer.counterpoiseSize, 100, duration=1, ChaseReeval.NONE)
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.SKY_BLUE, eventPlayer.getPosition(), eventPlayer.counterpoiseSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.counterpoiseEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, eventPlayer.getPosition(), eventPlayer.counterpoiseSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.counterpoiseEffects.append(getLastCreatedEntity())
    # play effects
    # activation visuals
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, getOppositeTeam(eventPlayer.getTeam()), eventPlayer.getEyePosition(), 20)
    # activation audio
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.HANZO_SONIC_ARROW_INITIAL_PULSE_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.WINSTON_JUMP_PACK_LANDING_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 200)
    # revert changes
    wait(1)
    destroyEffect(eventPlayer.counterpoiseEffects)
    stopChasingVariable(eventPlayer.counterpoiseSize)
    eventPlayer.counterpoiseEffects = []
    eventPlayer.usingUltimateREAL = false

rule "[Echo] Decrease Enemy Ultimate Charge":
    @Event eachPlayer
    @Condition any([player.isAlive() and player.usingUltimateREAL == true for player in getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()))])

    # decrease enemy ult charge by a certain percent of their current charge depending on there distance from echo.
    # graph demo here: https://www.desmos.com/calculator/trd2dryhzd (thanks to T1mur4TR for the equation)
    eventPlayer.setUltCharge(eventPlayer.getUltCharge() * (1-((((2756.25)/(distance(eventPlayer, getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam())))+22.5))-22.5)/100)))
    eventPlayer.isStatused[1] = true
    wait(1)
    eventPlayer.isStatused[1] = false
