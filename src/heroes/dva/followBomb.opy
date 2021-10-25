#!mainFile "../../main.opy"

rule "[DVA] Follow Bomb":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isUsingUltimate() == true
    
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