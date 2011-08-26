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
        
        /* TODO: Make this proper.
        CCMenuItemImage *playButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"OptionsPlay.png" 
                                       selectedImage: @"OptionsPlay-selected.png" 
                                       disabledImage: @"OptionsPlay.png"  
                                       target: self 
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(1, 1)];
        
        optionsMenu = [CCMenu menuWithItems: playButton, nil];
        [optionsMenu setPosition: CGPointZero];*/
    }
    
    return self;
}

-(void) playGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}
@end
