#!mainFile "../main.opy"

rule "[Automation] Every Spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isDummy() != true

    Cleanup()

rule "[Automation] Swapped":
    @Event eachPlayer
    @Condition eventPlayer.hero_ != eventPlayer.getCurrentHero()
    @Condition eventPlayer.isDummy() != true
    
    eventPlayer.spawnedREAL = false
    Cleanup()

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