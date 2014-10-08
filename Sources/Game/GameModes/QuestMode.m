//
//  QuestMode.m
//  Nom
//
//  Created on 11-08-29.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "QuestMode.h"
#import "FoodRandomizer.h"
#import "GameplayLayer.h"
#import "Render.h"
#import "BurstFood.h"
#import "QuestFood.h"


@implementation QuestMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        for (int i = 3; i--; )
        {
            [self createFood: [FoodRandomizer randomFoodExcept:[BurstFood class], nil]];
        }
    }
    return self;
}

-(void) onEat: (Food *) eaten
{
    if ([food count] == 1) {
        [self createFood: [QuestFood class] at: [self beginSpace]];
    }
}


@end
