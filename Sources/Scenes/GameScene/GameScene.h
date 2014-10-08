//
//  GameScene.h
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//	

#import "cocos2d.h"

@class GameBackgroundLayer;
@class LevelLayer;
@class GameplayLayer;

@interface GameScene : CCScene 
{
    GameBackgroundLayer *gameBackgroundLayer;
    LevelLayer *levelLayer;
    GameplayLayer *gameplayLayer;
}

@end