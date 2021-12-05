#!mainFile "../main.opy"

rule "[Automation] Prevent Server Crash":
    @Condition highPerformanceMode == true
    @Condition getServerLoad() >= 250

    wait(0.25, Wait.ABORT_WHEN_FALSE)
    setSlowMotion(10)
    waitUntil(getServerLoad() < 250, 9999)
    wait(0.25)
    setSlowMotion(100)

rule "[Automation] Assembling Heroes (not first spawn)":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition isAssemblingHeroes()
    @Condition eventPlayer.firstSpawn != null

    printLog("FullCleanup() (AH)")
    FullCleanup()
    eventPlayer.hero_ = eventPlayer.getCurrentHero()

rule "[Automation] First Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.firstSpawn == null

    printLog("FullCleanup()")
    FullCleanup()
    eventPlayer.hero_ = eventPlayer.getCurrentHero()

rule "[Automation] Every Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.firstSpawn != null

    printLog("RespawnCleanup()")
    RespawnCleanup()
    wait()
    printLog("HeroCleanup()")
    HeroCleanup()

rule "[Automation] Hero Swap":
    @Event eachPlayer
    @Condition eventPlayer.hero_ != eventPlayer.getCurrentHero()
    @Condition eventPlayer.hero_ != null
    @Condition eventPlayer.isDummy() != true
    
    printLog("SwapCleanup()")
    SwapCleanup()
    eventPlayer.hero_ = eventPlayer.getCurrentHero()

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
    
    while eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true:
        if eventPlayer.getUltCharge() >= ultBoost + 0.4:
            eventPlayer.setUltCharge(ultBoost)
        wait(0.096)

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

rule "[Automation] Healing Dealt":
    @Event eachPlayer
    @Condition eventPlayer.healingDealt[true] != eventPlayer.healingDealt[false]

    # update healingDealt variable and healing dealt to that variable
    eventPlayer.healingDealt[true] = eventPlayer.healingDealt[false]
    eventPlayer.setHealingDealt(eventPlayer.healingDealt[true]) 

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