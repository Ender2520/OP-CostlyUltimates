#!mainFile "../main.opy"

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