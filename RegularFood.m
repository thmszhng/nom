//
//  RegularFood.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "RegularFood.h"

#import "Game.h"
#import "Vector.h"

#define SPEED_BOOST(x) (1./(1./(x)+0.25))
// #define SPEED_BOOST(x) ((x) * 0.95)
// #define SPEED_BOOST(x) powf(powf(x, -1./1.5)+0.1, -1.5)

@implementation RegularFood

-(void) eat: (Game *) game
{
    // adds a new snake piece to the end of the snake
    ++game.deltaLength;
    // advancement
    game.score += 10;
    // speed ramp
    game.speed = SPEED_BOOST(game.speed);
}

@end