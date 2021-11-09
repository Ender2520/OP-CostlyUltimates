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
    eventPlayer.setUltCharge(0+ultBoost)
    wait()
    # initialize Amp. Matrix
    eventPlayer.matrixSize = 0
    createEffect(getAllPlayers(), Effect.SPHERE, Color.LIME_GREEN, eventPlayer.getPosition(), eventPlayer.matrixSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.LIME_GREEN, eventPlayer.getPosition(), 40)
    playEffect(getAllPlayers(), DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 180)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer.getPosition(), 120)
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
    @Hero baptiste
    @Condition eventPlayer.matrixSize > 0

    # assign players withtin conditions to matrixVictims
    eventPlayer.matrixVictims = [p for p in getAllPlayers() if distance(eventPlayer, p) <= 20 and isInLoS(eventPlayer, p, BarrierLos.BLOCKED_BY_ALL_BARRIERS) and p.getTeam() == eventPlayer.getTeam() and p.isAlive()]
    # increase damage of those players
    eventPlayer.matrixVictims.damageDealt[false] *= 2.0
    # STATUS
    eventPlayer.statusIcon.append(abilityIconString(Hero.BAPTISTE, Button.ULTIMATE))
    eventPlayer.statusName.append("AMPLIFIED")
    eventPlayer.statusTimer.append(10)
    eventPlayer.statusColor.append(Color.GREEN)
    eventPlayer.isStatused.append(true)
    statusTimerBaptisteAmplified()
    # reverse of above
    eventPlayer.matrixVictims.damageDealt[false] /= 2.0
    eventPlayer.matrixVictims = []
    # STATUS REVERT
    eventPlayer.statusTimer.remove(eventPlayer.statusTimer[eventPlayer.statusName.index("AMPLIFIED")])
    eventPlayer.statusIcon.remove(abilityIconString(Hero.BAPTISTE, Button.ULTIMATE))
    eventPlayer.statusName.remove("AMPLIFIED")
    eventPlayer.statusColor.remove(Color.GREEN)
    eventPlayer.isStatused.remove(true)
