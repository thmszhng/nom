//
//  GameplayLayer.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameplayLayer.h"
#import "Render.h"
#import "GameManager.h"
#import "PauseLayer.h"
#import "GameOverLayer.h"
#import "SnakeTail.h"

@implementation GameplayLayer
@synthesize game;
@synthesize isFancy;
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //enable touches
        self.isTouchEnabled = YES;
        //set up score display
        isFancy = false;
        scoreText = [CCLabelBMFont labelWithString: @"" fntFile: @"Varela Round.fnt"];
//        scoreText.color = ccc3(90, 220, 216);
        scoreText.anchorPoint = CGPointMake(0, 0.5f);
        scoreText.position = CGPointMake(16, 463);
        [self addChild: scoreText];
        emblems = [CCLabelAtlas labelWithString:@"" charMapFile: @"emblems.png" itemWidth:24 itemHeight: 14 startCharMap: 'a'];
        emblems.position = CGPointMake(256, 457);
        [self addChild: emblems];
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
    accumulatedTime = 0;
    newDirection = NoDirection;
    isGameOver = NO;
    isGamePaused = NO;
    gameOverTimer = 0;
    [game release];
    
    NSString *mode = [[GameManager sharedGameManager] getString: @"mode" withDefault: @"RegularMode"];
    game = [[NSClassFromString(mode) alloc] init];
        
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
    [p setOpacity: 0];
    [self.parent addChild: p z: 10 tag: kPauseLayer];
    id animation = [CCFadeIn actionWithDuration: 0.2];

    animation = [CCSequence actions: animation,
                 [CCCallFunc actionWithTarget: [GameManager sharedGameManager]
                                     selector: @selector(slowFPS)], nil];
    [p runAction: animation];
    [[CCDirector sharedDirector] setAnimationInterval: 1/60.f];
    
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
    [CCDirector sharedDirector].animationInterval = 1/30.f;
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
            [p setOpacity: 0];
            [self.parent addChild: p z: 10 tag: kPauseLayer];
            id animation = [CCFadeIn actionWithDuration: 0.5];
            animation = [CCSequence actions: animation,
                         [CCCallFunc actionWithTarget: [GameManager sharedGameManager]
                                             selector: @selector(slowFPS)], nil];
            [p runAction: animation];
            [[CCDirector sharedDirector] setAnimationInterval: 1/60.f];
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
        if ([game isRaged] && [game rageExpiry] < [game timestamp]) {
            [game setSpeed: [game speed]*1.75];  
            [game setIsRaged: false];
        }
        if (![game moveSnake])
        {
            isGameOver = YES;
        };
        
        [scoreText setString: [NSString stringWithFormat: @"%d", game.score]];
        [emblems setString: [NSString stringWithFormat: @"%c%c", game.isRaged ? 'b' : ' ', game.isProtected ? 'a' : ' ']];
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
    CGRect fancySwitchArea = CGRectMake(0, 450, 320, 30);
    if (CGRectContainsPoint(fancySwitchArea, touchCoord))
    {
        isFancy = !isFancy;
    }
    
    CGRect pauseGameArea = CGRectMake (0, 200, 320, 250);
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
    for (Food *food in game.food)
    {
        int deltaX = isFancy ? 15 - game.head.pos.x : 0, deltaY = isFancy ? 15 - game.head.pos.y : 0;
        Vector *pos = food.pos;
        ccColor3B color = [food color];
        ccColor3B darkened = {DARKEN(color.r), DARKEN(color.g), DARKEN(color.b)};

        drawBox(((pos.x + deltaX + 30) % 30) * 10 + 10, ((pos.y + deltaY + 30) % 30) * 10 + 148, 10, 10, color, darkened);
        
    }
    //NSLog(@"%d %d %d", game.head.pos.x, game.head.pos.y);
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    if (isGameOver && gameOverTimer < 0.3*6 && (int)(gameOverTimer / 0.3) % 2 == 0) return;
    enum Direction lastdir = NoDirection;
    SnakeTail *piece = game.tail;
    while (piece != nil)
    {
        enum Direction dir = NoDirection;
        SnakeTail *after = piece.forward;
        Vector *pos = piece.pos;
        int deltaX = isFancy ? 15 - game.head.pos.x : 0, deltaY = isFancy ? 15 - game.head.pos.y : 0;
        int posx = ((pos.x + deltaX + 30) % 30), posy = ((pos.y + deltaY + 30) % 30);

        if (after != nil)
        {   
            Vector *apos = after.pos;
            int aposx = ((apos.x + deltaX + 30) % 30), aposy = ((apos.y + deltaY + 30) % 30);
            if (abs(posx - aposx) + abs(posy - aposy) == 1)
            {
                if (aposx - posx == 1) dir = right;
                if (aposx - posx == -1) dir = left;
                if (aposy - posy == 1) dir = up;
                if (aposy - posy == -1) dir = down;
            }
        }
                drawSnake(posx, posy, dir == up || lastdir == down, dir == left || lastdir == right, dir == down || lastdir == up, dir == right || lastdir == left);
        piece = after;
        lastdir = dir;

    }
}
@end

