//
//  GameScene.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
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
        [self addChild:backgroundLayer z:0];
        
        //Gameplay Layer
        gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:5];
    }
    
    return self;
}
@end
