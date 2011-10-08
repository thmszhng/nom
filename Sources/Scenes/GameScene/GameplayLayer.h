//
//  GameplayLayer.h
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "Game.h"

@interface GameplayLayer : CCLayer
{    
    // game variables
    Game *game;
    ccTime accumulatedTime;
    enum Direction newDirection;
    
    // game state
    BOOL isFancy;
    BOOL isGamePaused;
    BOOL isGameOver;
    ccTime gameOverTimer;
    
    // controls
    BOOL trackTouch;
    CCLabelAtlas *scoreText;
}

-(id) init;
-(void) dealloc;

-(void) newGame;
-(void) pauseGame;
-(void) onExit;
-(void) onEnter;

-(void) update: (ccTime) deltaTime;

//handles touches
-(void) ccTouchesBegan: (NSSet *) touches withEvent: (UIEvent *) event;
-(void) ccTouchesMoved: (NSSet *) touches withEvent: (UIEvent *) event;

//related to moving the snake
-(void) changeHeadDirection: (CGPoint) point;

-(void) draw;

@end
