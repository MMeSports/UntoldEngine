//
//  StartLogic.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 6/12/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "StartLogic.h"
#include "CommonProtocols.h"
#include "U4DSceneManager.h"
#include "MenuScene.h"

using namespace U4DEngine;

StartLogic::StartLogic(){
    
}

StartLogic::~StartLogic(){
    
}

void StartLogic::update(double dt){
    
}

void StartLogic::init(){
    
}

void StartLogic::changeToMainScene(){
    
    //get instance of scene manager
    U4DEngine::U4DSceneManager *sceneManager=U4DEngine::U4DSceneManager::sharedInstance();

    //Switch to other Menu Screen
    MenuScene *menuScene=new MenuScene();

    sceneManager->changeScene(menuScene);
    
}

void StartLogic::receiveUserInputUpdate(void *uData){
    
    CONTROLLERMESSAGE controllerInputMessage=*(CONTROLLERMESSAGE*)uData;
            
        //2. Determine what was pressed, buttons, keys or joystick
    
        switch (controllerInputMessage.inputElementType) {
            
            case U4DEngine::uiButton:
            
            if(controllerInputMessage.inputElementAction==U4DEngine::uiButtonPressed){
                
                //pass
                if (controllerInputMessage.elementUIName.compare("buttonA")==0) {
                    
                    //change to main scene
                    changeToMainScene();
                
                }
                
            }else if (controllerInputMessage.inputElementAction==U4DEngine::uiButtonReleased){
            
                
            
            }
            
            break;
                
            case U4DEngine::padButtonA:
            
            if (controllerInputMessage.inputElementAction==U4DEngine::padButtonPressed) {
                
                //change to main scene
                changeToMainScene();
                
                
            }else if(controllerInputMessage.inputElementAction==U4DEngine::padButtonReleased){
                
            }
            
            break;
                
            case U4DEngine::macSpaceKey:
            {
                //4. If button was pressed
                if (controllerInputMessage.inputElementAction==U4DEngine::macKeyPressed) {
                    
                    //change to main scene
                    changeToMainScene();
                    
                    //5. If button was released
                }else if(controllerInputMessage.inputElementAction==U4DEngine::macKeyReleased){
                    
                    
                    
                }
            }
                
                break;
                
            default:
                break;
                
        }
    
        
}
