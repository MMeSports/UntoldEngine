//
//  U11AttackStrategy.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 6/10/17.
//  Copyright © 2017 Untold Game Studio. All rights reserved.
//

#include "U11AIAttackStrategy.h"
#include "U11Team.h"
#include "U11MessageDispatcher.h"
#include "U11SpaceAnalyzer.h"
#include "U11Player.h"
#include "UserCommonProtocols.h"

U11AIAttackStrategy::U11AIAttackStrategy(){
    
}

U11AIAttackStrategy::~U11AIAttackStrategy(){
    
}

void U11AIAttackStrategy::setTeam(U11Team *uTeam){
    
    team=uTeam;
    
}

void U11AIAttackStrategy::analyzePlay(){
    

    if (shouldPassForward()) {
        
        passForward();
        
    }else{
        
        dribble();
        
    }
    
}

bool U11AIAttackStrategy::shouldPassForward(){
    
    //space analyzer
    U11SpaceAnalyzer spaceAnalyzer;
    
    //get the support players
    U11Player *support=team->getSupportPlayer();
    
    //for each player get the number of opponents threatening && is it closer to the goal than the controlling player
    
    if (spaceAnalyzer.analyzeIfPlayerIsCloserToGoalThanMainPlayer(team, support)) {
        
        std::cout<<"Should pass"<<std::endl;
        
        return true;
        
    }
    
    return false;
    
    
}

void U11AIAttackStrategy::passForward(){
    
    //get the support players
    U11Player *supportPlayer=team->getSupportPlayer();
    
    U11Player *controllingPlayer=team->getControllingPlayer();
    
    U4DEngine::U4DVector3n supportPosition=(supportPlayer->getSupportPosition()).toVector();
    
    U4DEngine::U4DVector3n controllingPlayerPosition=controllingPlayer->getAbsolutePosition();
    
    supportPosition.y=0.0;
    
    controllingPlayerPosition.y=0.0;
    
    U4DEngine::U4DVector3n distanceBetweenPlayers=supportPosition-controllingPlayerPosition;
    
    //get player heading vector
    U4DEngine::U4DVector3n playerHeading=controllingPlayer->getPlayerHeading();
    
    playerHeading.y=0.0;
    
    playerHeading.normalize();
    
    float angle=controllingPlayerPosition.angle(supportPosition);
    
    U4DEngine::U4DVector3n rotationAxis=playerHeading.cross(distanceBetweenPlayers);
    
    rotationAxis.normalize();

    U4DEngine::U4DVector3n kickingDirection=playerHeading.rotateVectorAboutAngleAndAxis(angle, rotationAxis);
    
    controllingPlayer->setBallKickDirection(kickingDirection);
    
    int ballSpeed=50;
    
    U11MessageDispatcher *messageDispatcher=U11MessageDispatcher::sharedInstance();
    
    messageDispatcher->sendMessage(0.0, nullptr, controllingPlayer, msgPassBall,(void*)&ballSpeed);
    
    messageDispatcher->sendMessage(0.0, nullptr, supportPlayer, msgReceiveBall);
    
}

void U11AIAttackStrategy::dribble(){
    
    //get controlling player
    U11Player *controllingPlayer=team->getControllingPlayer();
    
    //get the player new dribble heading
    
    U11SpaceAnalyzer spaceAnalyzer;
    
    U4DEngine::U4DVector3n playerDribblingVector=spaceAnalyzer.computeOptimalDribblingVector(team);
    
    playerDribblingVector.normalize();
    
    playerDribblingVector.y=0.0;
    
    //get player heading vector
    U4DEngine::U4DVector3n playerHeading=controllingPlayer->getPlayerHeading();
    
    playerHeading.y=0.0;
    
    playerHeading.normalize();
    
    U11Player* threateningPlayer=controllingPlayer->getThreateningPlayer();
    
    //get the distance
    
    float distance=(controllingPlayer->getAbsolutePosition()-threateningPlayer->getAbsolutePosition()).magnitude();
    
    if (distance<15.0) {
        
        if (playerHeading.dot(threateningPlayer->getPlayerHeading())<-0.7) {
            
            //get the rotation axis
            U4DEngine::U4DVector3n rotationAxis=playerHeading.cross(playerDribblingVector);
            
            rotationAxis.normalize();
            
            playerDribblingVector=playerDribblingVector.rotateVectorAboutAngleAndAxis(60.0, rotationAxis);
            
        }
        
    }
    
    controllingPlayer->setBallKickDirection(playerDribblingVector);
    
    U11MessageDispatcher *messageDispatcher=U11MessageDispatcher::sharedInstance();
    
    messageDispatcher->sendMessage(0.0, nullptr, controllingPlayer, msgDribble);
    
}