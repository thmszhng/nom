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
    float boost = ceilf(30.f * powf(1.1f, timeAtCreation - game.timestamp));
    if (boost < 5.f) return NO; // is a rock
    game.score += boost;
    // speed ramp
    [game rampSpeedBy: 1.f];
    return YES;
}

-(ccColor3B) color
{
    if (timeAtCreation - _game.timestamp < -21.140480741f) // 4 points
        return ccc3(0, 0, 0);
    if (timeAtCreation - _game.timestamp < -12.632153321f) // 9 points
        return ccc3(0, 0, 175);
    if (timeAtCreation - _game.timestamp < -4.792335965f) // 19 points
        return ccc3(0, 0, 225);
    return ccBLUE;
}

@end
