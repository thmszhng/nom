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

-(void) dealloc
{
    [pos release];
    [super dealloc];
}

-(void) eat: (Game *) game
{
}

@end