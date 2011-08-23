//
//  GameScene.h
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//	

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameBackgroundLayer.h"
#import "GameplayLayer.h"
#import "PauseLayer.h"

@interface GameScene : CCScene 
{
    GameBackgroundLayer *gameBackgroundLayer;
    GameplayLayer *gameplayLayer;
}

-(void) mainMenu;

@end