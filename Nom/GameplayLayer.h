//
//  GameplayLayer.h
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SnakeSegment.h"
#import "Vector.h"
#import "GameManager.h"
#import "Constants.h"

@interface GameplayLayer : CCLayer
{
    //snake
    id snakePiece[900];
    int snakeLength;
    
    //food
    Vector* food;
    
    //game variables
    CGPoint touchCoord;
    int actionFrame;
    
    BOOL gameOver;
    int gridInfo[30][30];
    
    //misc variables
    int i;
}

-(id) init;
-(void) update:(ccTime)deltaTime;
-(void) initNewSnakeSection: (int) n: (int) x: (int) y: (enum Direction) direction;
-(void) moveFood;

//handles touches
-(void) ccTouchesBegan: (NSSet *)touches withEvent:(UIEvent *)event;
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

//related to moving the snake
-(void) changeHeadDirection;
-(void) freeCurrentSpot: (int) n;
-(void) occupyNewSpot: (int) n;
-(void) turnSnake;

//related to winning and losing
-(void) headChecks;

-(void) draw;

@end
