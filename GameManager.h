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

@interface GameManager: NSObject 
{
    NSMutableDictionary *settings;
    
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    SceneTypes currentScene;
    
    NSArray *levels;
    Level *currentLevel;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON; 
@property (readwrite, retain) NSArray *levels;
@property (readwrite, assign) Level *currentLevel;

+(GameManager *) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID;

-(NSString *) getString: (NSString *) value;
-(NSString *) getString: (NSString *) value withDefault: (NSString *) def;
-(int) getInt: (NSString *) value;
-(int) getInt: (NSString *) value withDefault: (int) def;
-(NSArray *) getArray: (NSString *) value;
-(NSArray *) getArray: (NSString *) value withDefault: (NSArray *) def;

-(void) setValue: (NSString *) value newString: (NSString *) aValue;
-(void) setValue: (NSString *) value newInt: (int) aValue;
-(void) setValue: (NSString *) value newArray: (NSArray*) aValue;

-(void) save;
-(void) load;
-(void) logSettings;

@end
