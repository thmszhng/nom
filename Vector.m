//
//  Food.m
//  Nom
//
//  Created on 11-07-26.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Vector.h"

@implementation Vector

-(id) initWithX: (int) newX withY: (int) newY
{
    x = newX;
    y = newY;
    return self;
}

@synthesize x;
@synthesize y;

@end
