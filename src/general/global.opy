#!mainFile "../main.opy"

rule "[Global] Global 1":
    # testing hud texts
    if devTools == true:
        hudSubheader(getAllPlayers(), "Load [{0}] | Peak [{1}] | Avg [{2}]".format(getServerLoad(), getPeakServerLoad(), getAverageServerLoad()), HudPosition.RIGHT, 0, rgba(255, 255, 255, 125), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        hudSubtext(getAllPlayers(), "ULT - {0}%".format(TESTBOT.getUltCharge()), HudPosition.RIGHT, 5, Color.SKY_BLUE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        hudSubtext(getAllPlayers(), "DIST - {0}m".format(distance(localPlayer, TESTBOT)), HudPosition.RIGHT, 6, Color.GRAY, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
        hudSubtext(getAllPlayers(), "FX/ENTITY - {0} | TXT - {1}".format(getNumberOfEntityIds(), getNumberOfTextIds()), HudPosition.RIGHT, 8, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    else:
        disableInspector()
    # workshop settings
    highPerformanceMode = createWorkshopSetting(bool, "SETTINGS", "ENABLE HIGH PERFORMANCE MODE (if server load is too high)", false, 1)
    ultBoost = 100 - (100 / ((createWorkshopSetting(int[0:400], "OPTIONS", "ULTIMATE BOOST (%)", 0, 0) + 100) / 100))
    devTools = createWorkshopSetting(bool, "SETTINGS", "ENABLE DEV TOOLS", false, 1)
    specialThanks = createWorkshopSetting(enum["Thanks To", " Alomare", " LemonAid", " Zezombye", " CactusPuppy", " Zomg", " Provoxin", " Jester", " Spade", " T1mur4TR"], "Credits", "Credits", 0, 2)
    # high performance mode
    if highPerformanceMode == true:
        setSlowMotion(95)
    # create hud texts
    hudSubheader(getAllPlayers(), "Overwatch OP & Costly Ultimates v0.7.0-beta", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), "Original by u/Ender | Code: RYKD3", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudText(getAllPlayers(), "Discord", "Join for Updates and to Give Feedback", "bit.ly/ENDERSWORKSHOP (all caps)", HudPosition.RIGHT, 3, rgb(188,103,245), rgb(243,224,255), rgb(243,224,255), HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #
    hudSubheader(getAllPlayers(), "", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), " \n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, 18, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
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
    hudSubheader(eventPlayer if eventPlayer.ultTooltip != null else null, " \n{0} Tooltip: {1}".format(iconString(Icon.QUESTION_MARK), eventPlayer.ultTooltip), HudPosition.LEFT, 2, Color.GRAY, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.heroHUD = getLastCreatedText()
    # status hud
    hudSubtext(eventPlayer if eventPlayer.isStatused[0] == true else null, "                                                                                                 {1} | {0} Amplified {0} | {1}".format(abilityIconString(Hero.BAPTISTE, Button.ULTIMATE), (eventPlayer.amplifiedSTIMER if eventPlayer.amplifiedSTIMER > 0 else "-")), HudPosition.TOP, 3 if eventPlayer.isStatused[0] == true else 13, Color.LIME_GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[1] == true else null, "                                                                                                 {0} | Counterpoised | {0}".format(abilityIconString(Hero.BASTION, Button.ABILITY_1)), HudPosition.TOP, 4 if eventPlayer.isStatused[1] == true else 9, Color.SKY_BLUE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[2] == true else null, "                                                                                                 {0} | Strengthened | {0}".format(abilityIconString(Hero.ORISA, Button.ABILITY_2)), HudPosition.TOP, 5 if eventPlayer.isStatused[2] == true else 10, Color.GREEN, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[3] == true else null, "                                                                                                 {0} | Weakened | {0}".format(abilityIconString(Hero.REINHARDT, Button.ULTIMATE)), HudPosition.TOP, 6 if eventPlayer.isStatused[3] == true else 11, Color.ORANGE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[4] == true else null, "                                                                                                 {1} | {0} Vulnerabled {0} | {1}".format(abilityIconString(Hero.GENJI, Button.JUMP), (eventPlayer.vulnerabledSTIMER if eventPlayer.vulnerabledSTIMER > 0 else "-")), HudPosition.TOP, 7 if eventPlayer.isStatused[4] == true else 12, Color.PURPLE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)
    hudSubtext(eventPlayer if eventPlayer.isStatused[5] == true else null, "                                                                                                 {1} | {0} Trapped {0} | {1}".format(abilityIconString(Hero.HAMMOND, Button.ULTIMATE), (eventPlayer.trappedSTIMER if eventPlayer.trappedSTIMER > 0 else "-")), HudPosition.TOP, 8 if eventPlayer.isStatused[5] == true else 13, rgb(100,60,50), HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.DEFAULT)

rule "[Global] Ultimate Indicator":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.ultimateIcon == null
    
    createInWorldText([player for player in getAllPlayers() if player != eventPlayer] if eventPlayer.isUsingUltimate() or eventPlayer.usingUltimateREAL == true else null, abilityIconString(eventPlayer.getCurrentHero(), Button.ULTIMATE), updateEveryTick(eventPlayer.getEyePosition() + vect(0,0.5,0)), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    eventPlayer.ultimateIcon = (getLastCreatedText())

rule "[Global] Remove Indicators on Leave":
    @Event playerLeft

    destroyInWorldText(eventPlayer.ultimateIcon)

rule "[Global] Role Lock on Tanks":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() in getTankHeroes()
    @Disabled

    [p for p in getPlayers(eventPlayer.getTeam()) if p != eventPlayer].setAllowedHeroes([h for h in getAllHeroes() if h not in getTankHeroes()])
    eventPlayer.setAllowedHeroes(getTankHeroes())