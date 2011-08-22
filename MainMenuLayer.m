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
        CCSprite *bg = [CCSprite spriteWithFile: @"MainMenuBackground.png"];
        [bg setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
        
        //Menu items
        CCMenuItemImage *playButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"PlayGame.png" 
                                       selectedImage: @"PlayGame.png" 
                                       disabledImage: @"PlayGame.png"  
                                       target: self 
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(screenSize.width/2, screenSize.height/2 - 45)];
        
        CCMenuItemImage *levelEditorButton = [CCMenuItemImage 
                                              itemFromNormalImage: @"LevelEditor.png" 
                                              selectedImage: @"LevelEditor.png" 
                                              disabledImage: @"LevelEditor.png"  
                                              target: self 
                                              selector: @selector(openLevelEditor)];
        [levelEditorButton setPosition: ccp(screenSize.width/2, screenSize.height/2 - 75)];
        
        CCMenuItemImage *gameCenterButton = [CCMenuItemImage
                                             itemFromNormalImage: @"Gamecenter.png"
                                             selectedImage: @"Gamecenter.png"
                                             disabledImage: nil
                                             target: self
                                             selector: @selector(openGameCenter)];
        [gameCenterButton setPosition: ccp(screenSize.width/2, screenSize.height/2 - 105)];
        
        CCMenuItemImage *helpButton = [CCMenuItemImage 
                                       itemFromNormalImage: @"Help.png" 
                                       selectedImage: @"Help.png" 
                                       disabledImage: @"Help.png"  
                                       target: self 
                                       selector: @selector(showHelp)];
        [helpButton setPosition: ccp(screenSize.width/2, screenSize.height/2 - 135)];
        
        CCMenuItemImage *toggleMusicButton = [CCMenuItemImage 
                                              itemFromNormalImage: @"ToggleMusic.png" 
                                              selectedImage: @"ToggleMusic.png" 
                                              disabledImage: @"ToggleMusic.png"  
                                              target: self 
                                              selector: @selector(toggleMusic)];
        [toggleMusicButton setPosition: ccp(screenSize.width/2, screenSize.height/2 - 165)];
        
        mainMenu = [CCMenu menuWithItems: playButton, levelEditorButton, gameCenterButton, helpButton, toggleMusicButton, nil];
        [mainMenu setPosition: CGPointZero];
        [self addChild: mainMenu];
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

-(void) toggleMusic
{
    [GameManager sharedGameManager].isMusicON = NO;
}
@end
