//
//  MainMenuScene.m
//  Nom
//
//  Created by Qian Zhang on 11-07-27.
//  Copyright 2011 Cisco. All rights reserved.
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
