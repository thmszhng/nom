//
//  FeastMode.m
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "FeastMode.h"
#import "FoodRandomizer.h"
#import "BurstFood.h"

@implementation FeastMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        for (int i = 5; i--; )
        {
            [self createFood: [FoodRandomizer randomFoodExcept:[BurstFood class], nil]];
        }    
    }
    return self;
}

-(void) onEat: (Food *) eaten
{
    if ([food count] <= 5) {
        [self createFood: [FoodRandomizer randomFoodExcept:[BurstFood class], nil]];
    }
}

@end