//
//  GameManager.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

/* Settings Saving Example
 
 [[GameManager sharedGameManager] setValue:@"hiscore" newValue:@"10000"];
 int myInt = [[GameManager sharedGameManager] getInt:@"challenges_won"];

*/

#import <Foundation/Foundation.h>
#import "Constants.h"

@class Level;
@class CDSoundEngine;

@interface GameManager: NSObject
{
    NSMutableDictionary *settings;
    
    BOOL isSoundEffectsON;
    SceneTypes currentScene;
    
    NSMutableArray *levels;
    NSThread *soundThread;
    NSLock *audioLock;
    BOOL loopLoaded;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON; 
@property (readonly, retain) NSMutableArray *levels;
@property (readonly) Level *level;
@property (readwrite) int levelIndex;

+(GameManager *) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID;
-(void) slowFPS;
-(void) loadLevels;

-(void) loadLoop: (id) engine;
-(void) playMusic;

-(NSString *) getString: (NSString *) value;
-(NSString *) getString: (NSString *) value withDefault: (NSString *) def;

-(int) getInt: (NSString *) value;
-(int) getInt: (NSString *) value withDefault: (int) def;

-(NSMutableArray *) getMutableArray: (NSString *) value;

-(void) setValue: (NSString *) value newString: (NSString *) aValue;
-(void) setValue: (NSString *) value newInt: (int) aValue;
-(void) setValue: (NSString *) value newMutableArray: (NSMutableArray*) aValue;

-(void) save;
-(void) load;
-(void) logSettings;

@end
