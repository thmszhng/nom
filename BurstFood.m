//
//  BurstFood.m
//  Nom
//
//  Created on 11-08-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "BurstFood.h"

#import "Game.h"
#import "FoodRandomizer.h"

@implementation BurstFood

+(void) load
{
    [FoodRandomizer addFood: [self class] weight: 1];
}

-(void) eat: (Game *) game
{
    for (int i = 5; i--; )
    {
        [game createFood: [FoodRandomizer randomFoodExcept: [self class], Nil]
                      at: [game findSpaceNear: self.pos]];
    }
}

-(ccColor3B) color
{
    return ccGREEN;
}

@end
