//
//  BurstFood.m
//  Nom
//
//  Created on 11-08-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "BurstFood.h"

#import "Game.h"
#import "RegularFood.h"
#import "TimeBonusFood.h"

Class randomFood()
{
    Class FoodTypes[] =
    {
        [RegularFood class],
        [TimeBonusFood class]
    };
    return FoodTypes[random() % 2];
}

@implementation BurstFood

-(void) eat: (Game *) game
{
    for (int i = 5; i--; )
    {
        [game createFood: randomFood() at: [game findSpaceNear: self.pos]];
    }
}

-(ccColor3B) color
{
    return ccc3(0, 255, 0);
}

@end