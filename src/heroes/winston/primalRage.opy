#!mainFile "../../main.opy"

rule "[Winston] Primal Rage Activated":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.damageDealt[false] *= 2.0
    eventPlayer.setKnockbackDealt(0)
    waitUntil(eventPlayer.isUsingUltimate() != true, 9999)
    eventPlayer.damageDealt[false] /= 2.0
    eventPlayer.setKnockbackDealt(0)

rule "[Winston] On Primal Rage Hit":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventAbility == Button.ULTIMATE
    
    victim.applyImpulse(attacker.getFacingDirection() + ((Vector.UP + attacker.getFacingDirection()) / 2), 45, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
