//
//  GridObject.m
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GridObject.h"

#import "Vector.h"

@implementation GridObject
@synthesize pos, next;

-(id) initAt: (Vector *) where
{
    self = [super init];
    if (self != nil)
    {
        pos = [where copy];
    }
    return self;
}

-(void) dealloc
{
    self.pos = nil;
    self.next = nil;
    [super dealloc];
}

-(BOOL) eat: (Game *) game
{
    [self doesNotRecognizeSelector: _cmd];
    return NO;
}

-(BOOL) eatRecursively: (Game *) game
{
    BOOL here = [self eat: game];
    BOOL there = !next || [next eatRecursively: game];
    return here && there;
}

@end
