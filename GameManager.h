//
//  GameManager.h
//  Nom
//
//  Created by Qian Zhang on 11-07-27.
//  Copyright 2011 Cisco. All rights reserved.
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

+(GameManager*) sharedGameManager;
-(void) runSceneWithID: (SceneTypes) sceneID; 
-(void) openSiteWithLinkType: (LinkTypes) linkTypeToOpen;
@end
