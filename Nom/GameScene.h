//
//  GameScene.h
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "GameplayLayer.h"

@interface GameScene : CCScene 
{
    BackgroundLayer *backgroundLayer;
    GameplayLayer *gameplayLayer;
}

@end
