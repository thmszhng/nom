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
    kOptionsScene = 100,
    kMainMenuScene,
    kGameScene,
} SceneTypes;


typedef enum
{
    kAnimationLayer = 0,
    kMainMenuLayer,
    kHelpLayer,
} MainMenuSceneLayers;



typedef enum
{
    kOptionsBackgroundLayer = 0,
} OptionsSceneLayers;

typedef enum
{
    kGameBackgroundLayer = 600,
    kGameplayLayer,
    kPauseLayer,
} GameSceneLayers;

extern int haveRetina;