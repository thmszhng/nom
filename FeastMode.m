//
//  FeastMode.m
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "FeastMode.h"
#import "FoodRandomizer.h"

@implementation FeastMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        for (int i = 10; i--; )
        {
            [self createFood: [FoodRandomizer randomFood]];
        }    
    }
    return self;
}

-(void) onEat: (Food *) eaten
{
    if (foodAmount <= 10) {
        [self createFood: [FoodRandomizer randomFood]];
    }
}

@end