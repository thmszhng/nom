//
//  Game.h
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Vector.h"
#import "Food.h"
#import "cocos2d.h"

enum Direction {NoDirection = -1, up = 0, down, left, right};

@class GridObject;
@class SnakeTail;

@interface Game: NSObject
{
    // game status
    int score;
    ccTime speed;
    int steps;
    ccTime timestamp;
    
    // snake
    enum Direction currentDirection;
    SnakeTail *head, *tail;
    int snakeLength;
    int deltaLength;
    BOOL isProtected, wasInWall;
    
    // food
    NSMutableSet *food;

    GridObject *grid[30][30];
}

@property (readonly, assign) int steps;
@property (readonly, assign) ccTime timestamp;
@property (readwrite, assign) int score;

@property (readwrite, assign) enum Direction currentDirection;
@property (readwrite, retain) SnakeTail *head, *tail;
@property (readwrite, assign) ccTime speed;
@property (readwrite, assign) int deltaLength;
@property (readwrite, assign) BOOL isProtected, wasInWall;

@property (readonly) int snakeLength;
@property (readwrite, retain) NSMutableSet *food;

-(id) init;
-(void) dealloc;

// related to moving the snake
-(BOOL) moveSnake; // returns NO if lost game
-(BOOL) headChecks: (Vector *) head; // returns NO if lost game

// grid
-(void) addObject: (GridObject *) object;
-(void) removeObject: (GridObject *) object;

// food
-(void) onEat: (Food *) food; // to be overriden
-(void) removeFood: (Food *) food;
-(void) createFood: (Class) foodType;
-(void) createFood: (Class) foodType at: (Vector *) where;
-(void) rampSpeedBy: (float) amt;

-(Vector *) findSpace;
-(Vector *) findSpaceNear: (Vector *) where;

// information
-(Vector *) beginSpace;

@end
