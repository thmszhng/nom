//
//  Game.h
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Vector.h"
#import "cocos2d.h"

enum Direction {NoDirection = -1, up = 0, down, left, right};

@interface Game: NSObject
{
    // snake
    int deltaLength;
    Vector* snakePiece[900];

    int gridInfo[30][30];
}

@property (readwrite, assign) int score;
@property (readwrite, assign) enum Direction currentDirection;
@property (readwrite, assign) ccTime speed;
@property (readwrite, assign) int snakeLength;
@property (readwrite, assign) Vector* food;

-(id) init;
-(void) dealloc;

// related to moving the snake
-(BOOL) moveSnake; // returns NO if lost game
-(BOOL) headChecks: (Vector *) head; // returns NO if lost game

// grid
-(void) setSpot: (Vector *) pos withValue: (int) n;

-(void) moveFood;

// information
-(Vector *) getSnakePiece: (int) index;

@end