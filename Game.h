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

@interface Game: NSObject
{
    // game status
    int score;
    ccTime speed;
    int steps;
    ccTime timestamp;
    
    // snake
    enum Direction currentDirection;
    int snakeLength;
    int deltaLength;
    Vector *snakePiece[900];
    
    // food
    int foodAmount;
    Food *food[900];

    int gridInfo[30][30];
}

@property (readonly, assign) int steps;
@property (readonly, assign) ccTime timestamp;
@property (readwrite, assign) int score;

@property (readwrite, assign) enum Direction currentDirection;
@property (readwrite, assign) ccTime speed;
@property (readwrite, assign) int deltaLength;

@property (readonly) int snakeLength;
@property (readonly) int foodAmount;

-(id) init;
-(void) dealloc;

// related to moving the snake
-(BOOL) moveSnake; // returns NO if lost game
-(BOOL) headChecks: (Vector *) head; // returns NO if lost game

// grid
-(void) setSpot: (Vector *) pos withValue: (int) n;

// food
-(void) onEat: (Food *) food; // to be overriden
-(void) deleteFood: (int) index;
-(void) createFood: (Class) foodType;

// information
-(Vector *) getSnakePiece: (int) index;
-(Food *) getFood: (int) index;

@end