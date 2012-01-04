//
//  PauseLayer.h
//  Nom
//
//  Created by Xamigo on 11-08-06.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"

@interface PauseLayer : CCLayer {
    CCMenu *pauseMenu;
    CCSprite *background;
}

-(void) resumeGame;
-(void) finishResume;
-(void) goToMainMenu;
-(void) setOpacity: (GLubyte) opacity;

@end
