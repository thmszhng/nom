//
//  SlaveFood.m
//  Nom
//
//  Created by Thomas Zhang on 11-09-12.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "SlaveFood.h"

#import "Game.h"
#import "FoodRandomizer.h"
#import <math.h>

@implementation SlaveFood

-(id) initWithGame: (Game *) game
{
    self = [super initWithGame: game];
    if (self != nil)
    {
        timeAtCreation = game.timestamp;
        _game = game;
    }
    return self;
}

-(BOOL) eat: (Game *) game
{
    //increase snake length
    ++game.deltaLength;
    // variable advancement
    float boost = ceilf(30.f * powf(1.15f, timeAtCreation - game.timestamp));
    if (boost < 5.f) return NO; // is a rock
    game.score += boost;
    // speed ramp
    [game rampSpeedBy: 1.f];
    return YES;
}

-(ccColor3B) color
{
    if (timeAtCreation - _game.timestamp < -68.1659f) // 4 points
        return ccc3(0, 0, 0);
    if (timeAtCreation - _game.timestamp < -40.7314f) // 9 points
        return ccc3(0, 0, 150);
    if (timeAtCreation - _game.timestamp < -15.4525f) // 19 points
        return ccc3(0, 0, 200);
    return ccBLUE;
}

@end
