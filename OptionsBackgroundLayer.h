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
    
}

-(id) init;
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
