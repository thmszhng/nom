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
    kMainMenuScene,
    kGameScene,
} SceneTypes;

typedef enum
{
    kAnimationLayer = 200,
    kMainMenuLayer,
    kHelpLayer,
} MainMenuSceneLayers;

typedef enum
{
    kGameBackgroundLayer = 400,
    kGameLevelLayer,
    kGameplayLayer,
    kPauseLayer,
} GameSceneLayers;

extern int haveRetina;