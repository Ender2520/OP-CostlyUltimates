#!mainFile "../main.opy"

def SwapCleanup(): # SWAPPING OFF A HERO
    @Name "SUB Swap Cleanup"
    eventPlayer.usingUltimateREAL = false
    eventPlayer.removeAllHealthPools()
    eventPlayer.overHealthPool = null
    eventPlayer.allowButton(Button.ULTIMATE)
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
    elif eventPlayer.hero_ == Hero.DVA:
        eventPlayer.bombEffect = null
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
        destroyEffect(eventPlayer.strikeEffects)
        destroyEffect(eventPlayer.strikeEffects_)
        destroyEffect(eventPlayer.strikeEffects__)
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
        eventPlayer.strikeTexts = null
        eventPlayer.strikeTexts_ = null
        eventPlayer.strikeEffects = null
        eventPlayer.strikeEffects_ = null
        eventPlayer.strikeEffects__ = null
    elif eventPlayer.hero_ == Hero.TORBJORN:
        destroyInWorldText(eventPlayer.strikeTexts)
        destroyProgressBarInWorldText(eventPlayer.strikeTexts_)
        destroyEffect(eventPlayer.strikeEffects)
        destroyEffect(eventPlayer.strikeEffects_)
        destroyEffect(eventPlayer.strikeEffects__)
        wait()
        eventPlayer.camPos = null
        eventPlayer.strikeAvailable = null
        eventPlayer.strikeLaunch1 = null
        eventPlayer.strikeDrop1 = null
        eventPlayer.strikeTexts = null
        eventPlayer.strikeTexts_ = null
        eventPlayer.strikeEffects = null
        eventPlayer.strikeEffects_ = null
        eventPlayer.strikeEffects__ = null
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
        destroyEffect(eventPlayer.turretEffects)
        destroyDummy(eventPlayer.getTeam(), eventPlayer.turretEntity.getSlot())
        destroyProgressBarInWorldText(eventPlayer.turretTexts[0])
        destroyProgressBarInWorldText(eventPlayer.turretTexts[1])
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
        destroyEffect(eventPlayer.chamberEffects_)
        wait()
        eventPlayer.chamberCast_Start = null
        eventPlayer.chamberCast_Direction = null
        eventPlayer.chamberCast_DistRemaining = null
    elif eventPlayer.hero_ == Hero.HAMMOND:
        destroyEffect(eventPlayer.trappedEffects)
        destroyProgressBarHud(eventPlayer.trappedText)
    elif eventPlayer.hero_ == Hero.ZARYA:
        destroyEffect(eventPlayer.pitEffects)
        destroyEffect(eventPlayer.pitSinkEffect)
        destroyProgressBarHud(eventPlayer.pitTexts)
        wait()
        eventPlayer.pitPosition = null
    # update huds
    eventPlayer.spawnedREAL = true
    wait()
    eventPlayer.spawnedREAL = false

def RespawnCleanup(): # EVERY SPAWN GLOBAL
    @Name "SUB Respawn Cleanup"
    # reset changeable variables
    eventPlayer.moveSpeed[false] = 100
    eventPlayer.damageDealt[false] = 100
    eventPlayer.damageReceived[false] = 100
    eventPlayer.healingDealt[false] = 100
    wait()
    # stop player changes
    eventPlayer.stopAllDoT()
    eventPlayer.stopAllHoT()
    # remove health pools
    eventPlayer.removeAllHealthPools()
    wait()
    # reset variables
    eventPlayer.overHealthPool = null
	eventPlayer.isStatused[0] = false
    eventPlayer.isStatused[1] = false
    eventPlayer.isStatused[2] = false
    eventPlayer.isStatused[3] = false
    eventPlayer.isStatused[4] = false
    eventPlayer.isStatused[5] = false
    # 
    eventPlayer.setMaxHealth(100)
    wait()
    eventPlayer.setHealth(999999)
    # update huds
    eventPlayer.spawnedREAL = true
    wait()
    eventPlayer.spawnedREAL = false
 
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
    eventPlayer.removeAllHealthPools()
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
    eventPlayer.firstSpawn = true
    # update huds
    eventPlayer.spawnedREAL = true
    wait()
    eventPlayer.spawnedREAL = false

def superChargerPulsingEffect():
    @Name "[Orisa] SUB Supercharger Pulsing Effect"

    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayersInRadius(eventPlayer.superchargerPosition, 28, Team.ALL, LosCheck.OFF), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.GREEN, eventPlayer.superchargerPosition, 200) 
    wait(2.75, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.superchargerSize >= 28:
        async(superChargerPulsingEffect(), AsyncBehavior.RESTART)
