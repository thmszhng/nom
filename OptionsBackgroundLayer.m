//
//  OptionsBackgroundLayer.m
//  Nom
//
//  Created by Thomas Zhang on 11-08-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "OptionsBackgroundLayer.h"


@implementation OptionsBackgroundLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        CCSprite *bg;
        bg = [CCSprite spriteWithFile: @"OptionsBackground.png"];
        [bg setPosition: CGPointMake (screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
    }
    
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}
@end
