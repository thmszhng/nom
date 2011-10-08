//
//  MainMenuLayer.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"
#import "HelpLayer.h"
#import <GameKit/GameKit.h>

@interface MainMenuLayer : CCLayer<GKLeaderboardViewControllerDelegate>
{
    BOOL isHelpShowing;
    
    CCMenu *mainMenu;
    CCMenuItem *SoundON;
    CCMenuItem *SoundOFF;
    UIViewController *vc;
}

-(id) init;
-(void) playGame;
-(void) openOptions;
-(void) openGameCenter;
-(void) showHelp;
-(void) onEnter;
-(void) onExit;
-(void) toggleSound: (id) sender;
@end