//
//  GridObject.h
//  Nom
//
//  Created on 11-09-05.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vector;
@class Game;

@interface GridObject: NSObject {
    Vector *pos;
    GridObject *next;
}
@property (readwrite, retain) Vector *pos;
@property (readwrite, retain) GridObject *next;

-(id) initAt: (Vector *) where;
-(void) dealloc;

// returns whether or not the snake will survive (abstract method)
-(BOOL) eat: (Game *) game;

// checks all objects on this square
-(BOOL) eatRecursively: (Game *) game;

@end
