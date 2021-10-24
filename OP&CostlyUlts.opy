settings {
    "main": {
        "description": "All the ultimates are very OP but they are expensive. This is kind of a testing ground for my planned gamemode ReWatch, so please provide feedback in my discord.",
        "modeName": "Overwatch OP & Costly Ultimates"
    },
    "lobby": {
        "team1Slots": 5,
        "team2Slots": 5
    },
    "gamemodes": {
        "assault": {},
        "control": {},
        "escort": {},
        "hybrid": {},
        "general": {
            "gamemodeStartTrigger": "manual",
            "roleLimit": "2OfEachRolePerTeam"
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ultGen%": 90
            },
            "ashe": {
                "enableInfiniteUlt": true,
                "ultGen%": 70
            },
            "baptiste": {
                "ultGen%": 70
            },
            "bastion": {
                "ultGen%": 60,
                "ultDuration%": 50
            },
            "brigitte": {
                "ultGen%": 80
            },
            "dva": {
                "ultGen%": 75
            },
            "doomfist": {
                "ultGen%": 70
            },
            "echo": {
                "ultGen%": 50
            },
            "genji": {
                "ultGen%": 65
            },
            "hanzo": {
                "ultGen%": 50
            },
            "junkrat": {
                "ultGen%": 75
            },
            "lucio": {
                "ultGen%": 70
            },
            "mccree": {
                "ultGen%": 70
            },
            "mei": {
                "ultGen%": 80
            },
            "mercy": {
                "ultGen%": 70
            },
            "orisa": {
                "ultGen%": 70
            },
            "reaper": {
                "ultGen%": 80
            },
            "reinhardt": {
                "ultGen%": 85
            },
            "roadhog": {
                "ultGen%": 75
            },
            "sigma": {
                "ultGen%": 85
            },
            "soldier": {
                "ultGen%": 70
            },
            "enabledHeroes": [
                "ana",
                "ashe",
                "baptiste",
                "bastion",
                "brigitte",
                "dva",
                "doomfist",
                "echo",
                "genji",
                "hanzo",
                "junkrat",
                "lucio",
                "mccree",
                "mei",
                "mercy",
                "orisa",
                "reaper",
                "reinhardt",
                "roadhog",
                "sigma",
                "soldier",
                "sombra",
            ]
        }
    }
}

#!extension explosionSounds
#!extension buffStatusEffects
#!extension debuffStatusEffects
#!extension buffAndDebuffSounds

playervar hero_
playervar moveSpeed
playervar damageDealt
playervar damageReceived
playervar ultimateIcon
playervar ultimateIconColor
globalvar TESTBOT
globalvar ultBoost
playervar i
#
playervar stateSpeed
playervar usingUltimateREAL
playervar ultimateDuration
# baptiste
playervar matrixSize
playervar matrixVictims
playervar matrixEffect
# bastion
playervar missileTimer
playervar missileAOEVisual
playervar missileEffect
subroutine animationCleanup
# brigitte
playervar brigSpeedBoost
# dva
globalvar bombRadius
globalvar bombOutsideRange
playervar bombPointPos
playervar bombHitNormal
playervar bombCenterPoint
playervar bombEyePos
playervar bombDuration
playervar bombInitNormal
playervar dmgToggle
subroutine normalTracking
subroutine downwardsTracking
# doomfist
playervar damageIncrease
playervar ultimateBar
# hanzo
playervar dragonStrikeCharges
# mccree
playervar mccreeShieldBot
# mercy
playervar goldenGunReloaded
playervar goldenGunHUD
playervar goldenGunCooldown
# orisa
playervar superchargerSize
playervar superchargerEffect
playervar superchargerPosition
playervar orisaBuffs
playervar orisaDebuffs
subroutine superChargerPulsingEffect
# sigma
playervar fluxCenter
playervar fluxExtraRangeEffect
# sombra
playervar vulnerabledVictims
playervar empRadius
playervar empEffect
playervar victimEffects

def Cleanup():
    @Name "SUB Cleanup"
    eventPlayer.fluxCenter = null
    eventPlayer.moveSpeed[true] = 100
    eventPlayer.moveSpeed[false] = 100
    eventPlayer.damageDealt[true] = 100
    eventPlayer.damageDealt[false] = 100
    eventPlayer.damageReceived[true] = 100
    eventPlayer.damageReceived[false] = 100
    stopChasingVariable(eventPlayer.goldenGunCooldown)
    eventPlayer.bombCenterPoint = vect(false, false, false)
    eventPlayer.hero_ = eventPlayer.getCurrentHero()
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
    eventPlayer.setHealingDealt(100)
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setKnockbackDealt(100)
    eventPlayer.setMaxHealth(100)
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    eventPlayer.stopForcingPosition()
    eventPlayer.detach()
    eventPlayer.stopScalingSize()
    eventPlayer.stopScalingBarriers()
    eventPlayer.stopAllDoT()
    eventPlayer.stopAllHoT()
    eventPlayer.stopAcceleration()
    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setProjectileGravity(100)
    eventPlayer.setGravity(100)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)

rule "[Global] Global 1":
    ultBoost = createWorkshopSetting(int[0:100], "OPTIONS", "ULTIMATE BOOST (%)", 0, 100) / 2
    # create hud texts
    hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, -21, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Overwatch OP & Costly Ultimates vALPHA | ---", HudPosition.RIGHT, -20, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Original by u/Ender | Code: -----", HudPosition.RIGHT, -19, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, -18, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # testing hud texts
    hudHeader(getAllPlayers(), "Bot Ult Charge : {0}".format(TESTBOT.getUltCharge()), HudPosition.LEFT, 0, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Bot Distance : {0}".format(distance(localPlayer, TESTBOT)), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Player Is Using Ult : {0}".format(localPlayer.isUsingUltimate()), HudPosition.LEFT, 2, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Effects/Entities : {0}".format(getNumberOfEntityIds()), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Texts : {0}".format(getNumberOfTextIds()), HudPosition.LEFT, 4, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    # set global variables
    bombRadius = true
    bombOutsideRange = true

rule "[Global] Ultimate Indicator":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.ultimateIcon == null
    
    createIcon(getAllPlayers() if eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true else null, updateEveryTick(eventPlayer.getEyePosition() + vect(0,1,0)), Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY_POSITION_AND_COLOR, eventPlayer.ultimateIconColor, false)
    eventPlayer.ultimateIcon = (getLastCreatedText())

rule "[Global] Remove Indicators on Leave":
    @Event playerLeft

    destroyInWorldText(eventPlayer.ultimateIcon)

rule "[Global] Icon Change Colors":
    @Event eachPlayer
    @Condition eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true

    eventPlayer.ultimateIconColor = Color.RED
    wait(1)
    eventPlayer.ultimateIconColor = Color.WHITE
    wait(1)
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] Cleanup on Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isDummy() != true

    async(Cleanup, AsyncBehavior.RESTART)

rule "[Automation] Hero":
    @Event eachPlayer
    @Condition eventPlayer.hero_ != eventPlayer.getCurrentHero()
    
    async(Cleanup, AsyncBehavior.RESTART)

rule "[Automation] Move Speed":
    @Event eachPlayer
    @Condition eventPlayer.moveSpeed[true] != eventPlayer.moveSpeed[false]
    
    # update moveSpeed variable and move speed to that variable
    eventPlayer.moveSpeed[true] = eventPlayer.moveSpeed[false]
    eventPlayer.setMoveSpeed(eventPlayer.moveSpeed[true])

rule "[Automation] Damage Dealt":
    @Event eachPlayer
    @Condition eventPlayer.damageDealt[true] != eventPlayer.damageDealt[false]

    # update damageDealt variable and damage dealt to that variable
    eventPlayer.damageDealt[true] = eventPlayer.damageDealt[false]
    eventPlayer.setDamageDealt(eventPlayer.damageDealt[true])

rule "[Automation] Damage Received":
    @Event eachPlayer
    @Condition eventPlayer.damageReceived[true] != eventPlayer.damageReceived[false]

    # update damageDealt variable and damage dealt to that variable
    eventPlayer.damageReceived[true] = eventPlayer.damageReceived[false]
    eventPlayer.setDamageReceived(eventPlayer.damageReceived[true]) 

rule "[Debug] Create bots":
    @Event eachPlayer
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    wait(0.333, Wait.ABORT_WHEN_FALSE)
    createDummy(random.choice(getAllHeroes()), eventPlayer.getTeam(), -1, eventPlayer.getEyePosition(), vect(0,100,0))
    #createDummy(random.choice(getAllHeroes()), getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getEyePosition(), vect(0,100,0))
    createDummy(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getEyePosition(), vect(0,100,0))
    TESTBOT = getLastCreatedEntity()
    wait()
    TESTBOT.setUltCharge(100)
    wait()
    TESTBOT.forceButtonPress(Button.ULTIMATE)

rule "[Debug] Destroy bots":
    @Event eachPlayer
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    
    wait(0.333, Wait.ABORT_WHEN_FALSE)
    TESTBOT = null
    destroyAllDummies()

rule "[Debug] Free ultimate":
    @Event eachPlayer
    @Condition "{0}".format(eventPlayer) == "Ender"
    @Condition eventPlayer.isCommunicating(Comms.ULTIMATE_STATUS) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    
    eventPlayer.setUltCharge(100)

rule "[Ana] Invincible Nano-Boost":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ULTIMATE

    # give nano'd player invincibility
    healee.setStatusEffect(healee, Status.INVINCIBLE, 8)
    # sound queue
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, healee, 200)

rule "[Baptiste] Create Amplification Matrix":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100

    # cancel default ultimate
    eventPlayer.cancelPrimaryAction()
    eventPlayer.setUltCharge(0+ultBoost)
    wait()
    # initialize Amp. Matrix
    eventPlayer.matrixSize = 0
    createEffect(getAllPlayers(), Effect.SPHERE, Color.LIME_GREEN, eventPlayer.getPosition(), eventPlayer.matrixSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.LIME_GREEN, eventPlayer.getPosition(), 40)
    playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 200)
    eventPlayer.matrixEffect = getLastCreatedEntity()
    # expand Amp. Matrix
    chase(eventPlayer.matrixSize, 20, duration=0.8, ChaseReeval.DESTINATION_AND_DURATION)
    wait(1.3)
    # remove effects and reset variables
    stopChasingVariable(eventPlayer.matrixSize)
    eventPlayer.matrixSize = 0
    destroyEffect(eventPlayer.matrixEffect)

rule "[Baptiste] Detect Matrix Victims":
    @Event eachPlayer
    @Condition eventPlayer.matrixSize > 0

    # assign players withtin conditions to matrixVictims
    eventPlayer.matrixVictims = [p for p in getAllPlayers() if distance(eventPlayer, p) <= 20 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ALL_BARRIERS) and p.getTeam() == eventPlayer.getTeam() and p.isAlive()]
    # increase damage of those players
    eventPlayer.matrixVictims.damageDealt[false] *= 2.0
    wait(10)
    # reverse of above
    eventPlayer.matrixVictims.damageDealt[false] /= 2.0
    eventPlayer.matrixVictims = []

def animationCleanup():
    @Name "[Bastion] SUB Animation Cleanup"

    # cleanup all bastion effects and changes from his ultimate
    destroyEffect(eventPlayer.missileEffect)
    eventPlayer.missileEffect = []
    eventPlayer.moveSpeed /= 1.5
    kill(eventPlayer, eventPlayer)
    wait(1)
    eventPlayer.stopCamera()
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)

rule "[Bastion] Heat Seeking Missile":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BASTION
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.missileTimer = 1
    eventPlayer.missileAOEVisual = 0
    eventPlayer.startCamera(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0, 3, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -5, getAllPlayers(), eventPlayer, false).getHitPosition(), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, false).getHitPosition(), 20)
    wait(1.5)
    chase(eventPlayer.missileTimer, 0, duration=4, ChaseReeval.DESTINATION_AND_DURATION)
    chase(eventPlayer.missileAOEVisual, 5, duration=4, ChaseReeval.DESTINATION_AND_DURATION)
    eventPlayer.moveSpeed *= 1.5
    #
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.BAD_AURA, Color.AQUA, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.WINSTON_PRIMAL_RAGE, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.BAD_AURA, Color.RED, updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual / 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.WINSTON_PRIMAL_RAGE, getOppositeTeam(eventPlayer.getTeam()), updateEveryTick(eventPlayer.getEyePosition()), eventPlayer.missileAOEVisual, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.missileEffect.append(getLastCreatedEntity())
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(1, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    #
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait(0.10, Wait.ABORT_WHEN_FALSE)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED, eventPlayer.getPosition(), 200)
    wait()
    async(animationCleanup(), AsyncBehavior.RESTART)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.BAD_EXPLOSION, Color.AQUA, eventPlayer.getEyePosition(), 16)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getEyePosition(), 16)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 6 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == getOppositeTeam(eventPlayer.getTeam()) and p.isAlive()], eventPlayer, 1000)
    damage([p for p in getAllPlayers() if distance(p, eventPlayer.getEyePosition()) <= 6 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and p.getTeam() == eventPlayer.getTeam() and p.isAlive()], eventPlayer, 100)
    
rule "[Bastion] Destroy Effects on Death":
    @Event eachPlayer
    @Hero bastion
    @Condition not eventPlayer.isUsingUltimate()
    @Condition eventPlayer.missileTimer > 0

    async(animationCleanup(), AsyncBehavior.RESTART)

rule "[Brigitte] Self Speed Increase":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.moveSpeed[false] *= 1.154
    waitUntil(not eventPlayer.isUsingUltimate() or eventPlayer.isDead(), 99999)
    getPlayers(eventPlayer.getTeam()).brigSpeedBoost = false
    eventPlayer.moveSpeed[false] /= 1.154

rule "[Brigitte] Ally Speed Boost Assignment":
    @Event eachPlayer
    @Condition any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player != eventPlayer for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())])

    eventPlayer.brigSpeedBoost = true
    waitUntil(([player.isDead() or not player.isUsingUltimate() or distance(player, eventPlayer) >= 8.5 or not isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]), 8.5)
    wait(1, Wait.RESTART_WHEN_TRUE)
    eventPlayer.brigSpeedBoost = false

rule "[Brigitte] Ally Speed Boost":
    @Event eachPlayer
    @Condition eventPlayer.brigSpeedBoost == true

    eventPlayer.moveSpeed[false] *= 1.5
    waitUntil(eventPlayer.brigSpeedBoost != true, 999)
    eventPlayer.moveSpeed[false] /= 1.5
 
rule "[Brigitte] Rally Cooldown Decrease PRIMARY":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.PRIMARY_FIRE) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.PRIMARY_FIRE, 0.75 * eventPlayer.getAbilityCooldown(Button.PRIMARY_FIRE))

rule "[Brigitte] Rally Cooldown Decrease SECONDARY":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0.75 * eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE))

rule "[Brigitte] Rally Cooldown Decrease ABILITY1":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0.75 * eventPlayer.getAbilityCooldown(Button.ABILITY_1))

rule "[Brigitte] Rally Cooldown Decrease ABILITY2":
    @Event eachPlayer
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.1
    
    if any([player.isAlive() and player.isUsingUltimate() and distance(player, eventPlayer) < 8.5 and isInLoS(player, eventPlayer, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) for player in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam())]):
        #Lower the cooldown
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0.75 * eventPlayer.getAbilityCooldown(Button.ABILITY_2))

rule "[DVA] Follow Bomb":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.bombEyePos = eventPlayer.getEyePosition() + worldVector(Vector.BACKWARD, eventPlayer, Transform.ROTATION)
    eventPlayer.bombPointPos = raycast(eventPlayer.bombEyePos, eventPlayer.bombEyePos + worldVector(vect(0, 0, 3), eventPlayer, Transform.ROTATION), eventPlayer, null, true).getHitPosition()
    eventPlayer.bombHitNormal = raycast(eventPlayer.bombEyePos, eventPlayer.bombEyePos + worldVector(vect(0, 0, 3), eventPlayer, Transform.ROTATION), eventPlayer, null, true).getNormal()
    eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
    if eventPlayer.getFacingDirection().y < -0.2:
        eventPlayer.bombInitNormal = Vector.UP
        downwardsTracking()
    else:
        eventPlayer.bombInitNormal = eventPlayer.bombHitNormal * vect(1, 0, 1)
        normalTracking()
    wait(0.3)
    eventPlayer.allowButton(Button.ULTIMATE)

def normalTracking():
    @Name "[DVA] SUB normalTracking"
    
    eventPlayer.damageDealt /= 1000000
    for eventPlayer.bombDuration in range(188):
        eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * bombRadius, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 0.5, eventPlayer, null, true).getHitPosition()
        eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
        eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        wait(false)
    eventPlayer.damageDealt *= 1000000
    wait(0.064)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 50)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 18, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 11, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)

def downwardsTracking():
    @Name "[DVA] SUB downwardsTracking"
    
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
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 50)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 18, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 150)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 11, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)
    damage(getPlayersInRadius(eventPlayer.bombCenterPoint, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF), eventPlayer, 400)

rule "[Doomfist] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Doomfist] Detect Ultimate Use":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    # pre-ultimate
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setUltEnabled(false)
    eventPlayer.ultimateDuration = 15
    eventPlayer.damageIncrease = 1
    chase(eventPlayer.ultimateDuration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    # peri-ultimate
    progressBarHud(eventPlayer, updateEveryTick(100 * (eventPlayer.ultimateDuration / 15)), "{0} Meteor Strike | Damage Increase {1}%".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE), eventPlayer.damageIncrease * 100), HudPosition.TOP, -10, Color.RED, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.ALWAYS)
    eventPlayer.ultimateBar = getLastCreatedText()
    eventPlayer.usingUltimateREAL = true
    waitUntil(eventPlayer.ultimateDuration == 0, 99999)
    # post-ultimate
    if eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt /= 1.14285
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt /= 1.125
        eventPlayer.damageDealt /= 1.14285
        eventPlayer.damageDealt /= 1.16666
        eventPlayer.damageDealt /= 1.2
        eventPlayer.damageDealt /= 1.25
    wait()
    # post-ultimate 2
    destroyProgressBarHud(eventPlayer.ultimateBar)
    stopChasingVariable(eventPlayer.ultimateDuration)
    eventPlayer.setUltCharge(0+ultBoost)
    eventPlayer.setUltEnabled(true)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.ultimateBar = []
    eventPlayer.damageIncrease = 1

rule "[Doomfist] Cooldown Decrease SECONDARY":
    @Event eachPlayer
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 2)

rule "[Doomfist] Cooldown Decrease ABILITY1":
    @Event eachPlayer
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 2)

rule "[Doomfist] Cooldown Decrease ABILITY2":
    @Event eachPlayer
    # detect ability on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0.1
    @Condition eventPlayer.usingUltimateREAL == true
    
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 2)

rule "[Doomfist] On Elimination":
    @Event playerEarnedElimination
    @Hero doomfist
    @Condition eventPlayer.usingUltimateREAL == true

    # damage boost depending on current damage boost
    if eventPlayer.damageIncrease == 1:
        eventPlayer.damageDealt *= 1.25
        eventPlayer.damageIncrease = 1.25
    elif eventPlayer.damageIncrease == 1.25:
        eventPlayer.damageDealt *= 1.2
        eventPlayer.damageIncrease = 1.5
    elif eventPlayer.damageIncrease == 1.5:
        eventPlayer.damageDealt *= 1.16666
        eventPlayer.damageIncrease = 1.75
    elif eventPlayer.damageIncrease == 1.75:
        eventPlayer.damageDealt *= 1.14285
        eventPlayer.damageIncrease = 2.0
    elif eventPlayer.damageIncrease == 2:
        eventPlayer.damageDealt *= 1.125
        eventPlayer.damageIncrease = 2.25
    elif eventPlayer.damageIncrease == 2.25:
        eventPlayer.damageDealt *= 1.11111
        eventPlayer.damageIncrease = 2.5
    # reset cooldowns
    wait(0.128)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)

rule "[Echo] Disallow Ultimate Button":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Echo] Detect Ultimate Use":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0+ultBoost)
    wait(0.1)
    eventPlayer.usingUltimateREAL = false

rule "[Echo] Decrease Enemy Ultimate Charge":
    @Event eachPlayer
    @Condition any([player.isAlive() and player.usingUltimateREAL == true for player in getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()))])

    # decrease enemy ult charge by a certain percent of their current charge depending on there distance from echo.
    # graph demo here: https://www.desmos.com/calculator/wudcnjsrwc
    eventPlayer.setUltCharge(eventPlayer.getUltCharge() * (1-((1.5**(-0.05*(distance(eventPlayer, getPlayersOnHero(Hero.ECHO, getOppositeTeam(eventPlayer.getTeam()))))+11.35775))/100)))

rule "[Genji] Cooldown Decrease DASH":
    @Event eachPlayer
    # detect dash on cooldown
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0.1
    @Condition eventPlayer.isUsingUltimate()
    
    # remove cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)

rule "[Hanzo] Fire Several Dragonstrikes":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.isUsingUltimate() == true
    
    # set number of dragon strike -1
    eventPlayer.dragonStrikeCharges = 4
    # run loop 5 times
    while eventPlayer.dragonStrikeCharges > 0:
        waitUntil(not eventPlayer.isUsingUltimate(), 99999)
        eventPlayer.setUltCharge(100)
        wait()
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        eventPlayer.dragonStrikeCharges -= 1
    wait(1)

rule "[Junkrat] RIP-Tire Insta-Kill":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.ULTIMATE
    
    kill(victim, attacker)

rule "[Junkrat] Increase RIP-Tire Speed":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.isUsingUltimate()
    
    eventPlayer.moveSpeed[false] *= 1.25
    waitUntil(not eventPlayer.isUsingUltimate(), 12)
    eventPlayer.moveSpeed[false] /= 1.25

rule "[Lucio] Provide Health to Teammates from Beat":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.usingUltimateREAL != true
    
    # dont beat until on ground
    waitUntil(eventPlayer.isOnGround(), 99999)
    # prevent multiple overhealth assignments
    eventPlayer.usingUltimateREAL = true
    # assign players meeting conditions overhealth
    [p for p in getPlayers(eventPlayer.getTeam()) if isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and distance(eventPlayer, p) <= 30].addHealthPool(Health.NORMAL, 400, false, false)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.usingUltimateREAL = false

rule "[Mccree] Deadeye Changes":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    # initialize changes
    eventPlayer.moveSpeed[false] *= 3.33333
    createDummy(Hero.BRIGITTE, eventPlayer.getTeam(), -1, eventPlayer.getPosition(), directionTowards(eventPlayer, eventPlayer.getFacingDirection() * 50))
    eventPlayer.mccreeShieldBot = getLastCreatedEntity()
    wait()
    # modify dummy bot
    eventPlayer.mccreeShieldBot.startScalingBarriers(20, false)
    eventPlayer.mccreeShieldBot.startScalingSize(0.1, false)
    eventPlayer.mccreeShieldBot.startForcingName("Deadeye Shield")
    eventPlayer.mccreeShieldBot.attachTo(eventPlayer, vect(0,0.75,1.25))
    eventPlayer.mccreeShieldBot.startForcingPosition(updateEveryTick(worldVector(vect(0,0.75,1.25), eventPlayer, Transform.ROTATION_AND_TRANSLATION)), true)
    eventPlayer.mccreeShieldBot.startFacing(updateEveryTick(eventPlayer.getFacingDirection()), 99999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # shield bot hold up shield
    eventPlayer.mccreeShieldBot.startForcingButton(Button.SECONDARY_FIRE)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    # undo all changes
    destroyDummy(eventPlayer.getTeam(), eventPlayer.mccreeShieldBot.getSlot())
    eventPlayer.moveSpeed[false] /= 3.33333

rule "[Mei] Blizzard Instantly Freezes":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility == Button.ULTIMATE

    # set victim as frozen
    victim.setStatusEffect(attacker, Status.FROZEN, 9999)
    waitUntil(not attacker.isUsingUltimate(), 9999)
    wait(1)
    victim.clearStatusEffect(Status.FROZEN)

rule "[Mercy] Initialize":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.goldenGunReloaded = true
    chase(eventPlayer.goldenGunCooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)

rule "[Mercy] Golden Gun Fire Rate":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    waitUntil(eventPlayer.isFiringPrimaryFire(), 9999)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setWeapon(2)
    eventPlayer.goldenGunReloaded = false
    eventPlayer.goldenGunCooldown = 2
    waitUntil(eventPlayer.goldenGunCooldown == 0, 9999)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.goldenGunReloaded = true
    if RULE_CONDITION:
        goto RULE_START

rule "[Mercy] Golden Gun HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    hudSubtext(eventPlayer, "                                                                                                 {0} Golden Gun [{1}]".format(iconString(Icon.SKULL), (" FIRE " if eventPlayer.goldenGunReloaded == true else eventPlayer.goldenGunCooldown)), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.goldenGunHUD = getLastCreatedText()
    waitUntil(not eventPlayer.isUsingUltimate(), 9999)
    destroyHudText(eventPlayer.goldenGunHUD)
    eventPlayer.goldenGunHUD = null

rule "[Mercy] Golden Gun Insta-Kill":
    @Event playerDealtDamage
    @Hero mercy
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition attacker.isUsingUltimate()

    kill(victim, attacker)

/*
rule "[Moira]":
*/

def superChargerPulsingEffect():
    @Name "[Orisa] SUB Supercharger Pulsing Effect"

    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize * 2)
    playEffect(getPlayersInRadius(eventPlayer.superchargerPosition, 35, Team.ALL, LosCheck.OFF), DynamicEffect.ORISA_HALT_IMPLOSION_SOUND, Color.GREEN, eventPlayer.superchargerPosition, 200) 
    wait(2.75, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.superchargerSize >= 35:
        async(superChargerPulsingEffect(), AsyncBehavior.RESTART)

# Supercharger creates a large zone (35-45m), that weakens enemies and buffs teammates inside it.
# WEAKNESS: +20% damage received, -20% damage dealt
# BUFF: +20% damage dealt, -20% damage received
rule "[Orisa] Create Large Zone":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate()

    # wait until supercharger is placed / intitialize
    wait(0.4)
    # initialize supercharger
    eventPlayer.superchargerPosition = eventPlayer.getPosition()
    eventPlayer.superchargerSize = 0
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.superchargerEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.superchargerEffect.append(getLastCreatedEntity())
    async(superChargerPulsingEffect(), AsyncBehavior.RESTART)
    # expand supercharger radius
    chase(eventPlayer.superchargerSize, 35, duration=0.8, ChaseReeval.DESTINATION_AND_DURATION)
    waitUntil(not eventPlayer.isUsingUltimate(), 9999)
    # reverse expansion
    chase(eventPlayer.superchargerSize, 0, duration=0.8, ChaseReeval.DESTINATION_AND_DURATION)
    wait(0.8)
    # remove effects and reset variables
    stopChasingVariable(eventPlayer.superchargerSize)
    destroyEffect(eventPlayer.superchargerEffect)
    eventPlayer.superchargerSize = 0

rule "[Orisa] Buff Teammates in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())])
    
    # assign values to players who meet the conditions
    eventPlayer.orisaBuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.orisaBuffs = false

rule "[Orisa] Debuff Enemies in Zone":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() and distance(player.superchargerPosition, eventPlayer) < player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))])
    
    # assign values to players who meet the conditions
    eventPlayer.orisaDebuffs = true
    waitUntil(([not player.isUsingUltimate() or distance(player.superchargerPosition, eventPlayer) > player.superchargerSize for player in getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))]), 15)
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.orisaDebuffs = false

rule "[Orisa] Apply Buffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaBuffs == true

    # apply buffs
    eventPlayer.damageDealt[false] *= 1.25
    eventPlayer.damageReceived[false] *= 0.75
    waitUntil(eventPlayer.orisaBuffs != true, 999)
    eventPlayer.damageDealt[false] /= 1.25
    eventPlayer.damageReceived[false] /= 0.75

rule "[Orisa] Apply Debuffs":
    @Event eachPlayer
    @Condition eventPlayer.orisaDebuffs == true

    # apply debuffs
    eventPlayer.damageDealt[false] *= 0.75
    eventPlayer.damageReceived[false] *= 1.25
    waitUntil(eventPlayer.orisaDebuffs != true, 999)
    eventPlayer.damageDealt[false] /= 0.75
    eventPlayer.damageReceived[false] /= 1.25

/*
rule "[Pharah]":
*/

rule "[Reaper] Teleport in Death Blossom":
    @Event playerEarnedElimination
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate()

    # check if there is at least 1 player in LOS (so reaper doesn't tp to 0,0,0)
    if len([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) and player.isAlive()]) > 0:
        # teleport to the closest player to reaper thats within LOS
        eventPlayer.teleport(sorted([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS) and player.isAlive()], lambda i: distance(eventPlayer, i)))

rule "[Reinhardt] 12s Ultimate Duration":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 12)

rule "[Roadhog] Whole Hog Changes": 
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    # initialize changes
    eventPlayer.moveSpeed[false] *= 1.33333
    eventPlayer.setKnockbackDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate() or eventPlayer.isDead(), 99999)
    # undo all changes
    eventPlayer.setKnockbackDealt(100)
    eventPlayer.moveSpeed[false] /= 1.33333

rule "[Roadhog] Reverse Whole Hog KB":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventAbility == Button.ULTIMATE

    # KB towards Roadhog
    victim.applyImpulse(eventDirection * -1, 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)

rule "[Sigma] Set Flux Center":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingUltimate()

    wait(0.6)
    createEffect(eventPlayer, Effect.RING, Color.BLUE, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 35, null, getAllPlayers(), false).getHitPosition()), 12, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.fluxExtraRangeEffect = getLastCreatedEntity()
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or not eventPlayer.isUsingUltimate(), 9999)
    destroyEffect(eventPlayer.fluxExtraRangeEffect)
    if eventPlayer.isUsingUltimate():
        eventPlayer.fluxCenter = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 35, null, getAllPlayers(), false).getHitPosition()
        waitUntil(not eventPlayer.isUsingUltimate() or eventPlayer.isDead(), 9999)
        eventPlayer.fluxCenter = null

rule "[Sigma] Pull Enemies Towards Gravitic Flux":
    @Event eachPlayer
    @Condition any([player.isUsingUltimate() for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))])

    waitUntil([player.fluxCenter != null for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))], 9999)
    wait(0.5)
    if any([distance(eventPlayer, player.fluxCenter) <= 12 for player in getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam()))]) == true:
        eventPlayer.applyImpulse(directionTowards(eventPlayer, getPlayersOnHero(Hero.SIGMA, getOppositeTeam(eventPlayer.getTeam())).fluxCenter  + vect(0, 1, 0)), 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)

rule "[Soldier 76] Initialize":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Soldier 76] Spam Helix Rockets":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    eventPlayer.setUltCharge(0)
    eventPlayer.usingUltimateREAL = true
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setAmmo(0, 30)
    for eventPlayer.i in range(12):
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        wait(0.5)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
        eventPlayer.setAmmo(0, eventPlayer.getAmmo(0) - 2.5)
    eventPlayer.usingUltimateREAL = false
    eventPlayer.setUltCharge(0)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)

rule "[Sombra] Initialize":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.hasSpawned()

    wait(0.128)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Sombra] Apply vulnerabled effect":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true
    @Condition eventPlayer.usingUltimateREAL != true

    # initialize emp
    eventPlayer.usingUltimateREAL = true
    eventPlayer.setUltCharge(0)
    eventPlayer.empRadius = 0
    eventPlayer.i = 0
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.PURPLE, eventPlayer, eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.RED, eventPlayer, eventPlayer.empRadius, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.empEffect.append(getLastCreatedEntity())
    # make that little floating effect when using default EMP
    eventPlayer.applyImpulse(Vector.UP, 1, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setGravity(5)
    # sound/visual queue
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATING_MATERIAL, Color.WHITE, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_LOGO_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    wait(0.35)
    # expand sphere
    chase(eventPlayer.empRadius, 15, duration=0.25, ChaseReeval.NONE)
    eventPlayer.vulnerabledVictims = getPlayersInRadius(eventPlayer, 15, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES)
    wait(0.25)
    # revert floating effect
    eventPlayer.setGravity(100)
    # give vulnerability and player-specific queues to victims
    playEffect(eventPlayer.vulnerabledVictims, DynamicEffect.ANA_BIOTIC_GRENADE_EXPLOSION_SOUND, Color.WHITE, eventPlayer.vulnerabledVictims.getPosition(), 200)
    for eventPlayer.i in range(len(eventPlayer.vulnerabledVictims) - 1):
        createEffect(getAllPlayers(), Effect.SOMBRA_HACKED_LOOPING, eventPlayer.getTeam(), eventPlayer.vulnerabledVictims[eventPlayer.i].getPosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.victimEffects.append(getLastCreatedEntity())
        createEffect(getAllPlayers(), Effect.SOMBRA_HACKED_SOUND, eventPlayer.getTeam(), eventPlayer.vulnerabledVictims[eventPlayer.i].getPosition(), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.victimEffects.append(getLastCreatedEntity())
        eventPlayer.i += 1
    eventPlayer.vulnerabledVictims.damageReceived *= 2.0
    # destroy effect
    destroyEffect(eventPlayer.empEffect)
    eventPlayer.empEffect = null
    wait(5)
    # revert changes
    destroyEffect(eventPlayer.victimEffects)
    eventPlayer.victimEffects = null
    eventPlayer.vulnerabledVictims.damageReceived /= 2.0
    eventPlayer.vulnerabledVictims = null
    eventPlayer.usingUltimateREAL = false
    eventPlayer.i = 0
