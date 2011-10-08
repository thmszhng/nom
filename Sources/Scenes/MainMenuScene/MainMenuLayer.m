//
//  MainMenuLayer.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuLayer.h"

#import "GameManager.h"
#import "GameCenter.h"
#import <GameKit/GameKit.h>

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
        CCSprite *bg = [CCSprite spriteWithFile: @"Frame.png"];
        [bg setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
        
        //Menu items
        CCMenuItemImage *playButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"Play.png" 
                                       selectedImage: @"Play-selected.png" 
                                       disabledImage: @"Play.png"  
                                       target: self 
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(screenSize.width/2, screenSize.height - 273)];
        
        CCMenuItemImage *optionsButton = [CCMenuItemImage 
                                              itemFromNormalImage: @"GameOptions.png" 
                                              selectedImage: @"GameOptions-selected.png"
                                              disabledImage: @"GameOptions.png"
                                              target: self 
                                              selector: @selector(openOptions)];
        [optionsButton setPosition: ccp(screenSize.width/2, screenSize.height - 371)];
        
        CCMenuItemImage *gameCenterButton = [CCMenuItemImage
                                             itemFromNormalImage: @"Gamecenter.png"
                                             selectedImage: @"Gamecenter-selected.png"
                                             disabledImage: nil
                                             target: self
                                             selector: @selector(openGameCenter)];
        [gameCenterButton setPosition: ccp(89, screenSize.height - 183)];
        
        CCMenuItemImage *helpButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"Help.png" 
                                       selectedImage: @"Help-selected.png" 
                                       disabledImage: @"Help.png"  
                                       target: self 
                                       selector: @selector(showHelp)];
        [helpButton setPosition: ccp(157, screenSize.height - 183)];
        
        SoundON = [[CCMenuItemImage itemFromNormalImage:@"SoundON.png" 
                                            selectedImage:@"SoundON-selected.png" target:nil selector:nil] retain];
        
        SoundOFF = [[CCMenuItemImage itemFromNormalImage:@"SoundOFF.png" 
                                             selectedImage:@"SoundOFF-selected.png" target:nil selector:nil] retain];
        
        CCMenuItemToggle *toggleSoundButton = [CCMenuItemToggle itemWithTarget:self 
                                                        selector:@selector(toggleSound:) items:SoundON, SoundOFF, nil];
        [toggleSoundButton setPosition: ccp(229, screenSize.height - 183)];

        mainMenu = [CCMenu menuWithItems: playButton, optionsButton, gameCenterButton, helpButton, toggleSoundButton, nil];
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

-(void) playGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) openOptions
{
    [[GameManager sharedGameManager] runSceneWithID: kOptionsScene];
}

-(void) openGameCenter
{
    if (!isGameCenterAPIAvailable())
    {
        NSLog(@"No Game Center!");
        return;
    }
    // TODO: create a game center scene
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
        vc = [[UIViewController alloc] init];
        [[[CCDirector sharedDirector] openGLView] addSubview: vc.view];
        [vc presentModalViewController: leaderboardController animated: YES];
    }
}

-(void) leaderboardViewControllerDidFinish: (GKLeaderboardViewController *) viewController {
    [vc dismissModalViewControllerAnimated: YES];
    [vc.view removeFromSuperview];
    [viewController autorelease];
    [vc autorelease];
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
