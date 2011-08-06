//
//  GameManager.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameManager : NSObject 
{
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    BOOL isGameOver;
    SceneTypes currentScene;
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON; 
@property (readwrite) BOOL isGameOver;
@property (readwrite) BOOL isGameRunning;

+(GameManager*) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID; 
-(void) openSiteWithLinkType: (LinkTypes) linkTypeToOpen;
@end
