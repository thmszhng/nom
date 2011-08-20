//
//  GameplayLayer.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameplayLayer.h"
#import "Render.h"
#import "GameConstants.h"
#import "GameManager.h"
#import "PauseLayer.h"
#import "RegularMode.h"

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
        accumulatedTime = INITIAL_SPEED;
        newDirection = NoDirection;
        [GameManager sharedGameManager].isGameOver = NO;
        [GameManager sharedGameManager].isGamePaused = NO;
        game = [[RegularMode alloc] init];
        
        //set up score display
        scoreText = [CCLabelTTF labelWithString: [NSString stringWithFormat: @"Score: %d", game.score] fontName: @"HelveticaNeue" fontSize: 20];
        scoreText.color = ccc3(0, 0, 0);
        [scoreText setPosition: ccp(50,150)];
        [self addChild: scoreText];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) dealloc
{
    [game release];
    [super dealloc];
}

//pauses the game
-(void) pauseGame
{
    // don't pause if already paused
    if ([GameManager sharedGameManager].isGamePaused) return;
    
    // creates a new PauseLayer, adds it to GameScene, places on top of GameplayLayer
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
    while (accumulatedTime > game.speed)
    {
        accumulatedTime -= game.speed;
        
        game.currentDirection = newDirection;
        
        if (![game moveSnake])
        {
            [GameManager sharedGameManager].isGameOver = YES;
        };
        
        [scoreText setString: [NSString stringWithFormat: @"Score: %d", game.score]];
    }
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
    
    enum Direction currentDirection = game.currentDirection;
    
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

-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    for (int i = game.foodAmount; i--; )
    {
        Food *food = [game getFood: i];
        Vector *pos = food.pos;
        ccColor3B color = [food color];
        drawBox(pos.x * 10 + 10, pos.y * 10 + 170, 10, 10, color.r, color.g, color.b, 255);
    }
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    enum Direction lastdir = NoDirection;
    for (int i = game.snakeLength; i--; )
    {
        Vector *piece = [game getSnakePiece: i];
        enum Direction dir = NoDirection;
        if (i != 0)
        {
            Vector *after = [game getSnakePiece: i - 1];
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