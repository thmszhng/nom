//
//  Food.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Food.h"

@implementation Food

@synthesize pos;

-(id) init
{
    if (self = [super init])
    {
        pos = nil;
    }
    return self;
}

-(void) dealloc
{
    [pos release];
    [super dealloc];
}

-(void) eat: (Game *) game
{
}

@end