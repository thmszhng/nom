//
//  Constants.h
//  Nom
//
//  Created by Qian Zhang on 11-07-27.
//  Copyright 2011 Cisco. All rights reserved.
//

#define GAMESPEED 3

#define kMainMenuTagValue 10 
#define kGameSceneTagValue 20

typedef enum 
{ 
    kNoSceneUninitialized = 0, 
    kMainMenuScene = 1, 
    kGameScene = 101,
} SceneTypes;

typedef enum 
{ 
    kLinkTypeDeveloperSite,
} LinkTypes;