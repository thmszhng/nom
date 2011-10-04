//
//  BurstMode.m
//  Nom
//
//  Created on 11-08-29.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "BurstMode.h"

#import "BurstFood.h"
#import "FoodRandomizer.h"

@implementation BurstMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        [self createFood: [BurstFood class]];
    }
    return self;
}

-(void) onEat: (Food *) eaten
{
    // trigger a new spawn if there is no burst food left
    for (Food *f in food)
    {
        if (f != eaten && [f isKindOfClass: [BurstFood class]]) return;
    }
    [self createFood: [BurstFood class]];
}

@end