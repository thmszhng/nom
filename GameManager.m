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
#import "OptionsScene.h"

#import "Constants.h"

#import "Transitions.h"
#import "SimpleAudioEngine.h"
#import "CocosDenshion.h"

@implementation GameManager
static GameManager *_sharedGameManager = nil;

@synthesize isSoundEffectsON;
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
        isSoundEffectsON = YES;
        currentScene = kNoSceneUninitialized;
        
        //Load levels
        [self loadLevels];
    }
    
    return self;
}

-(void) cdAudioSourceDidFinishPlaying: (CDLongAudioSource *) audioSource
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"loop.aac"];
}

-(void) runSceneWithID: (SceneTypes) sceneID
{
    id sceneToRun = nil;
    
    switch (sceneID) 
    {
        case kMainMenuScene:
            if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            sceneToRun = [MainMenuScene node];
            break;
        
        case kGameScene:
            if (self.isMusicON)
            {
                [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic: @"loop.aac"];
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"intro.aac" loop: NO];
                [CDAudioManager sharedManager].backgroundMusic.delegate = self;
            }
            sceneToRun = [GameScene node];
            break;
            
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
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
    
    sceneToRun = [currentScene < oldScene ?
                  [SlideUp class] :
                  [SlideDown class]
                  transitionWithDuration: 0.5 scene: sceneToRun];
    
    [[CCDirector sharedDirector] replaceScene: sceneToRun];
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
            if ((i == 5 || i == 24) && ((5 <= j && j <= 13) || (16 <= j && j <= 24)))
                [thirdLevel setValue: i: j: LevelWall];
                        
            if ((j == 5 || j == 24) && ((5 <= i && i <= 13) || (16 <= i && i <= 24)))
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
            if (i == j || i == (29 - j))
            {
                if (i != 0 && i != 14 && i != 15 && i != 29 && j != 0 && j != 14 && j != 15 && j != 29)
                    [fourthLevel setValue: i: j: LevelWall];
            }
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
            if ((i == 0 || i == 29) && ((2 <= j && j <= 13) || (16 <= j && j <= 27)))
                [sixthLevel setValue: i: j: LevelWall];
            
            if ((i == 10 || i == 19) && ((0 <= j && j <= 4) || (7 <= j && j <= 13) || (16 <= j && j <= 22) || (25 <= j && j <= 29)))
                [sixthLevel setValue: i: j: LevelWall];
            
            if ((j == 0 || j == 29) && ((2 <= i && i <= 13) || (16 <= i && i <= 27)))
                [sixthLevel setValue: i: j: LevelWall];
            
            if ((j == 10 || j == 19) && ((0 <= i && i <= 4) || (7 <= i && i <= 13) || (16 <= i && i <= 22) || (25 <= i && i <= 29)))
                [sixthLevel setValue: i: j: LevelWall];
        }
    }
    [levels addObject: sixthLevel];
    
    //user levels
    NSArray *userLevels = [self getMutableArray: @"userLevels"];
    if (userLevels)
    {
        [levels addObjectsFromArray: userLevels];
    }
}

-(BOOL) isMusicON
{
    return [self getInt: @"isMusicON" withDefault: YES];
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
