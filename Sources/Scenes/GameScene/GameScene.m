//
//  GameScene.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameScene.h"
#import "GameBackgroundLayer.h"
#import "LevelLayer.h"
#import "GameplayLayer.h"

@implementation GameScene
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Background Layer
        gameBackgroundLayer = [GameBackgroundLayer node];
        [self addChild: gameBackgroundLayer z: 0 tag: kGameBackgroundLayer];
        
        //Level Layer
        levelLayer = [LevelLayer node];
        [self addChild: levelLayer z: 2 tag: kGameLevelLayer];
        
        //Gameplay Layer
        gameplayLayer = [GameplayLayer node];
        [self addChild: gameplayLayer z: 5 tag: kGameplayLayer];
        levelLayer.theGameplayLayer = gameplayLayer;
    }
    
    return self;
}

-(void) transitionedIn
{
    [CCDirector sharedDirector].animationInterval = 1.f/30.f;
}
@end
