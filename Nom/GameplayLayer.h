//
//  GameplayLayer.h
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Vector.h"
#import "GameManager.h"
#import "Constants.h"
#import "PauseLayer.h"

enum Direction {NoDirection = -1, up = 0, down, left, right};

@interface GameplayLayer : CCLayer
{
    // snake
    Vector* snakePiece[900];
    int snakeLength;
    int deltaLength;
    enum Direction currentDirection;
    
    // food
    Vector* food;
    
    // game variables
    int score;
    ccTime accumulatedTime;
    ccTime speed;
    CCLabelTTF *scoreText;
    enum Direction newDirection;

    int gridInfo[30][30];
    
    // controls
    BOOL trackTouch;
}

-(id) init;
-(void) dealloc;

-(void) pauseGame;
-(void) onExit;
-(void) onEnter;

-(void) update: (ccTime) deltaTime;
-(void) moveFood;

//handles touches
-(void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event;
-(void) ccTouchesMoved: (NSSet *) touches withEvent: (UIEvent *) event;

//related to moving the snake
-(void) changeHeadDirection: (CGPoint) point;
-(void) setSpot: (Vector *) pos withValue: (int) n;

//related to winning and losing
-(void) headChecks: (Vector *) head;

-(void) draw;

@end
