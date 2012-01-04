//
//  MainMenuScene.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuScene.h"

#import "MainMenuLayer.h"

@implementation MainMenuScene
-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        //white background
        [self addChild: [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)]];
        
        //main menu layer
        mainMenuLayer = [MainMenuLayer node];
        [self addChild: mainMenuLayer z:5 tag: kMainMenuLayer];
    }
    
    return self;
}

-(void) transitionedIn
{
    [CCDirector sharedDirector].animationInterval = 1.f/4.f;
}

-(void) transitioningOut
{
    [CCDirector sharedDirector].animationInterval = 1.f/60.f;
}

@end
