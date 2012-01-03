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
        isHelpShowing = NO;
        
        //enable touches
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //background
        CCSprite *bg = loadSprite(@"Frame.png");
        [bg setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
        
        //Play Regular Mode Button
        CCMenuItem *playRegular =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"regular mode", CGSizeMake(320, 60), 45,
                                                             NO, ccBLACK)
                                selectedSprite: createButton(@"regular mode", CGSizeMake(320, 60), 45,
                                                             YES, ccBLACK)
                                        target: self 
                                      selector: @selector(playRegular)];
        [playRegular setPosition: ccp(160, 260)];
        
        //Play Classic Mode Button
        CCMenuItem *playClassic =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"classic mode", CGSizeMake(320, 60), 45,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"classic mode", CGSizeMake(320, 60), 45,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playClassic)];
        [playClassic setPosition: ccp(160, 190)];
        
        //Play Burst Mode Button
        CCMenuItem *playBurst =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"burst mode", CGSizeMake(320, 60), 45,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"burst mode", CGSizeMake(320, 60), 45,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playBurst)];
        [playBurst setPosition: ccp(160, 120)];
        
        //Show Help Button
        CCMenuItemImage *helpButton = 
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"help", CGSizeMake(320, 60), 45,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"help", CGSizeMake(320, 60), 45,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(showHelp)];
        [helpButton setPosition: ccp(160, 50)];
        
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
        mainMenu = [CCMenu menuWithItems: playRegular, playClassic, playBurst, helpButton, toggleSoundButton, nil];
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
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) playClassic
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) playBurst
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) showHelp
{
    if(isHelpShowing) return;
    
    HelpLayer * hl = [[[HelpLayer alloc] init] autorelease];
    [self.parent addChild: hl z: 10 tag: kHelpLayer];
    CGPoint pos = hl.position;
    id animation = [CCEaseBackOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: pos]];
    pos.y += 480;
    hl.position = pos;
    [hl runAction: animation];
    
    [self onExit];
}

-(void) onEnter
{
    isHelpShowing = NO;
    [super onEnter];
}

-(void) onExit
{
    isHelpShowing = YES;
    [super onExit];
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
