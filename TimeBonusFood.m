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
        _game = game;
    }
    return self;
}

-(void) eat: (Game *) game
{
    // variable advancement
    float boost = ceilf(30.f * powf(1.03f, timeAtCreation - game.timestamp));
    if (boost < 5.f) boost = 5.f;
    game.score += boost;
    // speed ramp
    [game rampSpeedBy: 1.f];
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
