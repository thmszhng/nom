//
//  GameManager.m
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameManager.h"

#import "Level.h"
#import "GameScene.h"
#import "MainMenuScene.h"

#import "Constants.h"

#import "Transitions.h"
#import "CocosDenshion.h"

@implementation GameManager
static GameManager *_sharedGameManager = nil;

@synthesize levels;

+(GameManager *) sharedGameManager
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
        //Initialize/load settings
        settings = [NSMutableDictionary new];
        [self load];
        
        /*for very first launch
        bool defaultsSaved = [self getInt: @"defaultsSaved"];
        if (!defaultsSaved) 
        {
        }*/
        
        //Initialize GameManager
        currentScene = kNoSceneUninitialized;

        //Load levels
        [self loadLevels];
    }
    
    return self;
}

-(void) runSceneWithID: (SceneTypes) sceneID
{
    id sceneToRun = nil;
    
    switch (sceneID) 
    {   
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
        
        case kGameScene:
            sceneToRun = [GameScene node];
            break;
                        
        default:
            return;
            break;
    }
    
    
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;

    if (oldScene == kNoSceneUninitialized)
    {
        [[CCDirector sharedDirector] runWithScene: sceneToRun];
        return;
    }
    
    [[CCDirector sharedDirector] setAnimationInterval: 1/60.f];
    
    sceneToRun = [currentScene < oldScene ?
                  [SlideUp class] :
                  [SlideDown class]
                  transitionWithDuration: 0.5 scene: sceneToRun];
    
    [[CCDirector sharedDirector] replaceScene: sceneToRun];
}

-(void) slowFPS
{
    [[CCDirector sharedDirector] setAnimationInterval: 1/15.f];
}

-(void) loadLevels
{
    levels = [NSMutableArray new];
    //level one: empty
    Level *emptyLevel = [Level level];
    [levels addObject: emptyLevel];
    
    //level two: box
    Level *boxLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            if(i == 0 || i == 29)
                [boxLevel setValue: i: j: LevelWall];
            
            if(j == 0 || j == 29)
                [boxLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: boxLevel];
    
    //level three: cage
    Level *thirdLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            if ((i == 5 || i == 24) && ((5 <= j && j <= 12) || (17 <= j && j <= 24)))
                [thirdLevel setValue: i: j: LevelWall];
                        
            if ((j == 5 || j == 24) && ((5 <= i && i <= 12) || (17 <= i && i <= 24)))
                [thirdLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: thirdLevel];
    
    //level four: x
    Level *fourthLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            if (((i == 6 || i == 7 || i == 21 || i == 22) && !((j > 12 && j < 16) || j == 0 || j > 27)) ||
                ((j == 6 || j == 7 || j == 21 || j == 22) && !((i > 12 && i < 16) || i == 0 || i > 27)))
                [fourthLevel setValue: i: j: LevelWall];
            
        }
    }
    [levels addObject: fourthLevel];
    
    //level five: holy boxes (har har har)
    Level *fifthLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            if ((i == 2 || i == 27) && 4 <= j && j <= 25)
                [fifthLevel setValue: i: j: LevelWall];
            
            if ((i == 7 || i == 22) && 9 <= j && j <= 20)
                [fifthLevel setValue: i: j: LevelWall];
            
            if ((i == 12 || i == 17) && (j == 14 || j == 15))
                [fifthLevel setValue: i: j: LevelWall];
            
            if ((j == 2 || j == 27) && 4 <= i && i <= 25)
                [fifthLevel setValue: i: j: LevelWall];
            
            if ((j == 7 || j == 22) && 9 <= i && i <= 20)
                [fifthLevel setValue: i: j: LevelWall];
            
            if ((j == 12 || j == 17) && (i == 14 || i == 15))
                [fifthLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: fifthLevel];
    
    //level six: tic tac toe
    Level *sixthLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {
            
            //if ((i == 0 || i == 29) && ((/*2 <= j &&*/ j <= 13) || (16 <= j /*&& j <= 27*/)))
              //  [sixthLevel setValue: i: j: LevelWall];
            
            if ((i == 0 || i == 10 || i == 19 || i == 29) && ((0 <= j && j <= 4) || (7 <= j && j <= 13) || (16 <= j && j <= 22) || (25 <= j && j <= 29)))
                [sixthLevel setValue: i: j: LevelWall];
            
            //if ((j == 0 || j == 29) && ((/*2 <= i &&*/ i <= 13) || (16 <= i /*&& i <= 27*/)))
              //  [sixthLevel setValue: i: j: LevelWall];
            
            if ((j == 0 || j == 10 || j == 19 || j == 29) && ((0 <= i && i <= 4) || (7 <= i && i <= 13) || (16 <= i && i <= 22) || (25 <= i && i <= 29)))
                [sixthLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: sixthLevel];
    
    //level seven: +
    Level *seventhLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for(int j = 0; j < 30; j++)
        {
            /*if ((i == 0 || i == 1 || i == 28 || i == 29) && (j == 0 || j == 1 || j == 28 || j == 29))
                [seventhLevel setValue: i: j: LevelWall];*/
            
            if ((i == 14 || i == 15) && ((2 <= j && j <= 10) || (19 <= j && j <= 27)))
                [seventhLevel setValue: i: j: LevelWall];
            
            /*if ((j == 0 || j == 1 || j == 28 || j == 29) && (i == 0 || i == 1 || i == 28 || i == 29))
                [seventhLevel setValue: i: j: LevelWall];*/
            
            if ((j == 14 || j == 15) && ((2 <= i && i <= 10) || (19 <= i && i <= 27)))
                [seventhLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: seventhLevel];
    
    //level eight: / \ \ /
    Level *eightLevel = [Level level];
    for (int i = 0; i < 30; i++)
    {
        for (int j = 0; j < 30; j++)
        {            
            if ((i == 4 || i == 25) && (j == 11 || j == 12 || j == 17 || j == 18))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((i == 5 || i == 24) && (j == 10 || j == 11 || j == 18 || j == 19))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((i == 6 || i == 23) && (j == 9 || j == 10 || j == 19 || j == 20))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 7 || i == 22) && (j == 8 || j == 9 || j == 20 || j == 21))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 8 || i == 21) && (j == 7 || j == 8 || j == 21 || j == 22))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 9 || i == 20) && (j == 6 || j == 7 || j == 22 || j == 23))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 10 || i == 19) && (j == 5 || j == 6 || j == 23 || j == 24))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 11 || i == 18 ) && (j == 4 || j == 5 || j == 24 || j == 25))
                [eightLevel setValue: i: j: LevelWall];

            if ((i == 12 || i == 17) && (j == 3 || j == 4 || j == 25 || j == 26))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 4 || j == 25) && (i == 11 || i ==12 || i ==17 || i ==18))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 5 || j == 24) && (i == 10 || i ==11 || i ==18 || i ==19))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 6 || j == 23) && (i == 9 || i ==10 || i ==19 || i ==20))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 7 || j == 22) && (i == 8 || i ==9 || i ==20 || i ==21))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 8 || j == 21) && (i == 7 || i ==8 || i ==21 || i ==22))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 9 || j == 20) && (i == 6 || i ==7 || i ==22 || i ==23))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 10 || j == 19) && (i == 5 || i ==6 || i ==23 || i ==24))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 11 || j == 18 ) && (i == 4 || i == 5 || i == 24 || i == 25))
                [eightLevel setValue: i: j: LevelWall];
            
            if ((j == 12 || j == 17) && (i == 3 || i == 4 || i == 25 || i == 26))
                [eightLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: eightLevel];
    
    //user levels
    NSArray *userLevels = [self getMutableArray: @"userLevels"];
    if (userLevels)
    {
        [levels addObjectsFromArray: userLevels];
    }
}

-(BOOL) isMusicON
{
    BOOL ret = [self getInt: @"isMusicON" withDefault: YES];
    return ret;
}

-(void) setIsMusicON: (BOOL) val
{
    [self setValue: @"isMusicOn" newInt: val];
}

-(Level *) level
{
    return [levels objectAtIndex: self.levelIndex];
}

-(int) levelIndex
{
    return [self getInt: @"levelIndex" withDefault: 0];
}

-(void) setLevelIndex: (int) levelIndex
{
    [self setValue: @"levelIndex" newInt: levelIndex];
}

-(NSString *) getString: (NSString *) value
{
	return [settings objectForKey:value];
}

-(NSString *) getString: (NSString *) value withDefault: (NSString *) def
{
	NSString *ret = [settings objectForKey:value];
    return ret ? ret : def;
}

-(int) getInt: (NSString *) value 
{
	return [[settings objectForKey:value] intValue];
}

-(int) getInt: (NSString *) value withDefault: (int) def
{
    id ret = [settings objectForKey: value];
    return ret ? [ret intValue] : def;
}

-(NSMutableArray *) getMutableArray: (NSString *) value
{
    return [settings objectForKey: value];
}

-(void) setValue: (NSString *) value newString: (NSString *) aValue
{
	[settings setObject: aValue forKey:value];
}

-(void) setValue: (NSString *) value newInt: (int) aValue
{
	[settings setObject:[NSNumber numberWithInt:aValue] forKey:value];
}

-(void) setValue: (NSString *) value newMutableArray: (NSMutableArray *) aValue
{
    [settings setObject: aValue forKey: value];
}

-(void) save
{
	[[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"com.xamigo.nom"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) load
{
	[settings addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"com.xamigo.nom"]];
}

-(void) logSettings
{
    for(NSString* item in settings)
    {
		NSLog(@"[SettingsManager KEY:%@ - VALUE:%@]", item, [settings valueForKey:item]);
	}
}
@end
