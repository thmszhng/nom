//
//  RegularMode.m
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "RegularMode.h"

#import "RegularFood.h"
#import "FoodRandomizer.h"

@implementation RegularMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        [self createFood: [RegularFood class]];
    }
    return self;
}

-(void) onEat: (Food *) eaten
{
    if ([eaten isKindOfClass: [RegularFood class]])
    {
        [self createFood: [RegularFood class]];
        if (random() % 4 == 0)
        {
            [self createFood: [FoodRandomizer randomFoodExcept: [RegularFood class]]];
        }
    }
}

@end