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
#import "OptionsScene.h"

#import "Constants.h"

#import "Transitions.h"
#import "SimpleAudioEngine.h"
#import "CocosDenshion.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;

@synthesize isMusicON;
@synthesize isSoundEffectsON;

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
        currentScene = kNoSceneUninitialized;
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
            if(isMusicON) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"midnight-ride.mp3" loop:YES];
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

-(NSString *)getString:(NSString*)value
{	
	return [settings objectForKey:value];
}

-(int)getInt:(NSString*)value {
	return [[settings objectForKey:value] intValue];
}

-(void)setValue:(NSString*)value newString:(NSString *)aValue {	
	[settings setObject:aValue forKey:value];
}

-(void)setValue:(NSString*)value newInt:(int)aValue {
	[settings setObject:[NSString stringWithFormat:@"%i",aValue] forKey:value];
}

-(void)save
{
	[[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"Nom"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}

-(void)load
{
	[settings addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"Nom"]];
}

-(void)logSettings
{
    for(NSString* item in [settings allKeys])
	{
		NSLog(@"[SettingsManager KEY:%@ - VALUE:%@]", item, [settings valueForKey:item]);
	}
}
@end
