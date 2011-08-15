//
//  GameScene.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Background Layer
        backgroundLayer = [BackgroundLayer node];
        [self addChild: backgroundLayer z: 0 tag: kBackgroundLayer];
        
        //Gameplay Layer
        gameplayLayer = [GameplayLayer node];
        [self addChild: gameplayLayer z: 5 tag: kGameplayLayer];
    }
    
    return self;
}
@end
