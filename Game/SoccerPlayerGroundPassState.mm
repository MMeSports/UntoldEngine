//
//  SoccerPlayerGroundPassState.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 2/19/17.
//  Copyright © 2017 Untold Game Studio. All rights reserved.
//

#include "SoccerPlayerGroundPassState.h"
#include "SoccerPlayerChaseBallState.h"
#include "SoccerPlayerIdleState.h"

SoccerPlayerGroundPassState* SoccerPlayerGroundPassState::instance=0;

SoccerPlayerGroundPassState::SoccerPlayerGroundPassState(){
    
}

SoccerPlayerGroundPassState::~SoccerPlayerGroundPassState(){
    
}

SoccerPlayerGroundPassState* SoccerPlayerGroundPassState::sharedInstance(){
    
    if (instance==0) {
        instance=new SoccerPlayerGroundPassState();
    }
    
    return instance;
    
}

void SoccerPlayerGroundPassState::enter(SoccerPlayer *uPlayer){
    
    //set the ground pass animation
    uPlayer->setNextAnimationToPlay(uPlayer->getGroundPassAnimation());
    uPlayer->setPlayNextAnimationContinuously(false);
    //uPlayer->setPlayBlendedAnimation(true);
    
    uPlayer->setFlagToPassBall(false);
    uPlayer->setFootSwingInitAngle(90.0);
}

void SoccerPlayerGroundPassState::execute(SoccerPlayer *uPlayer, double dt){
    
    uPlayer->swingFeet(90.0,3.0, dt);
    
    if(uPlayer->getFootCollidedWithBall()){
        
        U4DEngine::U4DVector3n direction=uPlayer->getPlayerHeading();
        
        uPlayer->kickBallToGround(300.0, direction,dt);
        
        SoccerPlayerChaseBallState *chaseBallState=SoccerPlayerChaseBallState::sharedInstance();
        //SoccerPlayerIdleState *idleState=SoccerPlayerIdleState::sharedInstance();
        
        uPlayer->changeState(chaseBallState);
    }
    
    //chase the ball
//    uPlayer->applyForceToPlayer(10.0, dt);
//    
//    uPlayer->trackBall();
}

void SoccerPlayerGroundPassState::exit(SoccerPlayer *uPlayer){
    
}