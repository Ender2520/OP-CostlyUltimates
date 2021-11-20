#!mainFile "../main.opy"

def HeroCleanup(): # EVERY SPAWN PER HERO
    @Name "SUB Hero Cleanup"
    if eventPlayer.hero_ == Hero.MCCREE:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
        eventPlayer.cassidyShieldBot = null
    elif eventPlayer.hero_ == Hero.MERCY:
        stopChasingVariable(eventPlayer.goldenGunCooldown)

def SwapCleanup(): # SWAPPING OFF A HERO
    @Name "SUB Swap Cleanup"
    if eventPlayer.hero_ == Hero.BAPTISTE:
        destroyEffect(eventPlayer.matrixEffect)
        wait()
        eventPlayer.matrixEffect = null
        eventPlayer.matrixSize = null
    elif eventPlayer.hero_ == Hero.BASTION:
        destroyEffect(eventPlayer.missileAOEVisual)
        destroyEffect(eventPlayer.missileEffect)
        removeHealthPool(eventPlayer.armorPool)
        wait()
        eventPlayer.missileAOEVisual = null
        eventPlayer.missileEffect = null
        eventPlayer.missileTimer = null
        eventPlayer.armorPool = null
    elif eventPlayer.hero_ == Hero.BRIGITTE:
        getPlayers(eventPlayer.getTeam()).brigSpeedBoost = false
    elif eventPlayer.hero_ == Hero.MCCREE:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
        wait()
        eventPlayer.cassidyShieldBot = null
    elif eventPlayer.hero_ == Hero.DOOMFIST:
        destroyProgressBarHud(eventPlayer.ultimateBar)
        destroyEffect(eventPlayer.overdriveEffects)
        wait()
        eventPlayer.damageIncrease = null
        eventPlayer.ultimateBar = null
        eventPlayer.overdriveEffects = null
    elif eventPlayer.hero_ == Hero.ECHO:
        destroyEffect(eventPlayer.counterpoiseEffects)
        wait()
        eventPlayer.counterpoiseEffects = null
        eventPlayer.counterpoiseSize = null
    elif eventPlayer.hero_ == Hero.HANZO:
        eventPlayer.dragonStrikeCharges = null
    elif eventPlayer.hero_ == Hero.MERCY:
        stopChasingVariable(eventPlayer.goldenGunCooldown)
        destroyHudText(eventPlayer.goldenGunHUD)
        wait()
        eventPlayer.goldenGunReloaded = null
        eventPlayer.goldenGunHUD = null
        eventPlayer.goldenGunCooldown = null
    elif eventPlayer.hero_ == Hero.PHARAH:
        destroyInWorldText(eventPlayer.strikeTexts)
        destroyProgressBarInWorldText(eventPlayer.strikeTexts_)
        wait()
        eventPlayer.camPos = null
        eventPlayer.strikeAvailable = null
        eventPlayer.strikeLaunch1 = null
        eventPlayer.strikeLaunch2 = null
        eventPlayer.strikeLaunch3 = null
        eventPlayer.strikeLaunch4 = null
        eventPlayer.strikeDrop1 = null
        eventPlayer.strikeDrop2 = null
        eventPlayer.strikeDrop3 = null
        eventPlayer.strikeDrop4 = null
    elif eventPlayer.hero_ == Hero.TORBJORN:
        destroyInWorldText(eventPlayer.strikeTexts)
        destroyProgressBarInWorldText(eventPlayer.strikeTexts_)
        wait()
        eventPlayer.camPos = null
        eventPlayer.strikeAvailable = null
        eventPlayer.strikeLaunch1 = null
        eventPlayer.strikeDrop1 = null
    elif eventPlayer.hero_ == Hero.SIGMA:
        destroyEffect(eventPlayer.fluxExtraRangeEffect)
        wait()
        eventPlayer.fluxCenter = null
        eventPlayer.fluxExtraRangeEffect = null
    elif eventPlayer.hero_ == Hero.SOLDIER:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[0].getSlot())
        destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[1].getSlot())
        eventPlayer.helixBot = null
        wait()
        eventPlayer.fluxCenter = null
        eventPlayer.fluxExtraRangeEffect = null
    elif eventPlayer.hero_ == Hero.SOMBRA:
        destroyEffect(eventPlayer.empEffect)
        destroyEffect(eventPlayer.victimEffects)
        wait()
        eventPlayer.empRadius = null
        eventPlayer.empEffect = null
        eventPlayer.victimEffects = null
    elif eventPlayer.hero_ == Hero.SYMMETRA:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.turretEntity.getSlot())
        destroyProgressBarInWorldText(eventPlayer.turretTexts)
        stopChasingVariable(eventPlayer.turretTimer)
        wait()
        eventPlayer.turretEffects = null
        eventPlayer.turretEntity = null
        eventPlayer.turretPos = null
        eventPlayer.turretTarget = null
        eventPlayer.turretTexts = null
        eventPlayer.turretTimer = null
    elif eventPlayer.hero_ == Hero.TRACER:
        destroyEffect(eventPlayer.manipulateEffects)
        destroyProgressBarHud(eventPlayer.manipulateTexts)
        wait()
        eventPlayer.manipulateDuration = null
        eventPlayer.manipulateEffects = null
        eventPlayer.manipulateTexts = null
    elif eventPlayer.hero_ == Hero.WIDOWMAKER:
        destroyEffect(eventPlayer.chamberEffects)
        destroyProgressBarHud(eventPlayer.chamberText)
        wait()
        eventPlayer.chamberCast_Start = null
        eventPlayer.chamberCast_Direction = null
        eventPlayer.chamberCast_DistRemaining = null
        eventPlayer.chamberCharge = null

def RespawnCleanup(): # EVERY SPAWN GLOBAL
    @Name "SUB Respawn Cleanup"
    # reset changeable variables
    eventPlayer.moveSpeed[false] = 100
    eventPlayer.damageDealt[false] = 100
    eventPlayer.damageReceived[false] = 100
    eventPlayer.healingDealt[false] = 100
    # stop player changes
    eventPlayer.stopAllDoT()
    eventPlayer.stopAllHoT()
    # remove health pools
    removeHealthPool(eventPlayer.overHealthPool)
    # reset variables
    eventPlayer.overHealthPool = null
	eventPlayer.isStatused[0] = false
    eventPlayer.isStatused[1] = false
    eventPlayer.isStatused[2] = false
    eventPlayer.isStatused[3] = false
    eventPlayer.isStatused[4] = false
    eventPlayer.isStatused[5] = false
 
def FullCleanup(): # FIRST SPAWN
    @Name "SUB Full Cleanup"
	# reset changeable variables
    eventPlayer.moveSpeed[false] = 100
    eventPlayer.damageDealt[false] = 100
    eventPlayer.damageReceived[false] = 100
    eventPlayer.healingDealt[false] = 100
	# stop chasing variables
    stopChasingVariable(eventPlayer.goldenGunCooldown)
	# remove health pools
    removeHealthPool(eventPlayer.overHealthPool)
	# allow buttons
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.INTERACT)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ULTIMATE)
	# reset base stats
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setKnockbackDealt(100)
    eventPlayer.setMaxHealth(100)
    eventPlayer.setGravity(100)
	# clear effects
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
	# stop player changes
    eventPlayer.stopForcingPosition()
    eventPlayer.detach()
    eventPlayer.stopScalingSize()
    eventPlayer.stopScalingBarriers()
    eventPlayer.stopAllDoT()
    eventPlayer.stopAllHoT()
	# enable all abilities
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
	# reset variables
	eventPlayer.isStatused[0] = false
    eventPlayer.isStatused[1] = false
    eventPlayer.isStatused[2] = false
    eventPlayer.isStatused[3] = false
    eventPlayer.isStatused[4] = false
    eventPlayer.isStatused[5] = false

def animationCleanup():
    @Name "SUB Bastion Animation Cleanup"

    # cleanup all bastion effects and changes from his ultimate
    destroyEffect(eventPlayer.missileEffect)
    eventPlayer.moveSpeed /= 1.75
    eventPlayer.setMaxHealth(100)
    kill(eventPlayer, eventPlayer)
    wait(1)
    removeHealthPool(eventPlayer.armorPool)
    eventPlayer.stopCamera()
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.armorPool = null
    eventPlayer.missileEffect = null

def normalTracking():
    @Name "SUB Dva normalTracking"
    
    eventPlayer.damageDealt /= 1000000
    for eventPlayer.bombDuration in range(188):
        eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * bombRadius, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 0.5, eventPlayer, null, true).getHitPosition()
        eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
        eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        wait(false)
    eventPlayer.damageDealt *= 1000000
    wait(0.064)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 25, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 50)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)

def downwardsTracking():
    @Name "SUB Dva downwardsTracking"
    
    eventPlayer.damageDealt /= 1000000
    for eventPlayer.bombDuration in range(188):
        if eventPlayer.bombDuration > 160:
            eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * 2, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 2, eventPlayer, null, true).getHitPosition()
            eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
            eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        else:
            eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * 1, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getHitPosition()
            eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
            eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        wait(false)
    eventPlayer.damageDealt *= 1000000
    wait(0.064)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 25, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 50)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)

def superChargerPulsingEffect():
    @Name "[Orisa] SUB Supercharger Pulsing Effect"

    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayersInRadius(eventPlayer.superchargerPosition, 35, Team.ALL, LosCheck.OFF), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.GREEN, eventPlayer.superchargerPosition, 200) 
    wait(2.75, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.superchargerSize >= 32:
        async(superChargerPulsingEffect(), AsyncBehavior.RESTART)
