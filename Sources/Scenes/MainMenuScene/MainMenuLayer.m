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
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"regular mode", CGSizeMake(320, 60), 30,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"regular mode", CGSizeMake(320, 60), 30,
                                                             YES, ccc3(61, 187, 56))
                                        target: self 
                                      selector: @selector(playRegular)];
        [playRegular setPosition: ccp(160, 190)];
        
        //Play Classic Mode Button
        CCMenuItem *playClassic =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"classic mode", CGSizeMake(320, 60), 30,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"classic mode", CGSizeMake(320, 60), 30,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playClassic)];
        [playClassic setPosition: ccp(160, 120)];
        
        //Play Burst Mode Button
        CCMenuItem *playBurst =
        [CCMenuItemSprite itemFromNormalSprite: createButton(@"burst mode", CGSizeMake(320, 60), 30,
                                                             NO, ccc3(61, 187, 56))
                                selectedSprite: createButton(@"burst mode", CGSizeMake(320, 60), 30,
                                                             YES, ccc3(61, 187, 56))    
                                        target: self 
                                      selector: @selector(playBurst)];
        [playBurst setPosition: ccp(160, 50)];

        //Main Menu Button Collection
        mainMenu = [CCMenu menuWithItems: playRegular, playClassic, playBurst, nil];
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
        
        //Display Regular Mode High Scores
        CCLabelTTF *regularScore =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", [[GameManager sharedGameManager] getInt: @"RegularModeScore" withDefault: 0]]
                    dimensions: CGSizeMake(90, 50) 
                    alignment: CCTextAlignmentRight
                    fontName:@"Varela Round" 
                    fontSize: 15];
        
        regularScore.color = ccc3(61, 187, 56);
        regularScore.anchorPoint = CGPointMake(1, 0);
        [regularScore setPosition: ccp(300, 165)];
        [self addChild: regularScore z: 100];
        
        //Display Classic Mode High Scores
        CCLabelTTF *classicScore =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", [[GameManager sharedGameManager] getInt: @"ClassicModeScore" withDefault: 0]]
                         dimensions: CGSizeMake(90, 50) 
                          alignment: CCTextAlignmentRight
                           fontName:@"Varela Round" 
                           fontSize: 15];
        
        classicScore.color = ccc3(61, 187, 56);
        classicScore.anchorPoint = CGPointMake(1, 0);
        [classicScore setPosition: ccp(300, 95)];
        [self addChild: classicScore z: 100];
        
        //Display Burst Mode High Scores
        CCLabelTTF *burstScore =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", [[GameManager sharedGameManager] getInt: @"BurstModeScore" withDefault: 0]]
                         dimensions: CGSizeMake(90, 50) 
                          alignment: CCTextAlignmentRight
                           fontName:@"Varela Round" 
                           fontSize: 15];
        
        burstScore.color = ccc3(61, 187, 56);
        burstScore.anchorPoint = CGPointMake(1, 0);
        [burstScore setPosition: ccp(300, 25)];
        [self addChild: burstScore z: 100];
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

@end
