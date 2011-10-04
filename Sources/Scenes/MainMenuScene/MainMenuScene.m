//
//  MainMenuScene.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene
-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        // animation layer
        animationLayer = [AnimationLayer node];
        [self addChild: animationLayer z:0 tag: kAnimationLayer];
 
        //main menu layer
        mainMenuLayer = [MainMenuLayer node];
        [self addChild: mainMenuLayer z:5 tag: kMainMenuLayer];
    }
    
    return self;
}

-(void) transitionedIn
{
    [CCDirector sharedDirector].animationInterval = 1.f/30.f;
}
@end
