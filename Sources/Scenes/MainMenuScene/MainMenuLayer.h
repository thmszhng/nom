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

@interface MainMenuLayer : CCLayer
{
    BOOL isHelpShowing;
    
    CCMenu *mainMenu;
    CCMenuItem *SoundON;
    CCMenuItem *SoundOFF;
}

-(id) init;

-(void) playRegular;
-(void) playClassic;
-(void) playBurst;
-(void) showHelp;

-(void) onEnter;
-(void) onExit;
-(void) toggleSound: (id) sender;
@end