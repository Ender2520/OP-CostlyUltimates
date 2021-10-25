#!mainFile "../../main.opy"

rule "[Mercy] Golden Gun HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isAlive()

    hudSubtext(eventPlayer, "                                                                                                 {0} Golden Gun [{1}]".format(iconString(Icon.SKULL), (" FIRE " if eventPlayer.goldenGunReloaded == true else eventPlayer.goldenGunCooldown)), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.goldenGunHUD = getLastCreatedText()
    waitUntil(not eventPlayer.isUsingUltimate(), 9999)
    destroyHudText(eventPlayer.goldenGunHUD)
    eventPlayer.goldenGunHUD = null