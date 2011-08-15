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
        
        CCSprite *nom = [CCSprite spriteWithFile: @"Nom.png"];
        [nom setPosition: ccp(screenSize.width/2, screenSize.height/2 + 5)];
        
        CCLabelTTF *startGameText = [CCLabelTTF labelWithString: @"TAP TO BEGIN!" fontName: @"HelveticaNeue" fontSize: 10];
        startGameText.color = ccc3(0, 0, 0);
        [startGameText setPosition: ccp(screenSize.width/2, screenSize.height/2 - 25)];
        
        [self addChild: nom];
        [self addChild: startGameText];
    }
    
    return self;
}

// starts the game when the user taps the screens
-(void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    [[GameManager sharedGameManager] runSceneWithID: kGameScene];
}

@end
