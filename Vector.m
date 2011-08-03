//
//  Food.m
//  Nom
//
//  Created by Qian Zhang on 11-07-26.
//  Copyright 2011 Cisco. All rights reserved.
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
