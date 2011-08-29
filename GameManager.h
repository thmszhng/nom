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

@interface GameManager: NSObject 
{
    NSMutableDictionary *settings;
    
    BOOL isSoundEffectsON;
    SceneTypes currentScene;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON; 

+(GameManager *) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID;

-(NSString *) getString: (NSString *) value;
-(NSString *) getString: (NSString *) value withDefault: (NSString *) def;
-(int) getInt: (NSString *) value;
-(int) getInt: (NSString *) value withDefault: (int) def;
-(void) setValue: (NSString *) value newString: (NSString *) aValue;
-(void) setValue: (NSString *) value newInt: (int) aValue;
-(void) save;
-(void) load;
-(void) logSettings;

@end
