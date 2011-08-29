//
//  GameManager.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

/* Settings Saving Example
 
 [[GameManager sharedGameManager] saveValue:@"hiscore" newValue:@"10000"];
 int myInt = [[GameManager sharedGameManager] getInt:@"challenges_won"];

*/

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameManager : NSObject 
{
    NSMutableDictionary *settings;
    
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    BOOL isGameOver;
    SceneTypes currentScene;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON; 

+(GameManager*) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID;

-(int)getInt:(NSString*)value;
-(void)setValue:(NSString*)value newInt:(int)aValue;
-(void)save;
-(void)load;
-(void)logSettings;

@end
