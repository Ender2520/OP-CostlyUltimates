#!mainFile "../../main.opy"

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