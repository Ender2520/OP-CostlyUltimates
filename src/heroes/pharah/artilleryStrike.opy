#!mainFile "../../main.opy"

# CREDITS TO LEMONAID
rule "[Pharah] Artillery Strike Activate":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    if eventPlayer.isInAir():
        smallMessage(eventPlayer, "Can't Use Ultimate Mid-Air!")
    elif isInLoS(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 8, BarrierLos.PASS_THROUGH_BARRIERS) != true:
        smallMessage(eventPlayer, "Not Enough Space Above You!")
    else:
        # initalize
        eventPlayer.usingUltimateREAL = true
        eventPlayer.strikeCount = 0
        eventPlayer.setKnockbackReceived(0)
        eventPlayer.strikeAvailable = true
        eventPlayer.setAmmo(0,4)
        eventPlayer.disallowButton(Button.JUMP)
        eventPlayer.disallowButton(Button.CROUCH)
        eventPlayer.disallowButton(Button.ABILITY_1)
        eventPlayer.disallowButton(Button.ABILITY_2)
        eventPlayer.disallowButton(Button.SECONDARY_FIRE)
        eventPlayer.disallowButton(Button.MELEE)
        eventPlayer.moveSpeed[false] /= 1000
        eventPlayer.strikeTimer = 1
        # face upwards
        eventPlayer.startFacing(Vector.UP, 200, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        # create camera
        eventPlayer.camPos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 30, null, getAllPlayers(), true).getHitPosition()
        wait(0.5)
        # create eventPlayer effects
        playEffect(getAllPlayers(), DynamicEffect.WINSTON_JUMP_PACK_LANDING_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
        createEffect(eventPlayer, Effect.RING, Color.TURQUOISE, raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 100, null, getAllPlayers(), true).getHitPosition(), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.strikeEffects = getLastCreatedEntity()
        createInWorldText(eventPlayer, "                                      {0} Fire                                                                      Zoom | Out [{1}] - In [{2}]".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), buttonString(Button.CROUCH)), updateEveryTick(eventPlayer.camPos + Vector.DOWN * 15), 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
        eventPlayer.strikeTexts = getLastCreatedText()
        createProgressBarInWorldText(eventPlayer, eventPlayer.strikeTimer * 100, "", updateEveryTick(eventPlayer.camPos + Vector.DOWN * 15), 0.5, Clip.NONE, Color.BLUE, Color.BLUE, ProgressWorldTextReeval.VISIBILITY_POSITION_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
        eventPlayer.strikeTexts_ = getLastCreatedText()
        # start camera
        eventPlayer.startCamera(eventPlayer.camPos, updateEveryTick(eventPlayer.camPos + Vector.DOWN * 1), 100)
        # start time
        chase(eventPlayer.strikeTimer, 0, duration=15, ChaseReeval.NONE)
        waitUntil(eventPlayer.strikeCount == 4 or eventPlayer.isDead() or eventPlayer.strikeTimer == 0, 99999)
        eventPlayer.setUltCharge(ultBoost)
        stopChasingVariable(eventPlayer.strikeTimer)
        # determine whether to use ultimate or not
        if (eventPlayer.strikeCount == 4): # successfully ulted
            # ultimate voiceline
            eventPlayer.allowButton(Button.ULTIMATE)
            wait()
            eventPlayer.forceButtonPress(Button.ULTIMATE)
            wait()
            eventPlayer.cancelPrimaryAction()
            eventPlayer.disallowButton(Button.ULTIMATE)
            eventPlayer.setUltCharge(0+ultBoost)
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
            wait(3)
            eventPlayer.usingUltimateREAL = false
        else: # player died mid-ultimate
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
        eventPlayer.strikeEffects = null
        eventPlayer.strikeTexts = null
        eventPlayer.strikeTexts_ = null
        eventPlayer.strikeCount = null
        eventPlayer.strikeTimer = null

rule "[Pharah] Horizontal Camera Movement":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isMoving() == true
    @Condition eventPlayer.usingUltimateREAL == true
    
    chase(eventPlayer.camPos, updateEveryTick(eventPlayer.camPos + eventPlayer.getThrottle() * 15), rate=16.5 if eventPlayer.isMoving() else false, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(eventPlayer.getThrottle() == vect(0, 0, 0), 99999)
    wait(0.25, Wait.RESTART_WHEN_TRUE)
    stopChasingVariable(eventPlayer.camPos)
    if RULE_CONDITION:
        goto RULE_START

rule "[Pharah] Move Camera Up":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition().y <= (eventPlayer.getPosition() + vect(0,50,0)).y
    
    eventPlayer.camPos = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition()

rule "[Pharah] Move Camera Down":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 5, null, eventPlayer, true).getHitPosition().y >= (eventPlayer.getPosition() + vect(0,5,0)).y

    eventPlayer.camPos = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 5, null, eventPlayer, true).getHitPosition()


rule "[Pharah] First Artillery Shot Fired":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.hasStatusEffect(Status.HACKED)) == false
    @Condition eventPlayer.strikeAvailable == true
    @Condition eventPlayer.strikeCount == 0
    
    eventPlayer.strikeAvailable = false
    eventPlayer.strikeCount += 1
    eventPlayer.strikeDrop1 = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 800, null, getAllPlayers(), true).getHitPosition()
    eventPlayer.strikeLaunch1 = eventPlayer.strikeDrop1 + vect(0, 200, 0)
    wait(0.8)
    eventPlayer.strikeAvailable = true


rule "[Pharah] Second Artillery Shot Fired":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.hasStatusEffect(Status.HACKED)) == false
    @Condition eventPlayer.strikeAvailable == true
    @Condition eventPlayer.strikeCount == 1
    
    eventPlayer.strikeAvailable = false
    eventPlayer.strikeCount += 1
    eventPlayer.strikeDrop2 = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 800, null, getAllPlayers(), true).getHitPosition()
    eventPlayer.strikeLaunch2 = eventPlayer.strikeDrop2 + vect(0, 200, 0)
    wait(0.8)
    eventPlayer.strikeAvailable = true


rule "[Pharah] Third Artillery Shot Fired":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.hasStatusEffect(Status.HACKED)) == false
    @Condition eventPlayer.strikeAvailable == true
    @Condition eventPlayer.strikeCount == 2
    
    eventPlayer.strikeAvailable = false
    eventPlayer.strikeCount += 1
    eventPlayer.strikeDrop3 = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 800, null, getAllPlayers(), true).getHitPosition()
    eventPlayer.strikeLaunch3 = eventPlayer.strikeDrop3 + vect(0, 200, 0)
    wait(0.8)
    eventPlayer.strikeAvailable = true

rule "[Pharah] Fourth Artillery Shot Fired":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition (eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.STUNNED) or eventPlayer.hasStatusEffect(Status.HACKED)) == false
    @Condition eventPlayer.strikeAvailable == true
    @Condition eventPlayer.strikeCount == 3
    
    eventPlayer.strikeAvailable = false
    eventPlayer.strikeCount += 1
    eventPlayer.strikeDrop4 = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 800, null, getAllPlayers(), true).getHitPosition()
    eventPlayer.strikeLaunch4 = eventPlayer.strikeDrop4 + vect(0, 200, 0)
    wait(0.8)
    eventPlayer.strikeAvailable = true

rule "[Pharah] First Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 1
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop1, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[0] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    destroyEffect(eventPlayer.strikeEffects_[0])
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.BLUE, eventPlayer.strikeDrop1, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[1] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.RING, Color.RED, eventPlayer.strikeDrop1, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[2] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch1, eventPlayer.strikeDrop1, duration=2.35, ChaseReeval.NONE)
    while eventPlayer.strikeLaunch1 != eventPlayer.strikeDrop1:
        wait(0.096)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 60)
    printLog("First While Over")
    stopChasingVariable(eventPlayer.strikeLaunch1)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch1, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch1, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch1, 8)
    destroyEffect(eventPlayer.strikeEffects_[1])
    destroyEffect(eventPlayer.strikeEffects_[2])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    eventPlayer.setUltCharge(ultBoost)

rule "[Pharah] Second Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 2
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop2, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[3] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(0.6)
    destroyEffect(eventPlayer.strikeEffects_[3])
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.BLUE, eventPlayer.strikeDrop2, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[4] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.RING, Color.RED, eventPlayer.strikeDrop2, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[5] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch2, eventPlayer.strikeDrop2, duration=2.35, ChaseReeval.NONE)
    while eventPlayer.strikeLaunch2 != eventPlayer.strikeDrop2:
        wait(0.096)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 60)
    printLog("Second While Over")
    stopChasingVariable(eventPlayer.strikeLaunch2)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch2, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch2, 8)
    destroyEffect(eventPlayer.strikeEffects_[4])
    destroyEffect(eventPlayer.strikeEffects_[5])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    eventPlayer.setUltCharge(ultBoost)

rule "[Pharah] Third Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 3
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop3, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[6] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(1.2)
    destroyEffect(eventPlayer.strikeEffects_[6])
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.BLUE, eventPlayer.strikeDrop3, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[7] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.RING, Color.RED, eventPlayer.strikeDrop3, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[8] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch3, eventPlayer.strikeDrop3, duration=2.35, ChaseReeval.NONE)
    while eventPlayer.strikeLaunch3 != eventPlayer.strikeDrop3:
        wait(0.096)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 60)
    printLog("Third While Over")
    stopChasingVariable(eventPlayer.strikeLaunch3)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch3, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch3, 8)
    destroyEffect(eventPlayer.strikeEffects_[7])
    destroyEffect(eventPlayer.strikeEffects_[8])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    eventPlayer.setUltCharge(ultBoost)

rule "[Pharah] Fourth Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 4
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop4, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[9] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(1.8)
    destroyEffect(eventPlayer.strikeEffects_[9])
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.BLUE, eventPlayer.strikeDrop4, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[10] = getLastCreatedEntity()
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.RING, Color.RED, eventPlayer.strikeDrop4, 8, EffectReeval.VISIBILITY)
    eventPlayer.strikeEffects_[11] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch4, eventPlayer.strikeDrop4, duration=2.35, ChaseReeval.NONE)
    while eventPlayer.strikeLaunch4 != eventPlayer.strikeDrop4:
        wait(0.096)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 60)
    printLog("Fourth While Over")
    stopChasingVariable(eventPlayer.strikeLaunch4)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch4, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch4, 8)
    destroyEffect(eventPlayer.strikeEffects_[10])
    destroyEffect(eventPlayer.strikeEffects_[11])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    eventPlayer.setUltCharge(ultBoost)
    
