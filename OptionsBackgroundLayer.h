//
//  OptionsBackgroundLayer.h
//  Nom
//
//  Created by Thomas Zhang on 11-08-24.
//  Copyright 2011 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameManager.h"

@interface OptionsBackgroundLayer : CCLayer {
    CCMenu *optionsMenu;
    CCMenuItemImage *slowButton, *mediumButton, *fastButton;
}

-(id) init;
-(void) playGame;
-(void) setSlow;
-(void) setMedium;
-(void) setFast;

@end
