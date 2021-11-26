#!mainFile "../main.opy"

def HeroCleanup(): # EVERY SPAWN PER HERO
    @Name "SUB Hero Cleanup"
    if eventPlayer.hero_ == Hero.MCCREE:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
        eventPlayer.cassidyShieldBot = null
    elif eventPlayer.hero_ == Hero.DVA:
        eventPlayer.bombCenterPoint = vect(false,false,false)
    elif eventPlayer.hero_ == Hero.MERCY:
        stopChasingVariable(eventPlayer.goldenGunCooldown)
    elif eventPlayer.hero_ == Hero.SYMMETRA:
        eventPlayer.turretTexts = null

def SwapCleanup(): # SWAPPING OFF A HERO
    @Name "SUB Swap Cleanup"
    if eventPlayer.hero_ == Hero.BAPTISTE:
        destroyEffect(eventPlayer.matrixEffect)
        wait()
        eventPlayer.matrixEffect = null
        eventPlayer.matrixSize = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.BASTION:
        destroyEffect(eventPlayer.missileAOEVisual)
        destroyEffect(eventPlayer.missileEffect)
        removeHealthPool(eventPlayer.armorPool)
        wait()
        eventPlayer.missileAOEVisual = null
        eventPlayer.missileEffect = null
        eventPlayer.missileTimer = null
        eventPlayer.armorPool = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.BRIGITTE:
        getPlayers(eventPlayer.getTeam()).brigSpeedBoost = false
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.MCCREE:
        destroyDummy(eventPlayer.getTeam(), eventPlayer.cassidyShieldBot.getSlot())
        wait()
        eventPlayer.cassidyShieldBot = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.DVA:
        eventPlayer.bombEffect = null
    elif eventPlayer.hero_ == Hero.DOOMFIST:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyProgressBarHud(eventPlayer.ultimateBar)
        destroyEffect(eventPlayer.overdriveEffects)
        wait()
        eventPlayer.damageIncrease = null
        eventPlayer.ultimateBar = null
        eventPlayer.overdriveEffects = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.ECHO:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyEffect(eventPlayer.counterpoiseEffects)
        wait()
        eventPlayer.counterpoiseEffects = null
        eventPlayer.counterpoiseSize = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.HANZO:
        eventPlayer.dragonStrikeCharges = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.MERCY:
        stopChasingVariable(eventPlayer.goldenGunCooldown)
        destroyHudText(eventPlayer.goldenGunHUD)
        wait()
        eventPlayer.goldenGunReloaded = null
        eventPlayer.goldenGunHUD = null
        eventPlayer.goldenGunCooldown = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.PHARAH:
        eventPlayer.allowButton(Button.ULTIMATE)
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
        eventPlayer.allowButton(Button.ULTIMATE)
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
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.SOLDIER:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[0].getSlot())
        destroyDummy(eventPlayer.getTeam(), eventPlayer.helixBot[1].getSlot())
        eventPlayer.helixBot = null
        wait()
        eventPlayer.fluxCenter = null
        eventPlayer.fluxExtraRangeEffect = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.SOMBRA:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyEffect(eventPlayer.empEffect)
        destroyEffect(eventPlayer.victimEffects)
        wait()
        eventPlayer.empRadius = null
        eventPlayer.empEffect = null
        eventPlayer.victimEffects = null
    elif eventPlayer.hero_ == Hero.SYMMETRA:
        eventPlayer.allowButton(Button.ULTIMATE)
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
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.TRACER:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyEffect(eventPlayer.manipulateEffects)
        destroyProgressBarHud(eventPlayer.manipulateTexts)
        wait()
        eventPlayer.manipulateDuration = null
        eventPlayer.manipulateEffects = null
        eventPlayer.manipulateTexts = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.WIDOWMAKER:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyEffect(eventPlayer.chamberEffects)
        destroyProgressBarHud(eventPlayer.chamberText)
        wait()
        eventPlayer.chamberCast_Start = null
        eventPlayer.chamberCast_Direction = null
        eventPlayer.chamberCast_DistRemaining = null
        eventPlayer.chamberCharge = null
        eventPlayer.usingUltimateREAL = false
    elif eventPlayer.hero_ == Hero.HAMMOND:
        eventPlayer.allowButton(Button.ULTIMATE)
        destroyEffect(eventPlayer.trappedEffects)
        destroyProgressBarHud(eventPlayer.trappedText)
    elif eventPlayer.hero_ == Hero.ZARYA:
        eventPlayer.allowButton(Button.ULTIMATE)
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
    eventPlayer.firstSpawn = 1
    # update huds
    eventPlayer.spawnedREAL = true
    wait()
    eventPlayer.spawnedREAL = false

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

def superChargerPulsingEffect():
    @Name "[Orisa] SUB Supercharger Pulsing Effect"

    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayersInRadius(eventPlayer.superchargerPosition, 35, Team.ALL, LosCheck.OFF), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.GREEN, eventPlayer.superchargerPosition, 200) 
    wait(2.75, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.superchargerSize >= 32:
        async(superChargerPulsingEffect(), AsyncBehavior.RESTART)
