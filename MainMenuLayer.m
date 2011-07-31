//
//  MainMenuLayer.m
//  Nom
//
//  Created by Qian Zhang on 11-07-27.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "MainMenuLayer.h"


@implementation MainMenuLayer
-(void) playGame
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

-(void) displayMainMenu
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if(sceneSelectMenu != nil)
    {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    //Main Menu
    CCMenuItemImage *playGameButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"PlayGameButtonNormal.png" 
                                       selectedImage: @"PlayGameButtonSelected.png" 
                                       disabledImage: nil 
                                       target: self
                                       selector: @selector(playGame)];
    
    
    
    mainMenu = [CCMenu menuWithItems: playGameButton, nil];
    [mainMenu alignItemsHorizontallyWithPadding: screenSize.width * 0.059f];
    [mainMenu setPosition: ccp(screenSize.width * 2, 10)];
    
    id moveAction = [CCMoveTo actionWithDuration: 1.2f position: ccp(screenSize.width/2, 10)];
    
    id moveEffect = [CCEaseIn actionWithAction: moveAction rate: 1.0f];
    
    [mainMenu runAction: moveEffect];
    
    [self addChild: mainMenu z: 0 tag: kMainMenuTagValue];
}

/*
-(void) displaySceneSelection
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if(mainMenu != nil)
    {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelTTF *playGameLabel = [CCLabelTTF labelWithString:@"Play Game!" fontName:@"Helvetica Neue" fontSize:20];
    CCMenuItemLabel *playGame = [CCMenuItemLabel itemWithLabel: playGameLabel target: self selector: @selector(playScene:)];
    
    CCLabelTTF *backButtonLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica Neue" fontSize:20];
    CCMenuItemLabel *backButton = [CCMenuItemLabel itemWithLabel: backButtonLabel target: self selector: @selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems: playGame, backButton, nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding: 0.059f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration: 0.5f position: ccp(screenSize.width *0.75f, screenSize.height/2)];
    
    id moveEffect = [CCEaseIn actionWithAction: moveAction rate: 1.0f];
    
    [sceneSelectMenu runAction: moveEffect];
    [self addChild: sceneSelectMenu z:1 tag: kSceneMenuTagValue];
}
*/

-(id) init
{
    self = [super init];
    
    if(self != nil)
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile: @"MainMenuBackground.png"];
        [background setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        
        [self addChild: background];
        [self displayMainMenu];
    }
    
    return self;
}
@end
