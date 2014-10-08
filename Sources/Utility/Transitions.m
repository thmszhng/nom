//
//  Transitions.h
//  Nom
//
//  Created on 11-08-23.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Transitions.h"

@implementation CCNode(TransitionFinish)

-(void) transitionedIn
{
}
-(void) transitioningOut
{
}

@end

@implementation SlideDown

-(void) finish
{
    [inScene_ transitionedIn];
    [super finish];
}

-(void) onEnter
{
    [super onEnter];
    [outScene_ transitioningOut];
}

-(CCActionInterval *) easeActionWithAction: (CCActionInterval *) action
{
    return [CCEaseExponentialOut actionWithAction: action];
}

@end

@implementation SlideUp

-(void) finish
{
    [inScene_ transitionedIn];
    [super finish];
}

-(void) onEnter
{
    [super onEnter];
    [outScene_ transitioningOut];
}

-(CCActionInterval *) easeActionWithAction: (CCActionInterval *) action
{
    return [CCEaseExponentialOut actionWithAction: action];
}

@end
