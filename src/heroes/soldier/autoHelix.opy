#!mainFile "../../main.opy"

rule "[Soldier 76] Spam Helix Rockets":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.usingUltimateREAL != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    eventPlayer.setUltCharge(0)
    eventPlayer.usingUltimateREAL = true
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setAmmo(0, 30)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
    # create bot
    wait()
    createDummy(Hero.SOLDIER, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 50, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), true).getHitPosition())
    eventPlayer.helixBot[0] = getLastCreatedEntity()
    createDummy(Hero.SOLDIER, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 50, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), true).getHitPosition())
    eventPlayer.helixBot[1] = getLastCreatedEntity()
    # modify bot
    # stats / initialize
    wait()
    eventPlayer.helixBot[0].setDamageDealt(50)
    eventPlayer.helixBot[1].setDamageDealt(50)
    eventPlayer.helixBot[0].setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.helixBot[1].setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.helixBot[0].disableEnvironmentCollision(true)
    eventPlayer.helixBot[1].disableEnvironmentCollision(true)
    eventPlayer.helixBot[0].setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.helixBot[1].setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.helixBot[0].parent = eventPlayer
    eventPlayer.helixBot[1].parent = eventPlayer
    # bot visuals and mech
    wait()
    eventPlayer.helixBot[0].setInvisibility(Invis.ALL)
    eventPlayer.helixBot[1].setInvisibility(Invis.ALL)
    eventPlayer.helixBot[0].startForcingName("Helix Bot 1.0")
    eventPlayer.helixBot[1].startForcingName("Helix Bot 2.0")
    eventPlayer.helixBot[0].attachTo(eventPlayer, vect(0.5,0.4,0.5))
    eventPlayer.helixBot[1].attachTo(eventPlayer, vect(-0.5,0.4,0.5))
    eventPlayer.helixBot[0].startForcingPosition(updateEveryTick(worldVector(vect(1,1,0), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
    eventPlayer.helixBot[1].startForcingPosition(updateEveryTick(worldVector(vect(-1,1,0), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
    eventPlayer.helixBot[0].startFacing(directionTowards(eventPlayer.helixBot[0].getEyePosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), true).getHitPosition()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.helixBot[1].startFacing(directionTowards(eventPlayer.helixBot[1].getEyePosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getPlayers(getOppositeTeam(eventPlayer.getTeam())), getPlayers(eventPlayer.getTeam()), true).getHitPosition()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # create effects
    wait()
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, updateEveryTick(worldVector(vect(0.25,1.55,0), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), 0.20, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.autoHelixEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, updateEveryTick(worldVector(vect(-0.25,1.55,0), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), 0.20, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.autoHelixEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.GOOD_AURA, eventPlayer.getTeam(), eventPlayer, 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.autoHelixEffects.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, getOppositeTeam(eventPlayer.getTeam()), eventPlayer, 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.autoHelixEffects.append(getLastCreatedEntity())
    createEffect(getAllPlayers(), Effect.GOOD_AURA_SOUND, eventPlayer.getTeam(), eventPlayer, 200, EffectReeval.VISIBILITY)
    eventPlayer.autoHelixEffects.append(getLastCreatedEntity())
    # play effects
    # activation visuals
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_PICKUP_EFFECT, eventPlayer.getTeam(), eventPlayer.getEyePosition(), 1)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_PICKUP_EFFECT, getOppositeTeam(eventPlayer.getTeam()), eventPlayer.getEyePosition(), 1)
    # activation audio
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 160)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_REAPPEAR_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 160)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer.getPosition(), 200)
    # automatic helix rockets
    wait()
    for eventPlayer.i in range(10):
        eventPlayer.helixBot[0].setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        wait(0.5)
        eventPlayer.helixBot[0].forceButtonPress(Button.SECONDARY_FIRE)
        #
        eventPlayer.helixBot[1].setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        wait(0.5)
        eventPlayer.helixBot[1].forceButtonPress(Button.SECONDARY_FIRE)
    # revert changes
    destroyEffect(eventPlayer.autoHelixEffects)
    eventPlayer.setUltCharge(0)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.autoHelixEffects = []
    destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[0].getSlot())
    destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[1].getSlot())

rule "[Soldier 76] Deal Helix Bot Damage":
    @Event playerDealtDamage
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.parent.helixBot[0] == eventPlayer or eventPlayer.parent.helixBot[1] == eventPlayer

    damage(victim, eventPlayer.parent, 20)
