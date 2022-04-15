#!mainFile "../main.opy"

rule "[Automation] Prevent Server Crash":
    @Condition highPerformanceMode == true
    @Condition getServerLoad() >= 250

    wait(0.25, Wait.ABORT_WHEN_FALSE)
    setSlowMotion(10)
    waitUntil(getServerLoad() < 250, 9999)
    wait(0.25)
    setSlowMotion(100)

rule "[Automation] First Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.firstSpawn != true
    @Condition not eventPlayer.isDummy()

    printLog("FullCleanup()")
    FullCleanup()
    eventPlayer.hero_ = eventPlayer.getCurrentHero()
    if eventPlayer.hero_ in [Hero.MCCREE, Hero.DOOMFIST, Hero.ECHO, Hero.MOIRA, Hero.PHARAH, Hero.SOLDIER, Hero.SOMBRA, Hero.SYMMETRA, Hero.TORBJORN, Hero.TRACER, Hero.HAMMOND, Hero.ZARYA]:
        eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Automation] Every Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.firstSpawn == true
    @Condition not eventPlayer.isDummy()

    wait(0.128)
    printLog("RespawnCleanup()")
    RespawnCleanup()

rule "[Automation] Hero Swap":
    @Event eachPlayer
    @Condition eventPlayer.hero_ != eventPlayer.getCurrentHero()
    @Condition eventPlayer.hero_ != null
    @Condition eventPlayer.isDummy() != true

    printLog("SwapCleanup()")
    SwapCleanup()
    eventPlayer.hero_ = eventPlayer.getCurrentHero()
    if eventPlayer.hero_ in [Hero.MCCREE, Hero.DOOMFIST, Hero.ECHO, Hero.MOIRA, Hero.PHARAH, Hero.SOLDIER, Hero.SOMBRA, Hero.SYMMETRA, Hero.TORBJORN, Hero.TRACER, Hero.HAMMOND, Hero.ZARYA]:
        eventPlayer.disallowButton(Button.ULTIMATE)

rule "[Automation] Ultimate Boost":
    @Event eachPlayer
    @Condition eventPlayer.getUltCharge() < ultBoost
    
    eventPlayer.setUltCharge(ultBoost)
    wait(0.016)
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] Prevent Ultimate Charge Gain During Ultimate":
    @Event eachPlayer
    @Condition eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true
    @Condition eventPlayer.hero_ not in [Hero.LUCIO, Hero.BASTION, Hero.BRIGITTE, Hero.DVA, Hero.TORBJORN, Hero.PHARAH]
    @Condition eventPlayer.getUltCharge() >= 0.49 + ultBoost
    
    eventPlayer.setUltCharge(ultBoost)

rule "[Automation] Move Speed":
    @Event eachPlayer
    @Condition eventPlayer.moveSpeed[true] != eventPlayer.moveSpeed[false]
    
    # update moveSpeed variable and move speed to that variable
    eventPlayer.moveSpeed[true] = eventPlayer.moveSpeed[false]
    eventPlayer.setMoveSpeed(eventPlayer.moveSpeed[true])
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] Damage Dealt":
    @Event eachPlayer
    @Condition eventPlayer.damageDealt[true] != eventPlayer.damageDealt[false]

    # update damageDealt variable and damage dealt to that variable
    eventPlayer.damageDealt[true] = eventPlayer.damageDealt[false]
    eventPlayer.setDamageDealt(eventPlayer.damageDealt[true])
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] Damage Received":
    @Event eachPlayer
    @Condition eventPlayer.damageReceived[true] != eventPlayer.damageReceived[false]

    # update damageDealt variable and damage dealt to that variable
    eventPlayer.damageReceived[true] = eventPlayer.damageReceived[false]
    eventPlayer.setDamageReceived(eventPlayer.damageReceived[true]) 
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] Healing Dealt":
    @Event eachPlayer
    @Condition eventPlayer.healingDealt[true] != eventPlayer.healingDealt[false]

    # update healingDealt variable and healing dealt to that variable
    eventPlayer.healingDealt[true] = eventPlayer.healingDealt[false]
    eventPlayer.setHealingDealt(eventPlayer.healingDealt[true]) 
    if RULE_CONDITION:
        goto RULE_START

rule "[Automation] STATUS Chase Amplified":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()

    chase(eventPlayer.amplifiedSTIMER, 0, rate=1, ChaseReeval.NONE)

rule "[Automation] STATUS Chase Vulnerabled":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()

    chase(eventPlayer.vulnerabledSTIMER, 0, rate=1, ChaseReeval.NONE)

rule "[Automation] STATUS Chase Trapped":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()

    chase(eventPlayer.trappedSTIMER, 0, rate=1, ChaseReeval.NONE)