//
//  GameplayLayer.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "GameplayLayer.h"
#import "Constants.h"
#import "Render.h"

#define INITIAL_SPEED (0.25)
#define SPEED_BOOST(x) (1./(1./(x)+0.25))
// #define SPEED_BOOST(x) ((x) * 0.95)
// #define SPEED_BOOST(x) powf(powf(x, -1./1.5)+0.1, -1.5)

@implementation GameplayLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //enable touches
        self.isTouchEnabled = YES;
        
        //initialize game
        accumulatedTime = 0;
        speed = INITIAL_SPEED;
        gameOver = NO;
        snakeLength = 4;
        
        //initialize snake
        [self initNewSnakeSection: 0: 3: 29: right];
        [self initNewSnakeSection: 1: 2: 29: right];
        [self initNewSnakeSection: 2: 1: 29: right];
        [self initNewSnakeSection: 3: 0: 29: right];
        newDirection = right;
        
        //initialize food
        food = [[Vector alloc] init];
        [self moveFood];
    }
    
    [self scheduleUpdate];
    
    return self;
}

//updates the game, 60Hz
-(void) update: (ccTime) deltaTime
{
    if (gameOver == NO)
    {
        accumulatedTime += deltaTime;
        while (accumulatedTime > speed)
        {
            accumulatedTime -= speed;
            
            [snakePiece[0] setDirection: newDirection];

            for (int i = 0; i < snakeLength; i++)
            {
                [self freeCurrentSpot: i];
                [snakePiece[i] move];
                
                //only applies to the head segment
                if (i == 0)
                {
                    [self headChecks];
                }
                
                [self occupyNewSpot: i];
            }
            
            //turns the snake
            [self turnSnake];
        }
    }
    else
    {
        [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
    }
}

//adds a new section to the snake
-(void) initNewSnakeSection: (int) n: (int) x: (int) y: (enum Direction) direction;
{
    snakePiece[n] = [[SnakeSegment alloc] init];
    [snakePiece[n] setX: x];
    [snakePiece[n] setY: y];
    [snakePiece[n] setDirection: direction];
}

-(void) moveFood
{
    int x, y;
    do {
        x = random() % 30;
        y = random() % 30;
    } while (gridInfo[x][y]);
    
    [food setX: x];
    [food setY: y];
}

//handles touches
-(void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event;
{
    CGPoint touchCoord;
	for (UITouch *touch in touches)
    {
		touchCoord = [[CCDirector sharedDirector] convertToGL: [touch locationInView: [touch view]]];
    }
    int x = touchCoord.x - 160;
    int y = touchCoord.y - 85;
    trackTouch = (x*x + y*y < 16000);
    
    [self changeHeadDirection: touchCoord];
}
 
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchCoord;
	for (UITouch *touch in touches)
    {
		touchCoord = [[CCDirector sharedDirector] convertToGL: [touch locationInView: [touch view]]];
    }
    
    [self changeHeadDirection: touchCoord];
}

//determines direction in which snake head should move based on touch input
-(void) changeHeadDirection: (CGPoint) touchCoord
{
    if (!trackTouch) return;
    
    enum Direction currentDirection = [snakePiece[0] reportDirection];
    
    int x = touchCoord.x - 160;
    int y = touchCoord.y - 85;
    
    if (x*x + y*y < 100) return;
    
    if (y > x)
    {
        if (y > -x)
        {
            if (currentDirection != down)
            {
                newDirection = up;
            }
        }
        else
        {
            if (currentDirection != right)
            {
                newDirection = left;
            }
        }
    }
    else
    {
        if (y < -x)
        {
            if (currentDirection != up)
            {
                newDirection = down;
            }
        }
        else
        {
            if (currentDirection != left)
            {
                newDirection = right;
            }
        }
    }
}

//sets the last space the snake segment was in to "unoccupied"
-(void) freeCurrentSpot: (int) n
{
    gridInfo[[snakePiece[n] reportX]][[snakePiece[n] reportY]] = 0;
}

//sets the space the snake segment is going to move into to "occupied"
-(void) occupyNewSpot: (int) n
{
    gridInfo[[snakePiece[n] reportX]][[snakePiece[n] reportY]] = 1;
}

//makes sure the snake turns
-(void) turnSnake
{
    int n;
    
    for (n = (snakeLength - 1); n >= 1; n--)
    {
        if ([snakePiece[n] reportDirection] != [snakePiece[n - 1] reportDirection])
        {
            [snakePiece[n] setDirection: [snakePiece[n - 1] reportDirection]];
        }
    }
}

//checks lose condition and if snake head has hit food
-(void) headChecks
{    
    //check if the snake head hit itself
    int currentX = [snakePiece[0] reportX];
    int currentY = [snakePiece[0] reportY];

    if (gridInfo[currentX][currentY] == 1)
    {
        gameOver = YES;
    }
    
    //check if the snake head found some food
    if (currentX == [food x] && currentY == [food y])
    {
        //adds a new snake piece to the end of the snake
        switch ([snakePiece[snakeLength - 1] reportDirection]) 
        {
            case up:
                [self initNewSnakeSection: (snakeLength): [snakePiece[snakeLength - 1] reportX] :([snakePiece[snakeLength - 1] reportY] - 1): up];
                break;
                
            case down:
                [self initNewSnakeSection: (snakeLength): [snakePiece[snakeLength - 1] reportX] :([snakePiece[snakeLength - 1] reportY] + 1): down];
                break;
                
            case left:
                [self initNewSnakeSection: (snakeLength): ([snakePiece[snakeLength - 1] reportX] + 1) :[snakePiece[snakeLength - 1] reportY]: left];
                break;
                
            case right:
                [self initNewSnakeSection: (snakeLength): ([snakePiece[snakeLength - 1] reportX] - 1) :[snakePiece[snakeLength - 1] reportY]: right];
                break;
        }
        
        snakeLength++;
        speed = SPEED_BOOST(speed);
        
        //spawns a new food
        [self moveFood];
    }
}

-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    drawBox([food x] * 10 + 10, [food y] * 10 + 170, 10, 10, 255, 0, 0, 255);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    enum Direction lastdir = -1;
    for (int i = snakeLength; i--; )
    {
        int x = [snakePiece[i] reportX];
        int y = [snakePiece[i] reportY];
        int dir = [snakePiece[i] reportDirection];
        if (i == 0) dir = -1;
        drawSnake(x, y, dir == up || lastdir == down, dir == left || lastdir == right, dir == down || lastdir == up, dir == right || lastdir == left);
        lastdir = dir;
    }
}
@end