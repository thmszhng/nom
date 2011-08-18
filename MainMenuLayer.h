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
}

-(id) init;
-(void) playGame;
-(void) openLevelEditor;
-(void) openGameCenter;
-(void) showHelp;
-(void) toggleMusic;
@end