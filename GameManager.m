//
//  GameManager.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameManager.h"

#import "GameScene.h"
#import "MainMenuScene.h"
#import "GameOptionsScene.h"

#import "Constants.h"


@implementation GameManager
static GameManager* _sharedGameManager = nil;

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize isGameOver;
@synthesize isGamePaused;

+(GameManager*) sharedGameManager
{
    @synchronized([GameManager class])
    {
        if(!_sharedGameManager)
        {
            _sharedGameManager = [[self alloc] init];
        }
        return _sharedGameManager;
    }
    
    return nil;
}

+(id) alloc
{
    return [super alloc];
}

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        //Game Manager initialized
        isMusicON = YES;
        isSoundEffectsON = YES;
        isGameOver = NO;
        isGamePaused = NO;
        currentScene = kNoSceneUninitialized;
    }
    
    return self;
}

-(void) runSceneWithID: (SceneTypes) sceneID
{
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) 
    {
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
        
        case kGameScene:
            sceneToRun = [GameScene node];
            break;
            
        case kGameOptionsScene:
            sceneToRun = [GameOptionsScene node];
            break;
            
        default:
            return;
            break;
    }
    
    if (sceneToRun == nil)
    {
        currentScene = oldScene;
        return;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil)
    {
        [[CCDirector sharedDirector] runWithScene: sceneToRun];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene: sceneToRun];
    }
}
@end
