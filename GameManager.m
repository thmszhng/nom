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

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize levels;
@synthesize currentLevel;

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
        
        //for very first launch
/*        bool defaultsSaved = [self getInt: @"defaultsSaved"];
        if (!defaultsSaved) {
            [self setValue: @"defaultsSaved" newInt: 1];
            [self setValue: @"isMusicON" newInt: 1];
            [self setValue: @"mode" newString: @"RegularMode"];
            [self setValue: @"level" newString: @"default"];
        }*/
        
        //Initialize GameManager
        isSoundEffectsON = YES;
        currentScene = kNoSceneUninitialized;
        currentLevel = [Level new];
        [self loadLevel: 1];
    }
    
    return self;
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
            if (self.isMusicON) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"midnight-ride.mp3" loop: YES];
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

-(void) loadLevel: (int) number
{
    switch (number) {
        case 1: // box level
            for (int i = 0; i < 30; i++)
            {
                for (int j = 0; j < 30; j++)
                {
                    if(i == 0 || i == 29)
                        [currentLevel setValue: i: j: LevelWall];
                    
                    if(j == 0 || j == 29)
                        [currentLevel setValue: i: j: LevelWall];
                }
            }
            break;
            
        default:
            break;
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

-(NSArray *) getArray: (NSString *) value
{
    return [settings objectForKey: value];
}

-(NSArray * ) getArray: (NSString *) value withDefault: (NSArray *) def
{
    id ret = [settings objectForKey: value];
    return ret ? ret : def;
}

-(void) setValue: (NSString *) value newString: (NSString *) aValue
{
	[settings setObject: aValue forKey:value];
}

-(void) setValue: (NSString *) value newInt: (int) aValue
{
	[settings setObject:[NSNumber numberWithInt:aValue] forKey:value];
}

-(void) setValue: (NSString *) value newArray: (NSArray *) aValue
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
