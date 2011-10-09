//
//  PauseLayer.m
//  Nom
//
//  Created by Xamigo on 11-08-06.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "PauseLayer.h"
#import "GameplayLayer.h"
#import "SpriteLoader.h"
#import "Render.h"

@implementation PauseLayer

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
        
        CCSprite *paused = loadSprite(@"PauseMenuBackground.png");
        [paused setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: paused];
        
        //Menu items
        CCMenuItem *resumeButton =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"Resume", CGSizeMake(240, 100),
                                                             50, NO, ccc3(128, 128, 128))
                                selectedSprite: createButton(@"Resume", CGSizeMake(240, 100),
                                                             50, YES, ccc3(128, 128, 128))
                                        target: self
                                      selector: @selector(resumeGame)];
        [resumeButton setPosition: ccp(screenSize.width/2, 180)];
        
        CCMenuItem *mainMenuButton =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"Main Menu", CGSizeMake(240, 50),
                                                             40, NO, ccc3(128, 128, 128))
                                selectedSprite: createButton(@"Main Menu", CGSizeMake(240, 50),
                                                             40, YES, ccc3(128, 128, 128))
                                        target: self
                                      selector: @selector(goToMainMenu)];
        [mainMenuButton setPosition: ccp(screenSize.width/2, 75)];
       
        pauseMenu = [CCMenu menuWithItems: resumeButton, mainMenuButton, nil];
        [pauseMenu setPosition: CGPointZero];
        [self addChild: pauseMenu];
    }
    
    return self;
}

-(void) resumeGame
{
    CGPoint pos = self.position;
    pos.y += 480;
    [self runAction:
     [CCSequence actions:
      [CCEaseBackOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: pos]],
      [CCCallFunc actionWithTarget: self selector: @selector(finishResume)],
      nil]
     ];
    [[CCDirector sharedDirector] setAnimationInterval: 1/60.f];
}

-(void) finishResume
{
    GameplayLayer *gl = (GameplayLayer *) [self.parent getChildByTag: kGameplayLayer];
    [self.parent removeChild: self cleanup: YES];
    [gl onEnter];
}

// unpauses game when screen is tapped
-(void) goToMainMenu
{
    [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
}

@end
