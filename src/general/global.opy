#!mainFile "../main.opy"

rule "[Global] Global 1":
    ultBoost = createWorkshopSetting(int[0:100], "OPTIONS", "ULTIMATE BOOST (%)", 0, 0) / 2
    devTools = createWorkshopSetting(bool, "DEV", "ENABLE DEV TOOLS", true, 1)
    # create hud texts
    hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, 0, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Overwatch OP & Costly Ultimates vALPHA | ---", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Original by u/Ender | Code: -----", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, 3, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # testing hud texts
    hudHeader(getAllPlayers(), "Bot Ult Charge : {0}".format(TESTBOT.getUltCharge()), HudPosition.LEFT, 5, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Bot Distance : {0}".format(distance(localPlayer, TESTBOT)), HudPosition.LEFT, 6, Color.BLUE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Player Is Using Ult : {0}".format(localPlayer.isUsingUltimate()), HudPosition.LEFT, 7, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Effects/Entities : {0}".format(getNumberOfEntityIds()), HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Texts : {0}".format(getNumberOfTextIds()), HudPosition.LEFT, 9, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    # set global variables
    bombRadius = true
    bombOutsideRange = true
    colorArray = [Hero.ANA, Color.AQUA, Hero.ASHE, Color.GRAY, Hero.BAPTISTE, Color.LIME_GREEN, Hero.BASTION, Color.GRAY, Hero.BRIGITTE, Color.ORANGE, Hero.DOOMFIST, Color.RED, Hero.DVA, Color.ROSE, Hero.ECHO, Color.SKY_BLUE, Hero.GENJI, Color.GREEN, Hero.HANZO, Color.BLUE, Hero.ORISA, Color.LIME_GREEN, Hero.JUNKRAT, Color.ORANGE, Hero.LUCIO, Color.TURQUOISE, Hero.MCCREE, Color.ORANGE, Hero.MEI, Color.SKY_BLUE, Hero.MERCY, Color.YELLOW, Hero.MOIRA, Color.PURPLE, Hero.PHARAH, Color.SKY_BLUE, Hero.REAPER, Color.VIOLET, Hero.REINHARDT, Color.GRAY, Hero.ROADHOG, Color.ORANGE, Hero.SIGMA, Color.BLUE, Hero.SOLDIER, Color.BLUE, Hero.SOMBRA, Color.PURPLE, Hero.SYMMETRA, Color.AQUA, Hero.TORBJORN, Color.ORANGE, Hero.TRACER, Color.ORANGE, Hero.WIDOWMAKER, Color.VIOLET, Hero.WINSTON, Color.GRAY, Hero.HAMMOND, Color.ORANGE, Hero.ZARYA, Color.ROSE, Hero.ZENYATTA, Color.YELLOW]

rule "[Global] Hero HUD":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.heroHUD == null

    hudText(eventPlayer, " {0} ".format(heroIcon(eventPlayer.hero_)), "{0}".format(eventPlayer.ultName), "{0}".format(eventPlayer.ultDesc), HudPosition.LEFT, 0, colorArray[colorArray.index(eventPlayer.hero_) + 1], colorArray[colorArray.index(eventPlayer.hero_) + 1], Color.WHITE, HudReeval.VISIBILITY_STRING_AND_COLOR)
    eventPlayer.heroHUD = getLastCreatedText()

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