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
    # face upwards
    eventPlayer.startFacing(Vector.UP, 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # create camera
    eventPlayer.camPos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 30, null, getAllPlayers(), true).getHitPosition()
    wait(0.5)
    # create eventPlayer effects
    playEffect(getAllPlayers(), DynamicEffect.WINSTON_JUMP_PACK_LANDING_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
    playEffect(getAllPlayers(), DynamicEffect.SYMMETRA_TELEPORTER_REAPPEAR_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 100)
    createEffect(eventPlayer, Effect.RING, Color.TURQUOISE, raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 100, null, getAllPlayers(), true).getHitPosition(), 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects = getLastCreatedEntity()
    createInWorldText(eventPlayer, "{0} Fire                                         {1} Zoom Out | Zoom In {2}".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), buttonString(Button.CROUCH)), updateEveryTick(eventPlayer.camPos + Vector.DOWN * 15), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    eventPlayer.strikeTexts = getLastCreatedText()
    # start camera
    eventPlayer.startCamera(eventPlayer.camPos, updateEveryTick(eventPlayer.camPos + Vector.DOWN * 1), 100)
    waitUntil(eventPlayer.strikeCount == 4 or eventPlayer.isDead(), 99999)
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
    eventPlayer.setUltCharge(0+ultBoost)

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

rule "[Pharah] Move Camera Down":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition() * vect(0,1,0) <= (eventPlayer.getPosition() * vect(0,1,0)) + vect(0,80,0)
    
    eventPlayer.camPos = raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.UP * 5, null, eventPlayer, true).getHitPosition()

rule "[Pharah] Move Camera Up":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition raycast(eventPlayer.camPos, eventPlayer.camPos + Vector.DOWN * 5, null, eventPlayer, true).getHitPosition() * vect(0,1,0) >= (eventPlayer.getPosition() * vect(0,1,0)) + vect(0,5,0)
    
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
    wait(0.85)
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
    wait(0.85)
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
    wait(0.85)
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
    wait(0.85)
    eventPlayer.strikeAvailable = true

rule "[Pharah] First Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 1
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop1, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[0] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    destroyEffect(eventPlayer.strikeEffects_[0])
    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), eventPlayer.strikeDrop1, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[1] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch1, eventPlayer.strikeDrop1, duration=3, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.strikeLaunch1 != eventPlayer.strikeDrop1:
        wait(0.072)
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
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch1, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)

rule "[Pharah] Second Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 2
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop2, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[2] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(0.75)
    destroyEffect(eventPlayer.strikeEffects_[2])
    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), eventPlayer.strikeDrop2, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[3] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch2, eventPlayer.strikeDrop2, duration=3, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.strikeLaunch2 != eventPlayer.strikeDrop2:
        wait(0.072)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 60)
    printLog("Second While Over")
    stopChasingVariable(eventPlayer.strikeLaunch2)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch2, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch2, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch2, 8)
    destroyEffect(eventPlayer.strikeEffects_[3])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch2, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)

rule "[Pharah] Third Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 3
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop3, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[4] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(1.5)
    destroyEffect(eventPlayer.strikeEffects_[4])
    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), eventPlayer.strikeDrop3, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[5] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch3, eventPlayer.strikeDrop3, duration=3, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.strikeLaunch3 != eventPlayer.strikeDrop3:
        wait(0.072)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 60)
    printLog("Third While Over")
    stopChasingVariable(eventPlayer.strikeLaunch3)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch3, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch3, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch3, 8)
    destroyEffect(eventPlayer.strikeEffects_[5])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch3, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)

rule "[Pharah] Fourth Artillery Shot Dropped":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.strikeCount == 4
    
    createEffect(eventPlayer, Effect.RING, Color.WHITE, eventPlayer.strikeDrop4, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[6] = getLastCreatedEntity()
    waitUntil(eventPlayer.strikeCount == 4, 9999)
    wait(2.25)
    destroyEffect(eventPlayer.strikeEffects_[6])
    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), eventPlayer.strikeDrop4, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.strikeEffects_[7] = getLastCreatedEntity()
    chase(eventPlayer.strikeLaunch4, eventPlayer.strikeDrop4, duration=3, ChaseReeval.DESTINATION_AND_DURATION)
    while eventPlayer.strikeLaunch4 != eventPlayer.strikeDrop4:
        wait(0.072)
        playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 2)
        playEffect(getAllPlayers(), DynamicEffect.BASTION_TANK_CANNON_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 60)
    printLog("Fourth While Over")
    stopChasingVariable(eventPlayer.strikeLaunch4)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 20)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.strikeLaunch4, 8)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer.strikeLaunch4, 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.strikeLaunch4, 8)
    destroyEffect(eventPlayer.strikeEffects_[7])
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 2, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 4, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.strikeLaunch4, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), eventPlayer, 150)
    
