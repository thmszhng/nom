//
//  GameplayLayer.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameplayLayer.h"
#import "Render.h"

#define INITIAL_SPEED (0.25)
#define SPEED_BOOST(x) (1./(1./(x)+0.25))
// #define SPEED_BOOST(x) ((x) * 0.95)
// #define SPEED_BOOST(x) powf(powf(x, -1./1.5)+0.1, -1.5)


static const int dirX[4] = {0, 0, -1, 1};
static const int dirY[4] = {1, -1, 0, 0};

void wrap(Vector *pos)
{
    while (pos.x < 0) pos.x += 30;
    while (pos.x >= 30) pos.x -= 30;
    while (pos.y < 0) pos.y += 30;
    while (pos.y >= 30) pos.y -= 30;
}

@implementation GameplayLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //enable touches
        self.isTouchEnabled = YES;
        trackTouch = NO;
        
        //initialize game
        speed = accumulatedTime = INITIAL_SPEED;
        [GameManager sharedGameManager].isGameOver = NO;
        [GameManager sharedGameManager].isGamePaused = NO;
        
        //initialize snake
        snakePiece[0] = [[Vector alloc] initWithX: 15 withY: 15];
        [self setSpot: snakePiece[0] withValue: 1];
        snakeLength = 1;
        deltaLength = 3;
        currentDirection = newDirection = NoDirection;
        
        //initialize food
        food = [[Vector alloc] init];
        [self moveFood];
        scoreText = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"Score: %d", score] fontName: @"HelveticaNeue" fontSize: 20];
        scoreText.color = ccc3(0, 0, 0);
        [scoreText setPosition: ccp(50,150)];
        [self addChild: scoreText];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) dealloc
{
    [food release];
    while (snakeLength--)
    {
        [snakePiece[snakeLength] release];
    }
    [super dealloc];
}

//pauses the game
-(void) pauseGame
{    
    //creates a new PauseLayer, adds it to GameScene, places on top of GameplayLayer
    ccColor4B c = {100, 100, 0, 100};
    PauseLayer * p = [[[PauseLayer alloc] initWithColor: c] autorelease];
    [self.parent addChild: p z: 10 tag: kPauseLayer];
    
    [self onExit];
}

-(void) onExit
{
    [GameManager sharedGameManager].isGamePaused = YES;
    [super onExit];
}

-(void) onEnter
{
    [GameManager sharedGameManager].isGamePaused = NO;
    [super onEnter];
}

//updates the game, 60Hz
-(void) update: (ccTime) deltaTime
{
    if ([GameManager sharedGameManager].isGameOver)
    {
        [[GameManager sharedGameManager] runSceneWithID: kMainMenuScene];
        return;
    }
    
    if (newDirection == NoDirection) return;
    
    accumulatedTime += deltaTime;
    while (accumulatedTime > speed)
    {
        accumulatedTime -= speed;
        
        currentDirection = newDirection;
        
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
        [self headChecks: head];
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
    }
}


-(void) moveFood
{
    int x, y;
    do {
        x = random() % 30;
        y = random() % 30;
    } while (gridInfo[x][y]);
    
    food.x = x;
    food.y = y;
    [self setSpot: food withValue: 2];
}

//handles touches
-(void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event;
{
    CGPoint touchCoord;
	for (UITouch *touch in touches)
    {
		touchCoord = [[CCDirector sharedDirector] convertToGL: [touch locationInView: [touch view]]];
    }
    CGRect pauseGameArea = CGRectMake (0, 200, 320, 280);
    // determine whether or not to pause the game
    if (CGRectContainsPoint(pauseGameArea, touchCoord))
    {
        [self pauseGame];
    }
    else
    {
        int x = touchCoord.x - 160;
        int y = touchCoord.y - 85;
        trackTouch = (x*x + y*y < 16000);
        
        [self changeHeadDirection: touchCoord];
    }
}
 
-(void) ccTouchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
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

// sets the given space in gridInfo
-(void) setSpot: (Vector *) pos withValue: (int) n
{
    gridInfo[pos.x][pos.y] = n;
}


//checks lose condition and if snake head has hit food
-(void) headChecks: (Vector *) head
{
    switch (gridInfo[head.x][head.y])
    {
        case 1:
            
            [GameManager sharedGameManager].isGameOver = YES;
            break;
            
        //check if the snake head found some food
        case 2:
            // adds a new snake piece to the end of the snake
            ++deltaLength;
            
            // advancement
            ++score;
            [scoreText setString:[NSString stringWithFormat:@"Score: %d", score]];
            // speed ramp
            speed = SPEED_BOOST(speed);
            
            // spawns a new food
            [self moveFood];
            break;
    }
}

-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    drawBox(food.x * 10 + 10, food.y * 10 + 170, 10, 10, 255, 0, 0, 255);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    enum Direction lastdir = NoDirection;
    for (int i = snakeLength; i--; )
    {
        Vector *piece = snakePiece[i];
        enum Direction dir = NoDirection;
        if (i != 0)
        {
            Vector *after = snakePiece[i - 1];
            if (abs(piece.x - after.x) + abs(piece.y - after.y) == 1)
            {
                if (after.x - piece.x == 1) dir = right;
                if (after.x - piece.x == -1) dir = left;
                if (after.y - piece.y == 1) dir = up;
                if (after.y - piece.y == -1) dir = down;
            }
        }
        drawSnake(piece.x, piece.y, dir == up || lastdir == down, dir == left || lastdir == right, dir == down || lastdir == up, dir == right || lastdir == left);
        lastdir = dir;
    }


}
@end