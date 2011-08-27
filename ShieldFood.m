//
//  ShieldFood.m
//  Nom
//
//  Created on 11-08-22.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "ShieldFood.h"

#import "Game.h"
#import "Vector.h"
#import "FoodRandomizer.h"


@implementation ShieldFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 1];
}

-(void) eat: (Game *) game
{
    // adds a new snake piece to the end of the snake
    game.isProtected=true;
}

-(ccColor3B) color
{
    return ccORANGE;
}

@end