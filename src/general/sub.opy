#!mainFile "../main.opy"

def Cleanup():
    @Name "SUB Full Cleanup"
	# reset changeable variables
    eventPlayer.moveSpeed[true] = 100
    eventPlayer.moveSpeed[false] = 100
    eventPlayer.damageDealt[true] = 100
    eventPlayer.damageDealt[false] = 100
    eventPlayer.damageReceived[true] = 100
    eventPlayer.damageReceived[false] = 100
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
    eventPlayer.setHealingDealt(100)
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setKnockbackDealt(100)
    eventPlayer.setMaxHealth(100)
    eventPlayer.setUltCharge(0+ultBoost)
	eventPlayer.setProjectileSpeed(100)
    eventPlayer.setProjectileGravity(100)
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
    eventPlayer.stopAcceleration()
	# enable all abilities
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
	# reset variables
	eventPlayer.fluxCenter = null
	eventPlayer.bombCenterPoint = vect(false, false, false)
    eventPlayer.hero_ = eventPlayer.getCurrentHero()
    eventPlayer.overHealthPool = null
	eventPlayer.isStatused = []
	eventPlayer.statusName = []
	eventPlayer.statusIcon = []
	eventPlayer.statusTimer = []
	eventPlayer.statusColor = []

def animationCleanup():
    @Name "SUB Bastion Animation Cleanup"

    # cleanup all bastion effects and changes from his ultimate
    destroyEffect(eventPlayer.missileEffect)
    eventPlayer.missileEffect = []
    eventPlayer.moveSpeed /= 1.75
    kill(eventPlayer, eventPlayer)
    wait(1)
    eventPlayer.stopCamera()
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)

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
    if eventPlayer.superchargerSize >= 30:
        async(superChargerPulsingEffect(), AsyncBehavior.RESTART)

def statusTimerBaptisteAmplified():
    @Name "[STATUS] Baptiste Amplified"

    for eventPlayer.statusLoop in range(100):
        eventPlayer.statusTimer[eventPlayer.statusName.index("AMPLIFIED")] -= 0.1
        wait(0.1)