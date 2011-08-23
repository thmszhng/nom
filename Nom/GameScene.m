//
//  GameScene.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameScene.h"
#import "AnimationLayer.h"

@implementation GameScene
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Background Layer
        gameBackgroundLayer = [GameBackgroundLayer node];
        [self addChild: gameBackgroundLayer z: 0 tag: kGameBackgroundLayer];
        
        //Gameplay Layer
        gameplayLayer = [GameplayLayer node];
        [self addChild: gameplayLayer z: 5 tag: kGameplayLayer];
    }
    
    return self;
}

-(void) mainMenu
{
    // TODO: animate
    [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
}
@end
