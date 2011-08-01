//
//  Constants.h
//  Nom
//
//  Created by Qian Zhang on 11-07-27.
//  Copyright 2011 Cisco. All rights reserved.
//


//the game refreshes at (60/GAMESPEED) Hz
//#define GAMESPEED 10

#define INITIAL_SPEED (0.25)
// #define SPEED_BOOST(x) (1./(1./(x)+1.))
#define SPEED_BOOST(x) ((x) * 0.95)

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

extern int haveRetina;