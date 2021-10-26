#!mainFile "../main.opy"

rule "[Global] Global 1":
    ultBoost = createWorkshopSetting(int[0:100], "OPTIONS", "ULTIMATE BOOST (%)", 0, 0) / 2
    devTools = createWorkshopSetting(bool, "DEV", "ENABLE DEV TOOLS", true, 1)
    # create hud texts
    hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, -21, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Overwatch OP & Costly Ultimates vALPHA | ---", HudPosition.RIGHT, -20, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Original by u/Ender | Code: -----", HudPosition.RIGHT, -19, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, -18, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # testing hud texts
    hudHeader(getAllPlayers(), "Bot Ult Charge : {0}".format(TESTBOT.getUltCharge()), HudPosition.LEFT, 0, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Bot Distance : {0}".format(distance(localPlayer, TESTBOT)), HudPosition.LEFT, 1, Color.BLUE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Player Is Using Ult : {0}".format(localPlayer.isUsingUltimate()), HudPosition.LEFT, 2, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Effects/Entities : {0}".format(getNumberOfEntityIds()), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Texts : {0}".format(getNumberOfTextIds()), HudPosition.LEFT, 4, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    # set global variables
    bombRadius = true
    bombOutsideRange = true

rule "[Global] Ultimate Indicator":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.ultimateIcon == null
    
    createIcon([player for player in getAllPlayers() if player != eventPlayer] if eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true else null, updateEveryTick(eventPlayer.getEyePosition() + vect(0,0.5,0)), Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY_POSITION_AND_COLOR, eventPlayer.ultimateIconColor, false)
    eventPlayer.ultimateIcon = (getLastCreatedText())

rule "[Global] Remove Indicators on Leave":
    @Event playerLeft

    destroyInWorldText(eventPlayer.ultimateIcon)

rule "[Global] Icon Change Colors":
    @Event eachPlayer
    @Condition eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true

    eventPlayer.ultimateIconColor = Color.RED
    wait(1)
    eventPlayer.ultimateIconColor = Color.WHITE
    wait(1)
    if RULE_CONDITION:
        goto RULE_START