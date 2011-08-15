//
//  Constants.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

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

typedef enum
{
    kBackgroundLayer = 200,
    kGameplayLayer,
    kPauseLayer
} GameSceneLayers;

extern int haveRetina;