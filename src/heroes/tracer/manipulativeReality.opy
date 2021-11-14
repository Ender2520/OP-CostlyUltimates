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
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.manipulateDuration = 1
    eventPlayer.setAmmo(0, 999)
    # create effects
    progressBarHud(eventPlayer, eventPlayer.manipulateDuration * 100, "{0} Reality Crashing {0}".format(iconString(Icon.WARNING)), HudPosition.TOP, 19, rgb(0,eventPlayer.manipulateDuration * 175 + 75,eventPlayer.manipulateDuration * 150 + 75), rgb(0,eventPlayer.manipulateDuration * 175 + 75,eventPlayer.manipulateDuration * 150 + 75), ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.manipulateTexts = getLastCreatedText()
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.TURQUOISE, eventPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, eventPlayer.getEyePosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.manipulateEffects.append(getLastCreatedEntity())
    # start timer
    chase(eventPlayer.manipulateDuration, 0, duration=10, ChaseReeval.NONE)
    waitUntil(eventPlayer.manipulateDuration == 0 or eventPlayer.isDead(), 9999)
    # remove effects
    destroyProgressBarHud(eventPlayer.manipulateTexts)
    destroyEffect(eventPlayer.manipulateEffects)
    # revert changes
    stopChasingVariable(eventPlayer.manipulateDuration)
    eventPlayer.usingUltimateREAL = false
    # leave tracer with no abilities or ammo
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 12)
    eventPlayer.setAmmo(0, 0)

rule "[Tracer] Cooldown Decrease DASH":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.usingUltimateREAL == true
    @Condition eventPlayer.getAbilityCharge(Button.ABILITY_1) < 420
    
    # remove cooldown
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 420)

rule "[Tracer] Ultimate Loop":
    @Event eachPlayer
    @Hero tracer
    @Condition eventPlayer.usingUltimateREAL == true

    # sounds
    wait() # prevent lag
    playEffect(getAllPlayers(), DynamicEffect.PHARAH_CONCUSSIVE_BLAST_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 60)
    playEffect(getAllPlayers(), DynamicEffect.ZARYA_PARTICLE_CANNON_EXPLOSION_SOUND, Color.TURQUOISE, eventPlayer.getPosition(), 90)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.TURQUOISE, eventPlayer.getPosition(), 1)
    wait(eventPlayer.manipulateDuration)
    if RULE_CONDITION:
        goto RULE_START
