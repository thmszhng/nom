//
//  Food.m
//  Nom
//
//  Created by Qian Zhang on 11-07-26.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Vector.h"

@implementation Vector
-(void) setX: (int) n
{
    _x = n;
}

-(void) setY: (int) n
{
    _y = n;
}

-(int) x
{
    return _x;
}

-(int) y
{
    return _y;
}

@end
