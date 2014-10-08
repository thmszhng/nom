//
//  GameOverLayer.h
//  Nom
//
//  Created by Xamigo on 11-08-23.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface GameOverLayer : CCLayer {
    CCMenu *menu;
    CCSprite *background;
}

-(void) newGame;
-(void) finishRestart;
-(void) goToMainMenu;
-(void) setOpacity: (GLubyte) opacity;

@end
