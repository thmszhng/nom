//
//  OptionsBackgroundLayer.m
//  Nom
//
//  Created by Thomas Zhang on 11-08-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "OptionsBackgroundLayer.h"
#import "GameManager.h"
#import "ScrollView.h"
#import "Game.h"
#import "Level.h"
#import "SpriteLoader.h"
#import "Render.h"
#import "RegularMode.h"
#import "ClassicMode.h"
#import "BurstMode.h"
#import "FeastMode.h"
#import "QuestMode.h"
#import "GardenMode.h"

@implementation OptionsBackgroundLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        CCSprite *bg = loadSprite(@"OptionsBackground.png");
        [bg setPosition: CGPointMake(screenSize.width/2, screenSize.height/2)];
        [self addChild: bg];
        
        const ccColor3B c_slow = ccc3(0, 52, 160);
        const ccColor3B c_medium = ccc3(70, 154, 6);
        const ccColor3B c_fast = ccc3(160, 0, 0);
        CGSize size = CGSizeMake(94, 36);
#define slow createButton(@"hard", size, 25.0f, NO, c_slow)
#define slowS createButton(@"hard", size, 25.0f, YES, c_slow)
#define medium createButton(@"harder", size, 25.0f, NO, c_medium)
#define mediumS createButton(@"harder", size, 25.0f, YES, c_medium)
#define fast createButton(@"crazy", size, 25.0f, NO, c_fast)
#define fastS createButton(@"crazy", size, 25.0f, YES, c_fast)
        slowButton = [CCMenuItemSprite itemFromNormalSprite: slow
                                             selectedSprite: slowS
                                             disabledSprite: slowS
                                                     target: self
                                                   selector: @selector(setSlow)];
        [slowButton setPosition: ccp(66, 118)];
        mediumButton = [CCMenuItemSprite itemFromNormalSprite: medium
                                               selectedSprite: mediumS
                                               disabledSprite: mediumS
                                                      target: self
                                                    selector: @selector(setMedium)];
        [mediumButton setPosition: ccp(160, 118)];
        fastButton = [CCMenuItemSprite itemFromNormalSprite: fast
                                             selectedSprite: fastS
                                             disabledSprite: fastS
                                                     target: self
                                                   selector: @selector(setFast)];
        [fastButton setPosition: ccp(254, 118)];
        
        CCMenuItemImage *playButton = [CCMenuItemSprite
                                       itemFromNormalSprite: createButton(@"Play Game",
                                                                          CGSizeMake(280, 70),
                                                                          40, NO, ccBLACK)
                                       selectedSprite: createButton(@"Play Game",
                                                                    CGSizeMake(280, 70),
                                                                    40, YES, ccBLACK)
                                       target: self
                                       selector: @selector(playGame)];
        [playButton setPosition: ccp(160, 55)];
        
        optionsMenu = [CCMenu menuWithItems: slowButton,
                       mediumButton, fastButton, playButton, nil];
        [optionsMenu setPosition: CGPointZero];
        [self addChild: optionsMenu];
        
        /*int num = 0;
        NSMutableDictionary *levelDictionary = [NSMutableDictionary new];
        for (id item in [GameManager sharedGameManager].levels)
        {
            num++;
            NSString *str = [NSString stringWithFormat: @"%d", num];
            [levelDictionary setObject: [str stringByAppendingString: @".png"] forKey: str];
            num++;

        }*/
        
        NSMutableDictionary *levelDictionary = [NSMutableDictionary dictionary];
        NSArray *levels = [GameManager sharedGameManager].levels;
        for (NSUInteger i = 0; i < [levels count]; ++i)
        {
            CCSprite *texture = [(Level*)[levels objectAtIndex: i] drawWithSize: 4];
            [levelDictionary setObject: texture forKey: [NSNumber numberWithUnsignedInt: i]];
        }
        levelView = [[ScrollView alloc] initWithDictionary: levelDictionary];
        levelView.initialPage = [NSNumber numberWithInt: [GameManager sharedGameManager].levelIndex];
        levelView.position = CGPointMake(20, 307);
        [self addChild: levelView];

        NSMutableDictionary *modeDictionary = [NSMutableDictionary dictionary];
        NSArray *gameModes = [NSArray arrayWithObjects: [RegularMode class],
                              [ClassicMode class], [BurstMode class],
                              [FeastMode class], [QuestMode class],
                              [GardenMode class], nil];
        for (Class cls in gameModes)
        {
            NSString *str = NSStringFromClass(cls);
            [modeDictionary setObject: [str stringByAppendingString: @".png"] forKey: str];
        }
        gameModeView = [[ScrollView alloc] initWithDictionary: modeDictionary];
        gameModeView.initialPage = [[GameManager sharedGameManager] getString: @"mode" withDefault: @"RegularMode"];
        gameModeView.position = CGPointMake(20, 145);
        [self addChild: gameModeView];
        
        int speed = [[GameManager sharedGameManager] getInt: @"speed" withDefault: 350];
        if (speed == 150)
            [self setFast];
        else if (speed == 250)
            [self setMedium];
        else
            [self setSlow];
    }
    
    return self;
}

-(void) setSlow
{
    [slowButton setIsEnabled: NO];
    [mediumButton setIsEnabled: YES];
    [fastButton setIsEnabled: YES];
    [[GameManager sharedGameManager] setValue: @"speed" newInt: 350];
}
-(void) setMedium
{
    [slowButton setIsEnabled: YES];
    [mediumButton setIsEnabled: NO];
    [fastButton setIsEnabled: YES];
    [[GameManager sharedGameManager] setValue: @"speed" newInt: 250];
}
-(void) setFast
{
    [slowButton setIsEnabled: YES];
    [mediumButton setIsEnabled: YES];
    [fastButton setIsEnabled: NO];
    [[GameManager sharedGameManager] setValue: @"speed" newInt: 150];
}

-(void) playGame
{
    [[GameManager sharedGameManager] setValue: @"mode" newString: [gameModeView selected]];
    [GameManager sharedGameManager].levelIndex = [[levelView selected] intValue];
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}
@end
