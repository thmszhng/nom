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

int randomNormal(int num)
{
    int r = 0;
    int N = num >> 1;
    while (num--) {
        int d = random();
        r += d & 1;
        if (num--) r += !!(d & 2); else break;
        if (num--) r += !!(d & 4); else break;
        if (num--) r += !!(d & 8); else break;
        if (num--) r += !!(d & 16); else break;
        if (num--) r += !!(d & 32); else break;
        if (num--) r += !!(d & 64); else break;
        if (num--) r += !!(d & 128); else break;
    }
    return r - N;
}

int randomNear(int what, int min, int num)
{
    int ret = randomNormal(num) + what;
    while (ret < 0) ret += num;
    ret %= num;
    ret += min;
    return ret;
}

@implementation Game

@synthesize steps;
@synthesize timestamp;
@synthesize score;
@synthesize currentDirection;
@synthesize speed;
@synthesize deltaLength;
@synthesize snakeLength;
@synthesize foodAmount;
@synthesize isProtected;

-(id) init
{
    self = [super init];
    if (self)
    {
        //initialize game
        speed = INITIAL_SPEED;
        timestamp = 0;
        steps = 0;
        
        //initialize snake
        snakePiece[0] = [[Vector alloc] initWithX: 15 withY: 15];
        [self setSpot: snakePiece[0] withValue: GridWall];
        snakeLength = 1;
        deltaLength = 4;
        currentDirection = NoDirection;
        isProtected = false;
        
        //initialize food
        foodAmount = 0;
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
    // time passed
    ++steps;
    timestamp += speed;
    
    // keep last element, which will be removed from snakePiece
    Vector *tail = snakePiece[snakeLength - 1];

    if (deltaLength == 0)
    {
        // don't allow hitting the tail
        [self setSpot: tail withValue: GridShadow];
    }
    
    // advance head
    Vector *head = [[Vector alloc] init];
    head.x = snakePiece[0].x + dirX[currentDirection];
    head.y = snakePiece[0].y + dirY[currentDirection];
    wrap(head);
    BOOL survived = [self headChecks: head];
    if (!survived)
    {
        [head release];
        return NO;
    }
    [self setSpot: head withValue: GridWall];
    
    // advance snake except head
    for (int i = snakeLength; --i; )
    {
        snakePiece[i] = snakePiece[i-1];
    }
    
    snakePiece[0] = head;
    
    // lengthen snake as needed
    if (deltaLength > 0)
    {
        --deltaLength;
        snakePiece[snakeLength++] = tail;
        [self setSpot: tail withValue: GridWall];
    }
    else
    {
        [self setSpot: tail withValue: GridNothing];
        [tail release];
    }
    return survived;
}


//checks lose condition and if snake head has hit food
-(BOOL) headChecks: (Vector *) head
{
    switch (gridInfo[head.x][head.y])
    {
        case GridWall:
            if (isProtected) {
                isProtected = false;
                return YES;
            }
            return NO; // player lost
            break;
            
            //check if the snake head found some food
        case GridFood ... GridFoodMax:
        {
            int i = gridInfo[head.x][head.y] - GridFood;
            assert([head isEqualTo: food[i].pos]);
            [food[i] eat: self];
            [self onEat: food[i]];
            [self deleteFood: i];
            break;
        }
            
        default:
            break;
    }
    return YES;
}

// sets the given space in gridInfo
-(void) setSpot: (Vector *) pos withValue: (enum GridSpot) n
{
    gridInfo[pos.x][pos.y] = n;
}

-(void) onEat: (Food *) food;
{
    [self doesNotRecognizeSelector: _cmd];
}

-(void) deleteFood: (int) index
{
//    [self setSpot: foodPos[index] withValue: GridNothing];
    [food[index] release];
    --foodAmount;
    if (index != foodAmount)
    {
        // move the deleted element to the back of the array
        food[index] = food[foodAmount];
        [self setSpot: food[index].pos withValue: GridFood + index];
    }
    food[foodAmount] = nil;
}

-(void) createFood: (Class) foodType;
{
    [self createFood: foodType at: [self findSpace]];
}

-(void) createFood: (Class) foodType at: (Vector *) where;
{
    food[foodAmount] = [[foodType alloc] initWithGame: self];
    food[foodAmount].pos = where;
    [self setSpot: food[foodAmount].pos withValue: GridFood + foodAmount];
    ++foodAmount;
}

-(Vector *) findSpace
{
    Vector *r = [[Vector new] autorelease];
    do {
        r.x = random() % 30;
        r.y = random() % 30;
    } while (gridInfo[r.x][r.y] != GridNothing);
    return r;
}

-(Vector *) findSpaceNear: (Vector *) where
{
    Vector *r = [[Vector new] autorelease];
    do {
        r.x = randomNear(where.x, 0, 30);
        r.y = randomNear(where.y, 0, 30);
    } while (gridInfo[r.x][r.y] != GridNothing);
    return r;
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