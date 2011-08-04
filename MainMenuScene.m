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
        [self addChild: animationLayer z:0];
 
        //main menu layer
        mainMenuLayer = [MainMenuLayer node];
        [self addChild: mainMenuLayer z:5];
    }
    
    return self;
}
@end
