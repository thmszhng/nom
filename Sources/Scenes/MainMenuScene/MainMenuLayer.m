//
//  MainMenuLayer.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuLayer.h"

#import "GameManager.h"
#import "SpriteLoader.h"
#import "Render.h"

@implementation MainMenuLayer

-(id) init
{
    self = [super init];
    
    if (self != nil)
    {        
        //enable touches
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //background
        CCSprite *bg = loadSprite(@"Frame.png");
        [bg setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
        
        //Play Regular Mode Button
        CCMenuItem *playRegular =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"regular mode", CGSizeMake(320, 60), 35,
                                                             NO, ccBLACK)
                                selectedSprite: createButton(@"regular mode", CGSizeMake(320, 60), 35,
                                                             YES, ccBLACK)
                                        target: self 
                                      selector: @selector(playRegular)];
        [playRegular setPosition: ccp(160, 160)];
        
        //Play Classic Mode Button
        CCMenuItem *playClassic =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"classic mode", CGSizeMake(320, 60), 35,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"classic mode", CGSizeMake(320, 60), 35,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playClassic)];
        [playClassic setPosition: ccp(160, 100)];
        
        //Play Burst Mode Button
        CCMenuItem *playBurst =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"burst mode", CGSizeMake(320, 60), 35,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"burst mode", CGSizeMake(320, 60), 35,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playBurst)];
        [playBurst setPosition: ccp(160, 40)];
                
        //Toggle Sound Button
        SoundON = [CCMenuItemImage itemFromNormalSprite: loadSprite(@"SoundON.png")
                                         selectedSprite: loadSprite(@"SoundON-selected.png")
                                                 target: nil
                                               selector: nil];
        
        SoundOFF = [CCMenuItemImage itemFromNormalSprite: loadSprite(@"SoundOFF.png")
                                          selectedSprite: loadSprite(@"SoundOFF-selected.png")
                                                  target: nil
                                                selector: nil];
        
        CCMenuItemToggle *toggleSoundButton =
        [CCMenuItemToggle itemWithTarget: self 
                                selector: @selector(toggleSound:)
                                   items: SoundON, SoundOFF, nil];
        [toggleSoundButton setPosition: ccp(229, screenSize.height - 183)];
        
        //Main Menu Button Collection
        mainMenu = [CCMenu menuWithItems: playRegular, playClassic, playBurst, toggleSoundButton, nil];
        [mainMenu setPosition: CGPointZero];
        if (![GameManager sharedGameManager].isMusicON) [toggleSoundButton setSelectedIndex: 1];
        [self addChild: mainMenu];
        
        static BOOL firstTime = YES;
        if (firstTime)
        {
            firstTime = NO;
            [mainMenu setOpacity: 0];
            id animation = [CCFadeIn actionWithDuration: 0.5];
            [mainMenu runAction: animation];
        }
    }
    
    return self;
}

-(void) playRegular
{
    [[GameManager sharedGameManager] setValue: @"mode" newString: @"RegularMode"];
    [self startGame];
}

-(void) playClassic
{
    [[GameManager sharedGameManager] setValue: @"mode" newString: @"ClassicMode"];
    [self startGame];
}

-(void) playBurst
{
    [[GameManager sharedGameManager] setValue: @"mode" newString: @"BurstMode"];
    [self startGame];
}

-(void) startGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) toggleSound: (id) sender
{
    CCMenuItemToggle *toggleItem = (CCMenuItemToggle *)sender;
    
    if (toggleItem.selectedItem == SoundON) 
    {
        [GameManager sharedGameManager].isMusicON = YES;
        [[GameManager sharedGameManager] setValue: @"isMusicON" newInt: 1];
    } 
    
    else if (toggleItem.selectedItem == SoundOFF) 
    {
        [GameManager sharedGameManager].isMusicON = NO;    
        [[GameManager sharedGameManager] setValue: @"isMusicON" newInt: 0];
    }
    
}
@end
