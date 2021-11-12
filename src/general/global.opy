#!mainFile "../main.opy"

rule "[Global] Global 1":
    ultBoost = createWorkshopSetting(int[0:100], "OPTIONS", "ULTIMATE BOOST (%)", 0, 0) / 2
    devTools = createWorkshopSetting(bool, "DEV", "ENABLE DEV TOOLS", true, 1)
    specialThanks = createWorkshopSetting(enum["Thanks To", " Alomare", " LemonAid", " Zezombye", " CactusPuppy", " Zomg", " Provoxin", " Jester", "Spade"], "Credits", "Credits", 0, 2)
    # create hud texts
    hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, 0, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Overwatch OP & Costly Ultimates vALPHA | ---", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Original by u/Ender | Code: -----", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, 3, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #
    hudSubheader(getAllPlayers(), " \n\n\n\n", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n", HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # testing hud texts
    hudHeader(getAllPlayers(), "Bot Ult Charge : {0}".format(TESTBOT.getUltCharge()), HudPosition.RIGHT, 5, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Bot Distance : {0}".format(distance(localPlayer, TESTBOT)), HudPosition.RIGHT, 6, Color.BLUE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Player Is Using Ult : {0}".format(localPlayer.isUsingUltimate()), HudPosition.RIGHT, 7, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Effects/Entities : {0}".format(getNumberOfEntityIds()), HudPosition.RIGHT, 8, Color.YELLOW, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), "Texts : {0}".format(getNumberOfTextIds()), HudPosition.RIGHT, 9, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    # set global variables
    bombRadius = true
    bombOutsideRange = true
    colorArray = [Hero.ANA, Color.AQUA, Hero.ASHE, Color.GRAY, Hero.BAPTISTE, Color.LIME_GREEN, Hero.BASTION, Color.GRAY, Hero.BRIGITTE, Color.ORANGE, Hero.DOOMFIST, Color.RED, Hero.DVA, Color.ROSE, Hero.ECHO, Color.SKY_BLUE, Hero.GENJI, Color.GREEN, Hero.HANZO, Color.BLUE, Hero.ORISA, Color.LIME_GREEN, Hero.JUNKRAT, Color.ORANGE, Hero.LUCIO, Color.TURQUOISE, Hero.MCCREE, Color.ORANGE, Hero.MEI, Color.SKY_BLUE, Hero.MERCY, Color.YELLOW, Hero.MOIRA, Color.PURPLE, Hero.PHARAH, Color.SKY_BLUE, Hero.REAPER, Color.VIOLET, Hero.REINHARDT, Color.GRAY, Hero.ROADHOG, Color.ORANGE, Hero.SIGMA, Color.BLUE, Hero.SOLDIER, Color.BLUE, Hero.SOMBRA, Color.PURPLE, Hero.SYMMETRA, Color.AQUA, Hero.TORBJORN, Color.ORANGE, Hero.TRACER, Color.ORANGE, Hero.WIDOWMAKER, Color.VIOLET, Hero.WINSTON, Color.GRAY, Hero.HAMMOND, Color.ORANGE, Hero.ZARYA, Color.ROSE, Hero.ZENYATTA, Color.YELLOW]

rule "[Global] Player HUD":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.heroHUD == null

    # hero hud
    hudText(eventPlayer, " {0} ".format(heroIcon(eventPlayer.hero_)), "{0}".format(eventPlayer.ultName), "{0}".format(eventPlayer.ultDesc), HudPosition.LEFT, 0, colorArray[colorArray.index(eventPlayer.hero_) + 1], colorArray[colorArray.index(eventPlayer.hero_) + 1], Color.WHITE, HudReeval.VISIBILITY_STRING_AND_COLOR)
    eventPlayer.heroHUD = getLastCreatedText()
    #hudSubtext(eventPlayer if eventPlayer.isStatused[0] == true else null, "                                                                                                 {0}   {2} | {1} | {2}   {0}".format(eventPlayer.statusIcon[0], eventPlayer.statusName[0], eventPlayer.statusTimer[0] if eventPlayer.statusTimer[0] != null else ""), HudPosition.TOP, 4, eventPlayer.statusColor[0], HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
	#hudSubtext(eventPlayer if eventPlayer.isStatused[1] == true else null, "                                                                                                 {0}   {2} | {1} | {2}   {0}".format(eventPlayer.statusIcon[1], eventPlayer.statusName[1], eventPlayer.statusTimer[1] if eventPlayer.statusTimer[1] != null else ""), HudPosition.TOP, 4, eventPlayer.statusColor[1], HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    # status hud
    hudSubtext(eventPlayer if eventPlayer.isStatused[0] == true else null, "                                                                                                 {1} | {0} Amplified {0} | {1}".format(abilityIconString(Hero.BAPTISTE, Button.ULTIMATE), (eventPlayer.amplifiedSTIMER if eventPlayer.amplifiedSTIMER > 0 else "-")), HudPosition.TOP, 3 if eventPlayer.isStatused[0] == true else 13, Color.LIME_GREEN, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[1] == true else null, "                                                                                                 {0} | Counterpoised | {0}".format(abilityIconString(Hero.BASTION, Button.ABILITY_1)), HudPosition.TOP, 4 if eventPlayer.isStatused[1] == true else 14, Color.SKY_BLUE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[2] == true else null, "                                                                                                 {0} | Strengthened | {0}".format(abilityIconString(Hero.ORISA, Button.ABILITY_2)), HudPosition.TOP, 5 if eventPlayer.isStatused[2] == true else 15, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[3] == true else null, "                                                                                                 {0} | Weakened | {0}".format(abilityIconString(Hero.REINHARDT, Button.ULTIMATE)), HudPosition.TOP, 6 if eventPlayer.isStatused[3] == true else 16, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[4] == true else null, "                                                                                                 {1} | {0} Vulnerabled {0} | {1}".format(abilityIconString(Hero.GENJI, Button.JUMP), (eventPlayer.vulnerabledSTIMER if eventPlayer.vulnerabledSTIMER > 0 else "-")), HudPosition.TOP, 7 if eventPlayer.isStatused[4] == true else 17, Color.PURPLE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)
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
