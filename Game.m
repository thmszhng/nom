//
//  Game.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Game.h"
#import "GameConstants.h"

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
@synthesize snakeLength;
@synthesize food;

-(id) init
{
    self = [super init];
    if (self)
    {
        //initialize game
        self.speed = INITIAL_SPEED;
        
        //initialize snake
        snakePiece[0] = [[Vector alloc] initWithX: 15 withY: 15];
        [self setSpot: snakePiece[0] withValue: 1];
        self.snakeLength = 1;
        deltaLength = 3;
        self.currentDirection = NoDirection;
        
        //initialize food
        self.food = [[Vector alloc] init];
        [self moveFood];
    }
    return self;
}

-(void) dealloc
{
    [self.food release];
    while (self.snakeLength--)
    {
        [snakePiece[self.snakeLength] release];
    }
    [super dealloc];
}

-(BOOL) moveSnake
{
    // keep last element, which will be removed from snakePiece
    Vector *tail = snakePiece[self.snakeLength - 1];
    
    // temporarily set a value to stop collisions
    [self setSpot: tail withValue: 3];
    
    // advance snake except head
    for (int i = self.snakeLength; --i; )
    {
        snakePiece[i] = snakePiece[i-1];
    }
    
    // don't allow hitting the tail
    [self setSpot: tail withValue: 0];
    
    // advance head
    Vector *head = [[Vector alloc] init];
    head.x = snakePiece[0].x + dirX[self.currentDirection];
    head.y = snakePiece[0].y + dirY[self.currentDirection];
    wrap(head);
    BOOL survived = [self headChecks: head];
    [self setSpot: head withValue: 1];
    snakePiece[0] = head;
    
    // lengthen snake as needed
    if (deltaLength > 0)
    {
        --deltaLength;
        snakePiece[self.snakeLength++] = tail;
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
            // adds a new snake piece to the end of the snake
            ++deltaLength;
            
            // advancement
            ++self.score;
            // speed ramp
            self.speed = SPEED_BOOST(self.speed);
            
            // spawns a new food
            [self moveFood];
            break;
    }
    return YES;
}

// sets the given space in gridInfo
-(void) setSpot: (Vector *) pos withValue: (int) n
{
    gridInfo[pos.x][pos.y] = n;
}

-(void) moveFood
{
    int x, y;
    do {
        x = random() % 30;
        y = random() % 30;
    } while (gridInfo[x][y]);
    
    self.food.x = x;
    self.food.y = y;
    [self setSpot: self.food withValue: 2];
}

-(Vector *) getSnakePiece: (int) index
{
    return snakePiece[index];
}

@end