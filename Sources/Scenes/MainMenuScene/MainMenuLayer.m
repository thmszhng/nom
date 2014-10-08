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

CCMenuItem *createPlayButton(NSString *text, NSString *mode, id target, SEL selector)
{
    NSString *score = [NSString stringWithFormat: @"%i", [[GameManager sharedGameManager] getInt: [NSString stringWithFormat: @"%@Score", mode] withDefault: 0]];
    CCSprite *button = createMultiButton(text, CGSizeMake(320, 60), 30, NO, ccc3(61, 187, 56), score, 15);
    CCSprite *selected = createMultiButton(text, CGSizeMake(320, 60), 30, YES, ccc3(61, 187, 56), score, 15);
    return [CCMenuItemSprite itemFromNormalSprite: button
                            selectedSprite: selected
                                    target: target
                                  selector: selector];
}

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
        CCMenuItem *playRegular = createPlayButton(@"regular mode", @"RegularMode", self, @selector(playRegular));
        [playRegular setPosition: ccp(160, 190)];
        
        //Play Classic Mode Button
        CCMenuItem *playClassic = createPlayButton(@"classic mode", @"ClassicMode", self, @selector(playClassic));
        [playClassic setPosition: ccp(160, 120)];

        //Play Burst Mode Button
        CCMenuItem *playBurst = createPlayButton(@"burst mode", @"BurstMode", self, @selector(playBurst));
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
