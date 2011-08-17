//
//  Food.m
//  Nom
//
//  Created on 11-07-26.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Vector.h"

@implementation Vector

@synthesize x;
@synthesize y;

-(id) initWithX: (int) newX withY: (int) newY
{
    x = newX;
    y = newY;
    return self;
}

-(id) copyWithZone: (NSZone *) zone
{
    return [[Vector allocWithZone: zone] initWithX: x withY: y];
}

-(BOOL) isEqualTo: (Vector *) other
{
    return x == other.x && y == other.y;
}

@end
