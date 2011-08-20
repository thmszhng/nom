//
//  ClassicMode.m
//  Nom
//
//  Created on 11-08-20.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "ClassicMode.h"
#import "RegularFood.h"

@implementation ClassicMode

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        [self createFood: [RegularFood class]];
    }
    return self;
}

-(void) onEat
{
    [self createFood: [RegularFood class]];
}

@end