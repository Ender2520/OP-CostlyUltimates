#!mainFile "../../main.opy"

rule "[Baptiste] Create Amplification Matrix":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isMeleeing() != true
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) != true or eventPlayer.hasStatusEffect(Status.FROZEN) != true or eventPlayer.hasStatusEffect(Status.HACKED) != true or eventPlayer.hasStatusEffect(Status.STUNNED) != true

    # cancel default ultimate
    eventPlayer.cancelPrimaryAction()
    eventPlayer.setUltCharge(ultBoost)
    wait()
    # initialize Amp. Matrix
    eventPlayer.usingUltimateREAL = true
    eventPlayer.matrixSize = 0
    createEffect(getAllPlayers(), Effect.SPHERE, Color.LIME_GREEN, evalOnce(eventPlayer.getPosition()), eventPlayer.matrixSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.LIME_GREEN, eventPlayer.getPosition(), 40)
    playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 180)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 120)
    eventPlayer.matrixEffect = getLastCreatedEntity()
    # expand Amp. Matrix
    chase(eventPlayer.matrixSize, 20 if eventPlayer.megaBoosted != true else 30, duration=0.5, ChaseReeval.NONE)
    wait(1)
    # remove effects and reset variables
    stopChasingVariable(eventPlayer.matrixSize)
    eventPlayer.matrixSize = 0
    destroyEffect(eventPlayer.matrixEffect)
    wait(9, Wait.IGNORE_CONDITION)
    # stop ultimate
    eventPlayer.usingUltimateREAL = false


rule "[Baptiste] Detect Matrix Victims":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.matrixSize > 0

    # assign players withtin conditions to matrixVictims
    eventPlayer.matrixVictims = [p for p in getAllPlayers() if distance(eventPlayer, p) <= 20 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ALL_BARRIERS) and p.getTeam() == eventPlayer.getTeam() and p.isAlive()]
    # increase damage of those players
    eventPlayer.matrixVictims.damageDealt[false] *= 1.60
	eventPlayer.matrixVictims.healingDealt[false] *= 1.60
    # begin statuses
    eventPlayer.matrixVictims.isStatused[0] = true
    eventPlayer.matrixVictims.amplifiedSTIMER = 10
    waitUntil(eventPlayer.usingUltimateREAL != true, 9999)
    # reverse of above
    eventPlayer.matrixVictims.damageDealt[false] /= 1.60
	eventPlayer.matrixVictims.healingDealt[false] /= 1.60
    eventPlayer.matrixVictims.isStatused[0] = false
    eventPlayer.matrixVictims = []
