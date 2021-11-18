#!mainFile "../../main.opy"

# Supercharger creates a large zone (35-45m), that weakens enemies and buffs teammates inside it.
# WEAKNESS: +20% damage received, -20% damage dealt
# BUFF: +20% damage dealt, -20% damage received
rule "[Orisa] Create Large Zone":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate()

    # wait until supercharger is placed / intitialize
    wait(0.4)
    # initialize supercharger
    eventPlayer.superchargerPosition = eventPlayer.getPosition()
    eventPlayer.superchargerSize = 0
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPHERE, Color.GREEN, eventPlayer.superchargerPosition, eventPlayer.superchargerSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.superchargerEffect.append(getLastCreatedEntity())
    createEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Effect.SPHERE, Color.ORANGE, eventPlayer.superchargerPosition, eventPlayer.superchargerSize, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.superchargerEffect.append(getLastCreatedEntity())
    async(superChargerPulsingEffect(), AsyncBehavior.NOOP)
    # expand supercharger radius
    chase(eventPlayer.superchargerSize, 32, duration=0.8, ChaseReeval.DESTINATION_AND_DURATION)
    waitUntil(not eventPlayer.isUsingUltimate(), 9999)
    # reverse expansion
    chase(eventPlayer.superchargerSize, 0, duration=0.8, ChaseReeval.DESTINATION_AND_DURATION)
    wait(0.8)
    # remove effects and reset variables
    stopChasingVariable(eventPlayer.superchargerSize)
    destroyEffect(eventPlayer.superchargerEffect)
    eventPlayer.superchargerSize = 0
