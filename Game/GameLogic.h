//
//  GameLogic.h
//  UntoldEngine
//
//  Created by Harold Serrano on 6/11/13.
//  Copyright (c) 2013 Untold Story Studio. All rights reserved.
//

#ifndef __UntoldEngine__GameLogic__
#define __UntoldEngine__GameLogic__

#include <iostream>
#include "U4DGameModel.h"
#include "UserCommonProtocols.h"

namespace U4DEngine {
    class U4DTouches;
    class U4DButton;
    class U4DJoyStick;
}

class GameLogic:public U4DEngine::U4DGameModel{
    
public:
    
    
    
    GameLogic();
    
    ~GameLogic();
    
    void update(double dt);
    
    void init();
    
    void receiveTouchUpdate(void *uData);
    
    void initModels();
    
    void removeModels();
    
    
};
#endif /* defined(__UntoldEngine__GameLogic__) */
