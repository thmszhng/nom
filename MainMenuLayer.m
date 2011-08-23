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
                                       selectedImage: @"Play.png" 
                                       disabledImage: @"Play.png"  
                                       target: self 
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(163, screenSize.height - 273)];
        
        CCMenuItemImage *levelEditorButton = [CCMenuItemImage 
                                              itemFromNormalImage: @"LevelEditor.png" 
                                              selectedImage: @"LevelEditor.png" 
                                              disabledImage: @"LevelEditor.png"  
                                              target: self 
                                              selector: @selector(openLevelEditor)];
        [levelEditorButton setPosition: ccp(163, screenSize.height - 371)];
        
        CCMenuItemImage *gameCenterButton = [CCMenuItemImage
                                             itemFromNormalImage: @"Gamecenter.png"
                                             selectedImage: @"Gamecenter.png"
                                             disabledImage: nil
                                             target: self
                                             selector: @selector(openGameCenter)];
        [gameCenterButton setPosition: ccp(89, screenSize.height - 183)];
        
        CCMenuItemImage *helpButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"Help.png" 
                                       selectedImage: @"Help.png" 
                                       disabledImage: @"Help.png"  
                                       target: self 
                                       selector: @selector(showHelp)];
        [helpButton setPosition: ccp(157, screenSize.height - 183)];
        
        SoundON = [[CCMenuItemImage itemFromNormalImage:@"SoundON.png" 
                                            selectedImage:@"SoundON.png" target:nil selector:nil] retain];
        
        SoundOFF = [[CCMenuItemImage itemFromNormalImage:@"SoundOFF.png" 
                                             selectedImage:@"ButtonMinusSel.jpg" target:nil selector:nil] retain];
        
        CCMenuItemToggle *toggleSoundButton = [CCMenuItemToggle itemWithTarget:self 
                                                        selector:@selector(toggleSound:) items:SoundON, SoundOFF, nil];
        [toggleSoundButton setPosition: ccp(229, screenSize.height - 183)];

        mainMenu = [CCMenu menuWithItems: playButton, levelEditorButton, gameCenterButton, helpButton, toggleSoundButton, nil];
        [mainMenu setPosition: CGPointZero];
        
        [mainMenu setOpacity: 0];
        [self addChild: mainMenu];
        
        id animation = [CCFadeIn actionWithDuration: 0.5];
        [mainMenu runAction: animation];
    }
    
    return self;
}

-(void) playGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) openLevelEditor
{
    [[GameManager sharedGameManager] runSceneWithID: kLevelEditorScene];
}

-(void) openGameCenter
{
    NSLog(@"Gamecenter support is currently unavailable. BRB.");
}

-(void) showHelp
{
    [[GameManager sharedGameManager] runSceneWithID: kHelpScene];
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
