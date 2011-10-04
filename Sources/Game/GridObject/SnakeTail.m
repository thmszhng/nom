//
//  SnakeTail.m
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "SnakeTail.h"

@implementation SnakeTail
@synthesize forward;

-(id) copyWithZone: (NSZone *) zone
{
    SnakeTail *ret = [[SnakeTail allocWithZone: zone] initAt: pos];
    ret.next = self.next;
    return ret;
}

@end
