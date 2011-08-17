//
//  Food.h
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/NSObject.h>

@class Game;
@class Vector;

@interface Food: NSObject
{
    Vector *pos;
}

@property (readwrite,retain) Vector *pos;

-(void) dealloc;
-(void) eat: (Game *) game;

@end