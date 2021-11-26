#!mainFile "../../main.opy"

rule "[DVA] Follow Bomb":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.bombEyePos = eventPlayer.getEyePosition() + worldVector(Vector.BACKWARD, eventPlayer, Transform.ROTATION)
    eventPlayer.bombPointPos = raycast(eventPlayer.bombEyePos, eventPlayer.bombEyePos + worldVector(vect(0, 0, 3), eventPlayer, Transform.ROTATION), eventPlayer, null, true).getHitPosition()
    eventPlayer.bombHitNormal = raycast(eventPlayer.bombEyePos, eventPlayer.bombEyePos + worldVector(vect(0, 0, 3), eventPlayer, Transform.ROTATION), eventPlayer, null, true).getNormal()
    eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
    if eventPlayer.getFacingDirection().y < -0.2:
        eventPlayer.bombInitNormal = Vector.UP
        downwardsTracking()
    else:
        eventPlayer.bombInitNormal = eventPlayer.bombHitNormal * vect(1, 0, 1)
        normalTracking()
    wait(0.3)
    eventPlayer.allowButton(Button.ULTIMATE)

def normalTracking():
    @Name "SUB Dva normalTracking"
    
    for eventPlayer.bombDuration in range(188):
        eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * bombRadius, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 0.5, eventPlayer, null, true).getHitPosition()
        eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
        eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        wait(false)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 100)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 150)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 6, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 400)

def downwardsTracking():
    @Name "SUB Dva downwardsTracking"
    
    for eventPlayer.bombDuration in range(188):
        if eventPlayer.bombDuration > 160:
            eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * 2, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 2, eventPlayer, null, true).getHitPosition()
            eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
            eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        else:
            eventPlayer.bombPointPos = raycast(eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * 1, eventPlayer.bombCenterPoint + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getHitPosition()
            eventPlayer.bombHitNormal = raycast(eventPlayer.bombPointPos + eventPlayer.bombInitNormal * 0.3, eventPlayer.bombPointPos + eventPlayer.bombInitNormal * -1 * 1, eventPlayer, null, true).getNormal()
            eventPlayer.bombCenterPoint = eventPlayer.bombPointPos + eventPlayer.bombHitNormal * bombRadius * -1
        wait(false)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 100)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 20, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 150)
    damage([p for p in getPlayersInRadius(eventPlayer.bombCenterPoint, 6, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if p != eventPlayer], eventPlayer, 400)
