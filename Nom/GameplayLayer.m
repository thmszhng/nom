//
//  GameplayLayer.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "GameplayLayer.h"

//the game refreshes at (60/GAMESPEED) Hz

@implementation GameplayLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //enable touches
        self.isTouchEnabled = YES;
        
        //initialize game
        gameOver = NO;
        snakeLength = 4;
        
        //initialize snake
        [self initNewSnakeSection: 0: 45: 465: right];
        [self initNewSnakeSection: 1: 35: 465: right];
        [self initNewSnakeSection: 2: 25: 465: right];
        [self initNewSnakeSection: 3: 15: 465: right];
        
        //initialize food
        food = [[Food alloc] init];
        [self moveFood];
        [food render];
        [self addChild: food z:5 tag:kGameSceneTagValue];
    }
    
    [self scheduleUpdate];
    
    return self;
}

//updates the game, 60Hz
-(void) update:(ccTime)deltaTime
{
    if(gameOver == NO)
    {
        
        if(actionFrame == GAMESPEED)
        {
            for(i = 0; i <= (snakeLength - 1); i++)
            {
                [self freeCurrentSpot: i];
                [snakePiece[i] move];
                
                //only applies to the head segment
                if(i == 0)
                {
                    [self headChecks];
                }
                
                [self occupyNewSpot: i];
            }
            
            //turns the snake
            [self turnSnake];
            
            actionFrame = 1;
        }
        else
        {
            actionFrame++;
        }
    }
    else
    {
        [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
    }
}

//adds a new section to the snake
-(void) initNewSnakeSection: (int) n: (int) x: (int) y: (enum direction) direction;
{
    snakePiece[n] = [[SnakeSegment alloc] init];
    [snakePiece[n] setX: x];
    [snakePiece[n] setY: y];
    [snakePiece[n] setDirection: direction];
    [snakePiece[n] render];
    [self addChild: snakePiece[n] z:10 tag: kGameSceneTagValue];
}

-(void) moveFood
{
    srandom(time(NULL));
    
    int x = random() %30;
    int y = random() %30;
    int n;
    
    //ensures the food is not spawned in the same position as a snake piece
    for(n = 0; n <= snakeLength; n++)
    {
        while(x == (([snakePiece[n] reportX] - 15)/10))
        {
            x = random() %30;
        }
        
        while(y == (([snakePiece[n] reportY] - 175)/10))
        {
            y = random() %30;
        }
    }
    
    [food setX: (x*10 + 15)];
    [food setY: (y*10 + 175)];
    
    [food moveSprite];
}

//handles touches
-(void) ccTouchesBegan: (NSSet *)touches withEvent:(UIEvent *)event;
{
	for(UITouch *touch in touches)
    {
        touchCoord = [touch locationInView: [touch view]];
		touchCoord = [[CCDirector sharedDirector] convertToGL: touchCoord];
    }
    
    [self changeHeadDirection];
}
 
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in touches)
    {
        touchCoord = [touch locationInView: [touch view]];
		touchCoord = [[CCDirector sharedDirector] convertToGL: touchCoord];
    }
    
    [self changeHeadDirection];
}

//determines direction in which snake head should move based on touch input
-(void) changeHeadDirection
{
    enum direction currentDirection = [snakePiece[0] reportDirection];
    
    if (touchCoord.x > 130 && touchCoord.x < 190)
    {
        if(touchCoord.y > 110 && touchCoord.y < 130)
        {
            if(currentDirection != down)
            {
                [snakePiece[0] setDirection: up];
            }
        }
        if(touchCoord.y > 20 && touchCoord.y < 50)
        {
            if(currentDirection != up)
            {
                [snakePiece[0] setDirection: down];
            }
        }
    }
    if (touchCoord.x < 130)
    {
        if(touchCoord.y > 50 && touchCoord.y < 110)
        {
            if(currentDirection != right)
            {
                [snakePiece[0] setDirection: left];
            }
        }
    }
    if (touchCoord.x > 190)
    {
        if(touchCoord.y > 50 && touchCoord.y < 110)
        {
            if(currentDirection != left)
            {
                [snakePiece[0] setDirection: right];
            }
        }
    }
}

//sets the last space the snake segment was in to "unoccupied"
-(void) freeCurrentSpot: (int) n
{
    int currentX = ([snakePiece[n] reportX] - 15)/10;
    int currentY = ([snakePiece[n] reportY] - 175)/10;
    
    gridInfo[currentX][currentY] = 0;
}

//sets the space the snake segment is going to move into to "occupied"
-(void) occupyNewSpot: (int) n
{
    int currentX = ([snakePiece[n] reportX] - 15)/10;
    int currentY = ([snakePiece[n] reportY] - 175)/10;
    
    gridInfo[currentX][currentY] = 1;
}

//makes sure the snake turns
-(void) turnSnake
{
    int n;
    
    for(n = (snakeLength - 1); n >= 1; n--)
    {
        if([snakePiece[n] reportDirection] != [snakePiece[n - 1] reportDirection])
        {
            [snakePiece[n] setDirection: [snakePiece[n - 1] reportDirection]];
        }
    }
}

//checks lose condition and if snake head has hit food
-(void) headChecks
{    
    //check if the snake head hit itself
    int currentX = ([snakePiece[0] reportX] - 15)/10;
    int currentY = ([snakePiece[0] reportY] - 175)/10;

    if(gridInfo[currentX][currentY] == 1)
    {
        gameOver = YES;
    }
    
    //check if the snake head found some food
    if([snakePiece[0] reportX] == [food reportX])
    {
        if([snakePiece[0] reportY] == [food reportY])
        {
            //adds a new snake piece to the end of the snake
            switch ([snakePiece[snakeLength - 1] reportDirection]) 
            {
                case up:
                    [self initNewSnakeSection: (snakeLength): [snakePiece[snakeLength - 1] reportX] :([snakePiece[snakeLength - 1] reportY] - 10): up];
                    break;
                    
                case down:
                    [self initNewSnakeSection: (snakeLength): [snakePiece[snakeLength - 1] reportX] :([snakePiece[snakeLength - 1] reportY] + 10): down];
                    break;
                
                case left:
                    [self initNewSnakeSection: (snakeLength): ([snakePiece[snakeLength - 1] reportX] + 10) :[snakePiece[snakeLength - 1] reportY]: left];
                    break;
                
                case right:
                    [self initNewSnakeSection: (snakeLength): ([snakePiece[snakeLength - 1] reportX] - 10) :[snakePiece[snakeLength - 1] reportY]: right];
                    break;
            }
            
            snakeLength++;
            
            //spawns a new food
            [self moveFood];
            [food moveSprite];
        }
    }
}
@end