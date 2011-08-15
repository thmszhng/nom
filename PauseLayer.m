//
//  PauseLayer.m
//  Nom
//
//  Created by Xamigo on 11-08-06.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "PauseLayer.h"
#import "GameplayLayer.h"

@implementation PauseLayer

-(id) initWithColor:(ccColor4B)color
{
    if ((self = [super initWithColor: color]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        CCSprite *paused = [CCSprite spriteWithFile: @"PauseOverlay.png"];
        [paused setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: paused];
    }
    
    return self;
}

// unpauses game when screen is tapped
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameplayLayer * gl = (GameplayLayer *)[self.parent getChildByTag: kGameplayLayer];
    [self.parent removeChild:self cleanup:YES];
    [gl onEnter];
}


@end
