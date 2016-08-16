//
//  U4DNumerical.cpp
//  UntoldEngine
//
//  Created by Harold Serrano on 8/6/16.
//  Copyright © 2016 Untold Game Studio. All rights reserved.
//

#include "U4DNumerical.h"
#include <cmath>

namespace U4DEngine {
    
    U4DNumerical::U4DNumerical(){
        
    }
    
    U4DNumerical::~U4DNumerical(){
        
    }
    
    bool U4DNumerical::areEqualAbs(float uNumber1, float uNumber2, float uEpsilon){
        
        return (fabs(uNumber1-uNumber2)<=uEpsilon);
        
    }
    
    
    bool U4DNumerical::areEqualRel(float uNumber1, float uNumber2, float uEpsilon){
       
        return (fabs(uNumber1-uNumber2)<=uEpsilon*MAX(fabs(uNumber1),fabs(uNumber2)));
                
    }
    
    
    bool U4DNumerical::areEqual(float uNumber1, float uNumber2, float uEpsilon){
        
        return (fabs(uNumber1-uNumber2)<=uEpsilon*MAX(1.0,MAX(fabs(uNumber1),fabs(uNumber2))));
        
    }

}