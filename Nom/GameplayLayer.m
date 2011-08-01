//
//  GameplayLayer.m
//  Snake
//
//  Created by Qian Zhang on 11-07-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "GameplayLayer.h"
#import "Constants.h"

void glDrawRect(GLfloat x, GLfloat y, GLfloat width, GLfloat height)
{
    GLfloat vertices[8] = {
        x, y,
        x + width, y,
        x + width, y + height,
        x, y + height
    };
    glVertexPointer(2, GL_FLOAT, 0, vertices);	
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

#define CLAMP(x, a, b) (((x)<(a))?(a):((x)>(b))?(b):(x))
//#define DARKEN(c) CLAMP(5*((int)(c))/4-128, 0, 255)
#define DARKEN(c) (((c)<=15)?0:((c)-15))

void drawBox(int x, int y, int width, int height, GLubyte r, GLubyte g, GLubyte b, GLubyte a)
{
    if (haveRetina)
    {
        x *= 2; y *= 2; width *= 2; height *= 2;
    }
    glColor4ub(255, 255, 255, a);
    glDrawRect(x + width - 1, y, 1, height);
    glDrawRect(x, y, width - 1, 1);
    glColor4ub(DARKEN(r), DARKEN(g), DARKEN(b), a);
    glDrawRect(x, y + height - 1, width-1, 1);
    glDrawRect(x, y+1, 1, height-2);
    glColor4ub(r, g, b, a);
    glDrawRect(x+1, y+1, width-2, height-2);
}

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
    trackTouch = (x*x + y*y < 4000);
    
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
    
/*    glColor4ub(255, 0, 0, 255);
    glDrawRect([food x], [food y], 10.f, 10.f);*/
    for (int x = 0; x < 30; ++x) {
        for (int y = 0; y < 30; ++y) {
            int xx = 10 + x*10, yy = 170 + y*10;
            if ([food x] == x && [food y] == y) {
                drawBox(xx, yy, 10, 10, 255, 0, 0, 255);
            } else if (gridInfo[x][y]) {
                drawBox(xx, yy, 10, 10, 60, 60, 60, 255);
            } else {
                drawBox(xx, yy, 10, 10, 240, 240, 240, 255);
            }
        }
    }
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
}
@end