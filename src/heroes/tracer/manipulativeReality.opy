#!mainFile "../../main.opy"

rule "[Tracer] Manipulative Reality Activate":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    # initialize
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(ultBoost)
    eventPlayer.manipulateDuration = 1
    eventPlayer.setMaxAmmo(0, 999)
    eventPlayer.setAmmo(0, 999)
    # create effects
    wait()
    progressBarHud(eventPlayer, eventPlayer.manipulateDuration * 100, "{0} Reality Crashing {0}".format(iconString(Icon.WARNING)), HudPosition.TOP, 19, Color.TURQUOISE, Color.TURQUOISE, ProgressHudReeval.VISIBILITY_AND_VALUES, SpecVisibility.DEFAULT)
    eventPlayer.manipulateTexts = getLastCreatedText()
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.TURQUOISE, eventPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, eventPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    # start timer
    chase(eventPlayer.manipulateDuration, 0, duration=12, ChaseReeval.NONE)
    waitUntil(eventPlayer.manipulateDuration == 0 or eventPlayer.isDead(), 9999)
    # explosion
    playEffect(getAllPlayers(), DynamicEffect.WRECKING_BALL_MINEFIELD_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 100)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.AQUA, eventPlayer.getPosition(), 3)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 3)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 3 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == getOppositeTeam(eventPlayer.getTeam()) and p.isAlive()], eventPlayer, 200)
    # remove effects
    destroyProgressBarHud(eventPlayer.manipulateTexts)
    destroyEffect(eventPlayer.manipulateEffects)
    # revert changes
    stopChasingVariable(eventPlayer.manipulateDuration)
    eventPlayer.usingUltimateREAL = false
    # leave tracer with little abilities or ammo
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 6)
    eventPlayer.setMaxAmmo(0, 40)
    eventPlayer.setAmmo(0, 0)

rule "[Tracer] Cooldown Decrease DASH":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.usingUltimateREAL == true
    
    # remove cooldown
    while eventPlayer.getAbilityCharge(Button.ABILITY_1) < 420 or eventPlayer.getAmmo(0) <= 499:
        wait(0.512)
        eventPlayer.setAbilityCharge(Button.ABILITY_1, 420)
        eventPlayer.setAmmo(0, 999)

rule "[Tracer] Ultimate Loop":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.usingUltimateREAL == true

    # sounds
    wait() # prevent lag
    playEffect(getAllPlayers(), DynamicEffect.PHARAH_CONCUSSIVE_BLAST_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 60)
    playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 90)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TURQUOISE, eventPlayer.getPosition(), 1)
    wait(eventPlayer.manipulateDuration + 0.072)
    if RULE_CONDITION:
        goto RULE_START
