//
//  Game.m
//  Nom
//
//  Created on 11-08-15.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Game.h"
#import "GameManager.h"
#import "Level.h"
#import "GridObject.h"
#import "SnakeTail.h"

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

@synthesize steps, timestamp, score, currentDirection, speed, isProtected;
@synthesize head, tail, deltaLength, snakeLength;
@synthesize food;

-(id) init
{
    self = [super init];
    if (self)
    {
        // initialize game
        speed = [[GameManager sharedGameManager] getInt: @"speed" withDefault: 350] / 1000.;
        timestamp = 0;
        steps = 0;
        
        // initialize snake
        self.head = self.tail = [[SnakeTail alloc] initAt: [self beginSpace]];
        [self addObject: self.head];
        snakeLength = 1;
        deltaLength = 4;
        currentDirection = NoDirection;
        isProtected = false;
        
        // initialize food
        food = [NSMutableSet new];
        
        // initialize grid with level
        Level *level = [GameManager sharedGameManager].level;
        for (int x = 0; x < 30; ++x) for (int y = 0; y < 30; ++y)
        {
            if ([level getValue: x : y] != LevelWall) continue;
            Wall *wall = [Wall new];
            wall.pos = [[[Vector alloc] initWithX: x withY: y] autorelease];
            [self addObject: wall];
        }
    }
    return self;
}

-(void) dealloc
{
    self.head = nil;
    self.tail = nil;
    self.food = nil;
    for (int y = 0; y < 30; ++y) for (int x = 0; x < 30; ++x)
    {
        [grid[x][y] release];
    }
    [super dealloc];
}

-(BOOL) moveSnake
{
    // time passed
    ++steps;
    timestamp += speed;

    BOOL removed = NO;
    if (deltaLength == 0)
    {
        // don't allow hitting the tail
        [self removeObject: tail];
        removed = YES;
    }
    
    // advance head
    SnakeTail *newHead = [[head copy] autorelease];
    newHead.pos.x += dirX[currentDirection];
    newHead.pos.y += dirY[currentDirection];
    wrap(newHead.pos);
    // check for death
    BOOL survived = [self headChecks: newHead.pos];
    if (!survived)
    {
        return NO;
    }
    head.forward = newHead;
    head = newHead;
    [self addObject: head];
    
    if (deltaLength > 0)
    {
        // keep the tail
        if (removed)
        {
            [self addObject: tail];
        }
        --deltaLength;
    }
    else
    {
        // remove the last piece
        if (!removed)
        {
            [self removeObject: tail];
        }
        tail = tail.forward;
    }
    return survived;
}

//checks lose condition and if snake head has hit food
-(BOOL) headChecks: (Vector *) where
{
    if (grid[where.x][where.y] == nil) return YES;
    BOOL survival = [grid[where.x][where.y] eatRecursively: self];
    for (GridObject *obj = grid[where.x][where.y]; obj != nil; )
    {
        if ([obj isKindOfClass: [Food class]])
        {
            Food *ofood = (Food*) obj;
            obj = ofood.next;
            [self onEat: ofood];
            [self removeObject: ofood];
            [self removeFood: ofood];
        }
        else
        {
            obj = obj.next;
        }
    }
    if (survival) return YES;
    if (isProtected)
    {
        isProtected = NO;
        return YES;
    }
    return NO;
}

-(void) addObject: (GridObject *) object
{
    Vector *pos = object.pos;
    GridObject *current = grid[pos.x][pos.y];
    if (current == nil)
    {
        grid[pos.x][pos.y] = [object retain];
    }
    else
    {
        for (; current.next != nil; current = current.next);
        current.next = object;
    }
}

-(void) removeObject: (GridObject *) object
{
    Vector *pos = object.pos;
    GridObject *prev = grid[pos.x][pos.y];
    if (prev == object)
    {
        grid[pos.x][pos.y] = object.next;
        [object release];
    }
    else
    {
        for (; prev.next != object; prev = prev.next)
        {
            assert(prev != nil);
        }
        prev.next = object.next;
    }
}

-(void) onEat: (Food *) food;
{
    [self doesNotRecognizeSelector: _cmd];
}

-(void) removeFood: (Food *) what
{
    [food removeObject: what];
}

-(void) createFood: (Class) foodType;
{
    [self createFood: foodType at: [self findSpace]];
}

-(void) createFood: (Class) foodType at: (Vector *) where;
{
    Food *new = [[foodType alloc] initWithGame: self];
    new.pos = where;
    [food addObject: new];
    [self addObject: new];
}

-(void) rampSpeedBy: (float) amt
{
    speed = 1.f/(1.f/speed + 0.25f * amt);
    // speed *= powf(0.95f, amt);
    // speed = powf(powf(speed, -1/1.5) + 0.1 * amt, -1.5)
}

-(Vector *) findSpace
{
    Vector *r = [[Vector new] autorelease];
    do {
        r.x = random() % 30;
        r.y = random() % 30;
    } while (grid[r.x][r.y] != nil);
    return r;
}

-(Vector *) findSpaceNear: (Vector *) where
{
    Vector *r = [[Vector new] autorelease];
    do {
        r.x = randomNear(where.x, 0, 30);
        r.y = randomNear(where.y, 0, 30);
    } while (grid[r.x][r.y] != nil);
    return r;
}

-(Vector *) beginSpace
{
    return [[[Vector alloc] initWithX: 15 withY: 15] autorelease];
}
@end
