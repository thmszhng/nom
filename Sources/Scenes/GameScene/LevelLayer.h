//
//  LevelLayer.h
//  Nom
//
//  Created on 11-09-02.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"

@class GameplayLayer;

@interface LevelLayer : CCLayer {
    CCRenderTexture *sprite;
    GameplayLayer *theGameplayLayer;
}

@property (readwrite, assign) GameplayLayer *theGameplayLayer;
-(void) draw;
@end
