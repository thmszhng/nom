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
        
        slowButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"OptionHard.png" 
                                       selectedImage: @"OptionHard-selected.png" 
                                       disabledImage: @"OptionHard-selected.png"  
                                       target: self 
                                       selector: @selector(setSlow)];
        [slowButton setPosition: ccp(66.5, 117.5)];
        mediumButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"OptionHarder.png" 
                                       selectedImage: @"OptionHarder-selected.png" 
                                       disabledImage: @"OptionHarder-selected.png"
                                       target: self 
                                       selector: @selector(setMedium)];
        [mediumButton setPosition: ccp(160, 117.5)];
        fastButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"OptionCrazy.png" 
                                       selectedImage: @"OptionCrazy-selected.png" 
                                       disabledImage: @"OptionCrazy-selected.png"
                                       target: self 
                                       selector: @selector(setFast)];
        [fastButton setPosition: ccp(253.5, 117.5)];
        
        CCMenuItemImage *playButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"OptionPlayGame.png" 
                                       selectedImage: @"OptionPlayGame-selected.png" 
                                       disabledImage: @"OptionPlayGame.png"  
                                       target: self 
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(160, 55)];
        
        optionsMenu = [CCMenu menuWithItems: slowButton,
                       mediumButton, fastButton, playButton, nil];
        [optionsMenu setPosition: CGPointZero];
        [self addChild: optionsMenu];
        
        [self setSlow];
    }
    
    return self;
}

// TODO: make stuff work
-(void) setSlow
{
    [slowButton setIsEnabled: NO];
    [mediumButton setIsEnabled: YES];
    [fastButton setIsEnabled: YES];
}
-(void) setMedium
{
    [slowButton setIsEnabled: YES];
    [mediumButton setIsEnabled: NO];
    [fastButton setIsEnabled: YES];
}
-(void) setFast
{
    [slowButton setIsEnabled: YES];
    [mediumButton setIsEnabled: YES];
    [fastButton setIsEnabled: NO];
}

-(void) playGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}
@end
