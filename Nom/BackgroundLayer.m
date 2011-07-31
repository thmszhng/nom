//
//  BackgroundLayer.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        CCSprite *backgroundImage;
        CCSprite *grid;
        CCSprite *control;

        backgroundImage = [CCSprite spriteWithFile:@"backgroundiPhone.png"];
        grid = [CCSprite spriteWithFile:@"Grid.png"];
        control = [CCSprite spriteWithFile:@"Control.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [backgroundImage setPosition: CGPointMake(screenSize.width/2, screenSize.height/2)];
        [grid setPosition: CGPointMake(screenSize.width/2, 320)];
        [control setPosition: CGPointMake (screenSize.width/2, 85)]; 
        
        [self addChild:backgroundImage z:0 tag:kGameSceneTagValue];
        [self addChild:grid z:0 tag:kGameSceneTagValue];
        [self addChild:control z:0 tag:kGameSceneTagValue];
    }
    
    return self;
}
@end
