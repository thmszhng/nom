//
//  MainMenuLayer.h
//  Nom
//
//  Created on 11-07-27.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"

@interface MainMenuLayer : CCLayer 
{
    CCMenu *mainMenu;
    CCMenuItem *SoundON;
    CCMenuItem *SoundOFF;
}

-(id) init;
-(void) playGame;
-(void) openGameOptions;
-(void) openGameCenter;
-(void) showHelp;
-(void) toggleSound: (id) sender;
@end