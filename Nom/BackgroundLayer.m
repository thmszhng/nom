//
//  BackgroundLayer.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CCSprite *control;
        control = [CCSprite spriteWithFile:@"Control.png"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [control setPosition: CGPointMake (screenSize.width/2, 85)];
        [self addChild:control z:0 tag:kGameSceneTagValue];
    }
    
    return self;
}

-(void) draw
{
    glClearColor(1.f, 1.f, 1.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT);
}
@end
