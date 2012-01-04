//
//  RageFood.m
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "RageFood.h"

#import "Game.h"
#import "FoodRandomizer.h"

@implementation RageFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 1];
}

-(BOOL) eat: (Game *) game
{
    [game setRageExpiry:([game timestamp]+15/2.f)];
    if (game.isRaged) 
        return YES;
    [game setIsRaged: true];
    [game setSpeed: [game speed]/1.666];
    return YES;
}

-(ccColor3B) color
{
    return ccMAGENTA;
}

@end
