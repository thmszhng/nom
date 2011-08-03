//
//  MainMenuScene.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "MainMenuScene.h"


@implementation MainMenuScene
-(id) init
{
    self = [super init];
    
    if (self != nil)
    {
        mainMenuLayer = [MainMenuLayer node];
        [self addChild: mainMenuLayer];
    }
    
    return self;
}
@end
