//
//  Transitions.h
//  Nom
//
//  Created on 11-08-23.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"

@interface CCNode(TransitionFinish)
-(void) transitionedIn;
@end

@interface SlideUp: CCTransitionSlideInB
{
}
@end

@interface SlideDown: CCTransitionSlideInT
{
}
@end
