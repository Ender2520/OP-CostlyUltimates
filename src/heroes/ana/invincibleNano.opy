#!mainFile "../../main.opy"

rule "[Ana] Invincible Nano-Boost":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ULTIMATE

    # give nano'd player invincibility
    healee.setStatusEffect(healee, Status.INVINCIBLE, 8)
    healee.megaBoosted = true
    # sound queue
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, healee, 200)
    waitUntil(eventPlayer.isUsingUltimate() != true or healee.isDead(), 8)
    healee.megaBoosted = false