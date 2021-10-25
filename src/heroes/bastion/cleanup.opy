#!mainFile "../../main.opy"

rule "[Bastion] Destroy Effects on Death":
    @Event eachPlayer
    @Hero bastion
    @Condition not eventPlayer.isUsingUltimate()
    @Condition eventPlayer.missileTimer > 0

    async(animationCleanup(), AsyncBehavior.RESTART)