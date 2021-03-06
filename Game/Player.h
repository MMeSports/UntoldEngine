//
//  Player.hpp
//  UntoldEngine
//
//  Created by Harold Serrano on 4/22/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef Player_hpp
#define Player_hpp

#include <stdio.h>
#include "U4DGameObject.h"
#include "U4DAnimation.h"
#include "U4DAnimationManager.h"
#include "U4DCallback.h"
#include "U4DTimer.h"
#include "U4DArrive.h"
#include "U4DFlock.h"
#include "U4DPursuit.h"

class Foot;
class Team;

class Player:public U4DEngine::U4DGameObject {

private:

    //state of the character
    int state;
    
    //previous state of the character
    int previousState;
    
    //running animation
    U4DEngine::U4DAnimation *runningAnimation;
    
    //patrol idle animation
    U4DEngine::U4DAnimation *idleAnimation;
    
    //dribbling animation
    U4DEngine::U4DAnimation *dribblingAnimation;
    
    //halt animation
    U4DEngine::U4DAnimation *haltAnimation;
    
    //passing animation
    U4DEngine::U4DAnimation *passingAnimation;
    
    //shooting animation
    U4DEngine::U4DAnimation *shootingAnimation;
    
    //stand tackle animation
    U4DEngine::U4DAnimation *standTackleAnimation;
    
    //contain animation
    U4DEngine::U4DAnimation *containAnimation;
    
    //Animation Manager
    U4DEngine::U4DAnimationManager *animationManager;
    
    //force direction
    U4DEngine::U4DVector3n forceDirection;
    
    //dribbling direction
    U4DEngine::U4DVector3n dribblingDirection;

    //motion accumulator
    U4DEngine::U4DVector3n motionAccumulator;
    
    U4DEngine::U4DArrive arriveBehavior;
    
    U4DEngine::U4DPursuit pursuitBehavior;
    
    //Team player belongs to
    Team *team;
    
    //right foot
    Foot *rightFoot;
    
    bool dribble;
    
    bool passBall;
    
    bool shootBall;
    
    bool standTackleOpponent;
    
public:
    
    Player();
    
    ~Player();
    
    //init method. It loads all the rendering information among other things.
    bool init(const char* uModelName);
    
    void update(double dt);
    
    void setState(int uState);
    
    int getState();
    
    int getPreviousState();
    
    void changeState(int uState);
    
    void setMoveDirection(U4DEngine::U4DVector3n &uMoveDirection);
    
    void setForceDirection(U4DEngine::U4DVector3n &uForceDirection);
    
    void setDribblingDirection(U4DEngine::U4DVector3n &uDribblingDirection);
    
    void applyForce(float uFinalVelocity, double dt);
    
    void applyVelocity(U4DEngine::U4DVector3n &uFinalVelocity, double dt);
    
    void setViewDirection(U4DEngine::U4DVector3n &uViewDirection);
    
    void setFoot(Foot *uRightFoot);
    
    void setEnableDribbling(bool uValue);
    
    void setEnablePassing(bool uValue);
    
    void setEnableShooting(bool uValue);
    
    void setEnableStandTackle(bool uValue);
    
    U4DEngine::U4DVector3n getBallPositionOffset();
    
    void updateFootSpaceWithAnimation(U4DEngine::U4DAnimation *uAnimation);
    
    void closestPlayerToIntersect();
    
    void addToTeam(Team *uTeam);
    
    
    
};


#endif /* Player_hpp */
