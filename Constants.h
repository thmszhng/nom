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
    kGameOptionsScene = 2,
    kLevelEditorScene = 3,
    kHelpScene = 4,
    kGameScene = 101,
} SceneTypes;


typedef enum
{
    kBackgroundLayer = 200,
} MainMenuSceneLayers;

typedef enum
{
    kGameOptionsSceneBackgroundLayer = 300,
} GameOptionsSceneLayers;

typedef enum
{
    kLevelEditorsSceneBackgroundLayer = 400,
} LevelEditorsSceneLayers;

typedef enum 
{
    kHelpSceneBackgroundLayer = 500,
} HelpSceneLayers;

typedef enum
{
    kGameSceneBackgroundLayer = 600,
    kGameSceneGameplayLayer,
    kGameScenePauseLayer,
} GameSceneLayers;

extern int haveRetina;