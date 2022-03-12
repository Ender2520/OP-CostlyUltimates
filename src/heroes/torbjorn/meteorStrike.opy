#!mainFile "../../main.opy"

# CREDITS TO LEMONAID
rule "[Torbjorn] Meteor Strike Activate":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 7.5, BarrierLos.PASS_THROUGH_BARRIERS) == true

    if eventPlayer.isInAir():
        smallMessage(eventPlayer, "Can't Use Ultimate Mid-Air!")
    else:
        # initalize
        eventPlayer.usingUltimateREAL = true
        eventPlayer.strikeCount = 0
        eventPlayer.setKnockbackReceived(0)
        eventPlayer.strikeAvailable = true
        eventPlayer.disallowButton(Button.JUMP)
        eventPlayer.disallowButton(Button.CROUCH)
        eventPlayer.disallowButton(Button.ABILITY_1)
        eventPlayer.disallowButton(Button.ABILITY_2)
        eventPlayer.disallowButton(Button.PRIMARY_FIRE)
        eventPlayer.disallowButton(Button.SECONDARY_FIRE)
        eventPlayer.disallowButton(Button.MELEE)
        eventPlayer.moveSpeed[false] /= 1000
        eventPlayer.strikeTimer = 1
        # create camera
        eventPlayer.camPos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 50, null, getAllPlayers(), true).getHitPosition()
        wait(0.1)
        # create eventPlayer effects
        playEffect(getAllPlayers(), DynamicEffect.REINHARDT_FIRE_STRIKE_TARGET_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 150)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 75)
        createEffect(eventPlayer, Effect.LIGHT_SHAFT, Color.GRAY, raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 100, null, getAllPlayers(), true).getHitPosition(), 12, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.strikeEffects[0] = getLastCreatedEntity()
        createInWorldText(eventPlayer, "                                      {0} Fire                                                                      Zoom | Out [{1}] - In [{2}]".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), buttonString(Button.CROUCH)), updateEveryTick(eventPlayer.camPos + Vector.DOWN * 15), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
        eventPlayer.strikeTexts = getLastCreatedText()
        createProgressBarInWorldText(eventPlayer, eventPlayer.strikeTimer * 100, "", updateEveryTick(eventPlayer.camPos + Vector.DOWN * 15), 0.5, Clip.NONE, Color.ORANGE, Color.ORANGE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
        eventPlayer.strikeTexts_ = getLastCreatedText()
        # start camera
        eventPlayer.startCamera(eventPlayer.camPos, updateEveryTick(eventPlayer.camPos + Vector.DOWN * 1), 100)
        # start time
        chase(eventPlayer.strikeTimer, 0, duration=15, ChaseReeval.NONE)
        waitUntil(eventPlayer.strikeCount == 1 or eventPlayer.isDead() or eventPlayer.strikeTimer == 0, 99999)
        stopChasingVariable(eventPlayer.strikeTimer)
        # determine whether to use ultimate or not
        if (eventPlayer.strikeCount == 1): # successfully ulted
            # ultimate voice line
            eventPlayer.allowButton(Button.ULTIMATE)
            eventPlayer.forceButtonPress(Button.ULTIMATE)
            eventPlayer.disallowButton(Button.ULTIMATE)
            eventPlayer.disallowButton(Button.PRIMARY_FIRE)
            eventPlayer.setUltCharge(0)
            # destroy effects
            destroyInWorldText(eventPlayer.strikeTexts)
            destroyProgressBarInWorldText(eventPlayer.strikeTexts_)
            destroyEffect(eventPlayer.strikeEffects)
            # cancel ultimate
            wait(1.675)
            # revert changes
            eventPlayer.stopCamera()
            eventPlayer.moveSpeed[false] *= 1000
            eventPlayer.stopFacing()
            eventPlayer.setFacing(Vector.FORWARD, Relativity.TO_PLAYER)
            eventPlayer.allowButton(Button.JUMP)
            eventPlayer.allowButton(Button.CROUCH)
            eventPlayer.allowButton(Button.ABILITY_1)
            eventPlayer.allowButton(Button.ABILITY_2)
            eventPlayer.allowButton(Button.SECONDARY_FIRE)
            eventPlayer.allowButton(Button.PRIMARY_FIRE)
            eventPlayer.allowButton(Button.MELEE)
            eventPlayer.setKnockbackReceived(100)
        else: # player died mid-ultimate
            eventPlayer.setUltCharge(0)
            # destroy effects
            destroyInWorldText(eventPlayer.strikeTexts)
            destroyProgressBarInWorldText(eventPlayer.strikeTexts_)
            destroyEffect(eventPlayer.strikeEffects)
            wait(0.5)
            # revert changes
            eventPlayer.stopCamera()
            eventPlayer.moveSpeed[false] *= 1000
            eventPlayer.stopFacing()
            eventPlayer.setFacing(Vector.FORWARD, Relativity.TO_PLAYER)
            eventPlayer.allowButton(Button.JUMP)
            eventPlayer.allowButton(Button.CROUCH)
            eventPlayer.allowButton(Button.ABILITY_1)
            eventPlayer.allowButton(Button.ABILITY_2)
            eventPlayer.allowButton(Button.SECONDARY_FIRE)
            eventPlayer.allowButton(Button.MELEE)
            eventPlayer.setKnockbackReceived(100)
            eventPlayer.usingUltimateREAL = false


rule "[Torbjorn] Horizontal Camera Movement":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isMoving() == true
    @Condition eventPlayer.usingUltimateREAL == true
    
    chase(eventPlayer.camPos, updateEveryTick(eventPlayer.camPos + eventPlayer.getThrottle() * 15), rate=16.5 if eventPlayer.isMoving() else false, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(eventPlayer.getThrottle() == vect(0, 0, 0), 99999)
    wait(0.25, Wait.RESTART_WHEN_TRUE)
    stopChasingVariable(eventPlayer.camPos)
    if RULE_CONDITION:
        goto RULE_START

rule "[Torbjorn] Move Camera Up":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition().y <= (eventPlayer.getPosition() + vect(0,50,0)).y
    
    eventPlayer.camPos = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition()

rule "[Torbjorn] Move Camera Down":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 5, null, eventPlayer, true).getHitPosition().y >= (eventPlayer.getPosition() + vect(0,5,0)).y

    eventPlayer.camPos = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 5, null, eventPlayer, true).getHitPosition()

rule "[Torbjorn] Meteor Strike Fired":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.hasStatusEffect(Status.HACKED)) == false
    @Condition eventPlayer.strikeAvailable == true
    @Condition eventPlayer.strikeCount == 0
    
    eventPlayer.strikeAvailable = false
    eventPlayer.strikeCount += 1
    eventPlayer.strikeDrop1 = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 1000, null, getAllPlayers(), true).getHitPosition()
    eventPlayer.strikeLaunch1 = eventPlayer.strikeDrop1 + vect(0, 500, 0)

rule "[Torbjorn] Meteor Strike Dropped":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.strikeCount == 1
    
    createEffect(getPlayers(eventPlayer.getTeam()) if eventPlayer.strikeDrop1 != null else null, Effect.RING, Color.AQUA, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[0] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())) if eventPlayer.strikeDrop1 != null else null, Effect.RING, Color.ORANGE, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[1] = getLastCreatedEntity()
    createEffect(getPlayers(eventPlayer.getTeam()) if eventPlayer.strikeDrop1 != null else null, Effect.LIGHT_SHAFT, Color.AQUA, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[2] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())) if eventPlayer.strikeDrop1 != null else null, Effect.LIGHT_SHAFT, Color.RED, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[3] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.strikeDrop1 != null else null, Effect.SPHERE, Color.GRAY, eventPlayer.strikeLaunch1, 6.6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[4] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.strikeDrop1 != null else null, Effect.SPHERE, Color.BLACK, eventPlayer.strikeLaunch1, 6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[5] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.strikeDrop1 != null else null, Effect.BAD_AURA, Color.YELLOW, eventPlayer.strikeLaunch1, 3.3, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[6] = getLastCreatedEntity()
    createEffect(getAllPlayers() if eventPlayer.strikeDrop1 != null else null, Effect.BAD_AURA, Color.ORANGE, eventPlayer.strikeLaunch1, 7.6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[7] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch1, eventPlayer.strikeDrop1, duration=4, ChaseReeval.NONE)
    while eventPlayer.strikeLaunch1 != eventPlayer.strikeDrop1:
        wait(0.072)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 180)
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 200)
    stopChasingVariable(eventPlayer.strikeLaunch1)
    destroyEffect(eventPlayer.strikeEffects_)
    wait(0.1)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer.strikeLaunch1, 48)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.ORANGE, eventPlayer.strikeLaunch1, 24)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch1, 12)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 200)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 200)
    playEffect(getAllPlayers(), DynamicEffect.LUCIO_SOUND_BARRIER_CAST_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 200)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 12, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 1000)

rule "[Torbjorn] Meteor Strike Lava Pit Dropped EFFECTS":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.strikeCount == 1
    @Condition eventPlayer.strikeLaunch1 == eventPlayer.strikeDrop1

    createEffect(getPlayers(eventPlayer.getTeam()) if eventPlayer.strikeDrop1 != null else null, Effect.CLOUD, Color.AQUA, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[2] = getLastCreatedEntity()
    createEffect(getPlayers(eventPlayer.getTeam()) if eventPlayer.strikeDrop1 != null else null, Effect.CLOUD, Color.BLUE, eventPlayer.strikeDrop1 - Vector.DOWN * 0.5, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[3] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())) if eventPlayer.strikeDrop1 != null else null, Effect.CLOUD, Color.ORANGE, eventPlayer.strikeDrop1, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[4] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())) if eventPlayer.strikeDrop1 != null else null, Effect.CLOUD, Color.RED, eventPlayer.strikeDrop1 - Vector.DOWN * 0.5, 12, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects__[5] = getLastCreatedEntity()
    wait(10)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.setUltCharge(0)
    destroyEffect(eventPlayer.strikeEffects_)
    destroyEffect(eventPlayer.strikeEffects__)
    eventPlayer.strikeEffects_ = null
    eventPlayer.strikeEffects__ = null
    eventPlayer.strikeDrop1 = null
    eventPlayer.strikeLaunch1 = null
    
rule "[Torbjorn] Lava Pit Damage":
    @Event eachPlayer
    @Condition any([player.strikeDrop1 == player.strikeLaunch1 and player.strikeDrop1 != null and player.isAlive() and player.usingUltimateREAL == true and eventPlayer.getPosition().y <= player.strikeLaunch1.y + 2 and eventPlayer.getPosition().y >= player.strikeLaunch1.y - 2 and distance(player.strikeLaunch1, eventPlayer) < 12 and player != eventPlayer for player in getPlayersOnHero(Hero.TORBJORN, getOppositeTeam(eventPlayer.getTeam()))])

    eventPlayer.setStatusEffect([player for player in getPlayersOnHero(Hero.TORBJORN, getOppositeTeam(eventPlayer.getTeam()))], Status.BURNING, 9999)
    eventPlayer.startDoT([player for player in getPlayersOnHero(Hero.TORBJORN, getOppositeTeam(eventPlayer.getTeam()))], 9999, 45)
    eventPlayer.lavaPitDoT = getLastDoT()
    waitUntil(any([player.isAlive() and player.usingUltimateREAL == true and distance(player.strikeLaunch1, eventPlayer) <= 12 and player != eventPlayer for player in getPlayersOnHero(Hero.TORBJORN, getOppositeTeam(eventPlayer.getTeam()))]) != true or eventPlayer.isDead(), 9999)
    stopDoT(eventPlayer.lavaPitDoT)
    eventPlayer.clearStatusEffect(Status.BURNING)

rule "[Torbjorn] Ultimate Loop":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventPlayer.strikeLaunch1 == eventPlayer.strikeDrop1
    @Condition eventPlayer.strikeDrop1 != null

    # sounds
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.strikeDrop1, 24)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer.strikeDrop1, 22)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.BLUE, eventPlayer.strikeDrop1, 24)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.AQUA, eventPlayer.strikeDrop1, 23)
    playEffect(getAllPlayers(), DynamicEffect.ASHE_DYNAMITE_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.strikeDrop1, 60)
    playEffect(getAllPlayers(), DynamicEffect.PHARAH_BARRAGE_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.strikeDrop1, 30)
    wait(0.512)
    if RULE_CONDITION:
        goto RULE_START
