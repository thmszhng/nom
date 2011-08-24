//
//  Transitions.h
//  Nom
//
//  Created on 11-08-23.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Transitions.h"

@implementation SlideDown

-(CCActionInterval *) easeActionWithAction: (CCActionInterval *) action
{
    return [CCEaseExponentialOut actionWithAction: action];
}

@end

@implementation SlideUp

-(CCActionInterval *) easeActionWithAction: (CCActionInterval *) action
{
    return [CCEaseExponentialOut actionWithAction: action];
}

@end
