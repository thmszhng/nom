//
//  Game.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Game.h"
#import "GameConstants.h"
#import "RegularFood.h"
// TODO: create a class to randomly generate food

static const int dirX[4] = {0, 0, -1, 1};
static const int dirY[4] = {1, -1, 0, 0};

void wrap(Vector *pos)
{
    while (pos.x < 0) pos.x += 30;
    while (pos.x >= 30) pos.x -= 30;
    while (pos.y < 0) pos.y += 30;
    while (pos.y >= 30) pos.y -= 30;
}

@implementation Game

@synthesize score;
@synthesize currentDirection;
@synthesize speed;
@synthesize deltaLength;
@synthesize snakeLength;
@synthesize foodAmount;

-(id) init
{
    self = [super init];
    if (self)
    {
        //initialize game
        speed = INITIAL_SPEED;
        
        //initialize snake
        snakePiece[0] = [[Vector alloc] initWithX: 15 withY: 15];
        [self setSpot: snakePiece[0] withValue: 1];
        snakeLength = 1;
        deltaLength = 3;
        currentDirection = NoDirection;
        
        //initialize food
        foodAmount = 0;
        [self createFood];
    }
    return self;
}

-(void) dealloc
{
    while (foodAmount--)
    {
        [food[foodAmount] release];
    }
    while (snakeLength--)
    {
        [snakePiece[snakeLength] release];
    }
    [super dealloc];
}

-(BOOL) moveSnake
{
    // keep last element, which will be removed from snakePiece
    Vector *tail = snakePiece[snakeLength - 1];
    
    // temporarily set a value to stop collisions
    [self setSpot: tail withValue: 3];
    
    // advance snake except head
    for (int i = snakeLength; --i; )
    {
        snakePiece[i] = snakePiece[i-1];
    }
    
    // don't allow hitting the tail
    [self setSpot: tail withValue: 0];
    
    // advance head
    Vector *head = [[Vector alloc] init];
    head.x = snakePiece[0].x + dirX[currentDirection];
    head.y = snakePiece[0].y + dirY[currentDirection];
    wrap(head);
    BOOL survived = [self headChecks: head];
    [self setSpot: head withValue: 1];
    snakePiece[0] = head;
    
    // lengthen snake as needed
    if (deltaLength > 0)
    {
        --deltaLength;
        snakePiece[snakeLength++] = tail;
        [self setSpot: tail withValue: 1];
    }
    else
    {
        [self setSpot: tail withValue: 0];
        [tail release];
    }
    return survived;
}


//checks lose condition and if snake head has hit food
-(BOOL) headChecks: (Vector *) head
{
    switch (gridInfo[head.x][head.y])
    {
        case 1:
            return NO; // player lost
            break;
            
            //check if the snake head found some food
        case 2:
            for (int i = foodAmount; i--; )
            {
                if ([head isEqualTo: food[i].pos])
                {
                    [food[i] eat: self];
                    [self deleteFood: i];
                    [self createFood];
                    break;
                }
            }
            break;
    }
    return YES;
}

// sets the given space in gridInfo
-(void) setSpot: (Vector *) pos withValue: (int) n
{
    gridInfo[pos.x][pos.y] = n;
}

-(void) deleteFood: (int) index
{
//    [self setSpot: foodPos[index] withValue: 0];
    --foodAmount;
    food[index] = food[foodAmount];
    [food[foodAmount] release];
}

-(void) createFood
{
    int x, y;
    do {
        x = random() % 30;
        y = random() % 30;
    } while (gridInfo[x][y]);
    
    food[foodAmount] = [[RegularFood alloc] init];
    food[foodAmount].pos = [[[Vector alloc] initWithX: x withY: y] autorelease];
    [self setSpot: food[foodAmount].pos withValue: 2];
    ++foodAmount;
}

-(Food *) getFood: (int) index
{
    return food[index];
}

-(Vector *) getSnakePiece: (int) index
{
    return snakePiece[index];
}

@end