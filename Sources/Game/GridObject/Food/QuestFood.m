//
//  TimeBonusFood.m
//  Nom
//
//  Created on 07-10-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "QuestFood.h"
#import "BurstFood.h"
#import "Game.h"
#import "FoodRandomizer.h"
#import <math.h>

@implementation QuestFood



-(BOOL) eat: (Game *) game
{
    for (int i = 3; i--; )
    {
        [game createFood: [FoodRandomizer randomFoodExcept:[BurstFood class], nil]];
    }

    return YES;
}

-(ccColor3B) color
{
    return ccORANGE;
}

@end
