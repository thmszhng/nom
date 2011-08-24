//
//  MainMenuLayer.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuLayer.h"


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
        
        CCMenuItemImage *gameOptionsButton = [CCMenuItemImage 
                                              itemFromNormalImage: @"GameOptions.png" 
                                              selectedImage: @"GameOptions-selected.png"
                                              disabledImage: @"GameOptions.png"
                                              target: self 
                                              selector: @selector(openGameOptions)];
        [gameOptionsButton setPosition: ccp(screenSize.width/2, screenSize.height - 371)];
        
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

        mainMenu = [CCMenu menuWithItems: playButton, gameOptionsButton, gameCenterButton, helpButton, toggleSoundButton, nil];
        [mainMenu setPosition: CGPointZero];
        
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

-(void) openGameOptions
{
    [[GameManager sharedGameManager] runSceneWithID: kGameOptionsScene];
}

-(void) openGameCenter
{
    NSLog(@"Gamecenter support is currently unavailable. BRB.");
}

-(void) showHelp
{
    NSLog(@"Go screw yourself. No help for you. BRB.");
}

-(void) toggleSound: (id) sender
{
    CCMenuItemToggle *toggleItem = (CCMenuItemToggle *)sender;
    
    if (toggleItem.selectedItem == SoundON) 
    {
        [GameManager sharedGameManager].isMusicON = NO;
    } 
    
    else if (toggleItem.selectedItem == SoundOFF) 
    {
        [GameManager sharedGameManager].isMusicON = YES;    
    }
}
@end
