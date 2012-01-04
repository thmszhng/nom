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

@interface MainMenuLayer : CCLayer
{    
    CCMenu *mainMenu;
}

-(id) init;

-(void) playRegular;
-(void) playClassic;
-(void) playBurst;
-(void) startGame;

@end