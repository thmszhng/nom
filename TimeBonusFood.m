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

@implementation TimeBonusFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 3];
}

-(id) initWithGame: (Game *) game
{
    self = [super initWithGame: game];
    if (self != nil)
    {
        stepsOnCreation = game.steps;
    }
    return self;
}

-(void) eat: (Game *) game
{
    // variable advancement
    game.score += 30 * powf(1.02f, stepsOnCreation - game.steps);
    // speed ramp
    game.speed = 1./(1./(game.speed)+0.4);
}

-(ccColor3B) color
{
    return ccBLUE;
}
@end