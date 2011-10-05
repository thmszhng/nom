//
//  MainMenuScene.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MainMenuLayer;
@class AnimationLayer;

@interface MainMenuScene : CCScene 
{
    MainMenuLayer *mainMenuLayer;
    AnimationLayer *animationLayer;
}

@end
