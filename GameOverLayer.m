//
//  GameOverLayer.m
//  Nom
//
//  Created by Xamigo on 11-08-23.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameplayLayer.h"

@implementation GameOverLayer

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        CCSprite *paused = [CCSprite spriteWithFile: @"GameOverBackground.png"];
        [paused setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: paused];
        
        //Menu items
        CCMenuItemImage *newGameButton = [CCMenuItemImage 
                                         itemFromNormalImage: @"GameOverNewGame.png" 
                                         selectedImage: @"GameOverNewGame.png" 
                                         disabledImage: @"GameOverNewGame.png"  
                                         target: self 
                                         selector: @selector(newGame)];
        [newGameButton setPosition: ccp(screenSize.width/2, 180)];
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage 
                                           itemFromNormalImage: @"PauseMenuMainMenu.png" 
                                           selectedImage: @"PauseMenuMainMenu.png"
                                           disabledImage: @"PauseMenuMainMenu.png"
                                           target: self 
                                           selector: @selector(goToMainMenu)];
        [mainMenuButton setPosition: ccp(screenSize.width/2, 75)];
        
        menu = [CCMenu menuWithItems: newGameButton, mainMenuButton, nil];
        [menu setPosition: CGPointZero];
        [self addChild: menu];
    }
    
    return self;
}

-(void) newGame
{
    CGPoint pos = self.position;
    pos.y += 480;
    [self runAction:
     [CCSequence actions:
      [CCEaseBackOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: pos]],
      [CCCallFunc actionWithTarget: self selector: @selector(finishRestart)],
      nil]
     ];
    GameplayLayer *gl = (GameplayLayer *) [self.parent getChildByTag: kGameplayLayer];
    [gl newGame];
}

-(void) finishRestart
{
    [self.parent removeChild: self cleanup: YES];
}

// unpauses game when screen is tapped
-(void) goToMainMenu
{
    [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
}

@end
