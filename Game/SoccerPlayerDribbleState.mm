//
//  SoccerPlayerDribbleState.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 2/17/17.
//  Copyright © 2017 Untold Game Studio. All rights reserved.
//

#include "SoccerPlayerDribbleState.h"
#include "SoccerPlayerChaseBallState.h"
#include "SoccerPlayerGroundPassState.h"
#include "SoccerBall.h"

SoccerPlayerDribbleState* SoccerPlayerDribbleState::instance=0;

SoccerPlayerDribbleState::SoccerPlayerDribbleState(){
    
}

SoccerPlayerDribbleState::~SoccerPlayerDribbleState(){
    
}

SoccerPlayerDribbleState* SoccerPlayerDribbleState::sharedInstance(){
    
    if (instance==0) {
        instance=new SoccerPlayerDribbleState();
    }
    
    return instance;
    
}

void SoccerPlayerDribbleState::enter(SoccerPlayer *uPlayer){
    
    //set dribble animation
    uPlayer->setNextAnimationToPlay(uPlayer->getRunningAnimation());
    uPlayer->setPlayNextAnimationContinuously(true);
    uPlayer->setPlayBlendedAnimation(true);
    
}

void SoccerPlayerDribbleState::execute(SoccerPlayer *uPlayer, double dt){
    
    float distanceToBall=uPlayer->distanceToBall();
    SoccerBall *ball=uPlayer->getBallEntity();
    
    //get angle between player and ball
    U4DEngine::U4DVector3n heading=uPlayer->getPlayerHeading();
    heading.normalize();
    
    U4DEngine::U4DVector3n ballPosition=ball->getAbsolutePosition();
    U4DEngine::U4DVector3n playerPosition=uPlayer->getAbsolutePosition();
    
    playerPosition.y=ballPosition.y;
    
    U4DEngine::U4DVector3n pos=ballPosition-playerPosition;
    
    std::cout<<"angle: "<<pos.angle(heading)<<std::endl;
    
    //check if player should pass
    if (uPlayer->getButtonAPressed() && (distanceToBall<=ball->getBallRadius()+3.0)) {
        
        SoccerPlayerGroundPassState *groundPassState=SoccerPlayerGroundPassState::sharedInstance();
        
        uPlayer->changeState(groundPassState);
        
    }
    
    U4DEngine::U4DVector3n directionToKick=uPlayer->getPlayerHeading();
    
    //if the joystick is active, set the new direction of the kick
    if (uPlayer->getJoystickActive()) {
        
        directionToKick=uPlayer->getJoystickDirection();
        directionToKick.z=-directionToKick.y;
        
        directionToKick.y=0;
    }
    
    //dribble
    
    if (uPlayer->getIsAnimationUpdatingKeyframe()) {
        
        //set the kick pass at this keyframe and interpolation time
        if ((uPlayer->getAnimationCurrentKeyframe()==0 || uPlayer->getAnimationCurrentKeyframe()==6) && uPlayer->getAnimationCurrentInterpolationTime()==0.0) {
            
            uPlayer->kickBallToGround(15.0, directionToKick,dt);
            
        }
    }
    
    //check the distance between the ball and the player
    if (distanceToBall>5.0) {
        
        ball->removeKineticForces();
    }
    
    //chase the ball
    uPlayer->applyForceToPlayer(10.0, dt);
    
    uPlayer->trackBall();
}

void SoccerPlayerDribbleState::exit(SoccerPlayer *uPlayer){
    
}
