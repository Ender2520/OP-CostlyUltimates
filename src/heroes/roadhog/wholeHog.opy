#!mainFile "../../main.opy"

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
    victim.applyImpulse(directionTowards(victim, attacker), 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)