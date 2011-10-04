//
//  RegularFood.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "RegularFood.h"

#import "Game.h"
#import "FoodRandomizer.h"

@implementation RegularFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 3];
}

-(BOOL) eat: (Game *) game
{
    // adds a new snake piece to the end of the snake
    ++game.deltaLength;
    // advancement
    game.score += 10;
    // speed ramp
    [game rampSpeedBy: 1.f];
    return YES;
}

-(ccColor3B) color
{
    return ccRED;
}

@end
