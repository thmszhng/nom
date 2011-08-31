//
//  TimeBonusFood.m
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "TimeBonusFood.h"

#import "Game.h"
#import "FoodRandomizer.h"
#import <math.h>

@implementation TimeBonusFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 2];
}

-(id) initWithGame: (Game *) game
{
    self = [super initWithGame: game];
    if (self != nil)
    {
        timeAtCreation = game.timestamp;
    }
    return self;
}

-(void) eat: (Game *) game
{
    // variable advancement
    float boost = ceilf(30.f * powf(1.02f, timeAtCreation - game.timestamp));
    if (boost < 5.f) boost = 5.f;
    game.score += boost;
    // speed ramp
    [game rampSpeedBy: 1.f];
}

-(ccColor3B) color
{
    return ccBLUE;
}

@end
