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

/*
typedef enum
{
} MainMenuSceneLayers;
*/
/*
typedef enum
{
} GameOptionsSceneLayers;
 */

typedef enum
{
    kLevelEditorLayer = 800,
} LevelEditorsSceneLayers;

/*
typedef enum 
{
} HelpSceneLayers;
 */
typedef enum
{
    kGameBackgroundLayer = 600,
    kGameplayLayer,
    kPauseLayer,
} GameSceneLayers;

extern int haveRetina;