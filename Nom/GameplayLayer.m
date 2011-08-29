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
#import "GameOverLayer.h"
#import "RegularMode.h"

@implementation GameplayLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //enable touches
        self.isTouchEnabled = YES;
        //set up score display
        scoreText = [CCLabelAtlas labelWithString: @"" charMapFile: @"numbers.png" itemWidth: 12 itemHeight: 14 startCharMap: '0'];
        scoreText.color = ccc3(90, 220, 216);
        [scoreText setPosition: CGPointMake(16, 457)];
        [self addChild: scoreText];
        [self newGame];
    }
    
    return self;
}

-(void) dealloc
{
    [game release];
    [super dealloc];
}

-(void) newGame
{
    trackTouch = NO;
    
    //initialize game
    accumulatedTime = INITIAL_SPEED;
    newDirection = NoDirection;
    isGameOver = NO;
    isGamePaused = NO;
    gameOverTimer = 0;
    [game release];
    game = [[RegularMode alloc] init];
    
    [scoreText setString: @"0"];
    [self scheduleUpdate];
}

//pauses the game
-(void) pauseGame
{
    // don't pause if already paused
    if (isGamePaused) return;
    // no pausing while lost
    if (isGameOver) return;
    
    // creates a new PauseLayer, adds it to GameScene, places on top of GameplayLayer
    PauseLayer * p = [[[PauseLayer alloc] init] autorelease];
    [self.parent addChild: p z: 10 tag: kPauseLayer];
    CGPoint pos = p.position;
    id animation = [CCEaseBackOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: pos]];
    pos.y += 480;
    p.position = pos;
    [p runAction: animation];
    
    [self onExit];
}

-(void) onExit
{
    isGamePaused = YES;
    [super onExit];
}

-(void) onEnter
{
    isGamePaused = NO;
    [super onEnter];
}

//updates the game, 60Hz
-(void) update: (ccTime) deltaTime
{
    if (isGameOver)
    {
        gameOverTimer += deltaTime;
        if (gameOverTimer > 0.3*6)
        {
            // creates a new GameOverLayer, adds it to GameScene, places on top of GameplayLayer
            GameOverLayer * p = [[[GameOverLayer alloc] init] autorelease];
            [self.parent addChild: p z: 10 tag: kPauseLayer];
            CGPoint pos = p.position;
            id animation = [CCEaseBackOut actionWithAction: [CCMoveTo actionWithDuration: 0.5 position: pos]];
            pos.y += 480;
            p.position = pos;
            [p runAction: animation];
            // we're done here
            [self unscheduleUpdate];
        }
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
            isGameOver = YES;
        };
        
        [scoreText setString: [NSString stringWithFormat: @"%-22d%s", game.score, game.isProtected ? "<=" : ""]];
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
        int y = touchCoord.y - 74;
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
    int y = touchCoord.y - 74;
    
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
        ccColor3B darkened = {DARKEN(color.r), DARKEN(color.g), DARKEN(color.b)};
        drawBox(pos.x * 10 + 10, pos.y * 10 + 148, 10, 10, color, darkened);
    }
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    if (isGameOver && gameOverTimer < 0.3*6 && (int)(gameOverTimer / 0.3) % 2 == 0) return;
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