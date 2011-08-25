//
//  GameOptionsScene.m
//  Nom
//
//  Created by Thomas Zhang on 11-08-16.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "OptionsScene.h"


@implementation OptionsScene

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Background Layer
        optionsBackgroundLayer = [OptionsBackgroundLayer node];
        [self addChild: optionsBackgroundLayer z: 0 tag: kOptionsBackgroundLayer];

    }
    
    return self;
}

@end
