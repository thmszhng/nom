//
//  LevelLayer.m
//  Nom
//
//  Created on 11-09-02.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "LevelLayer.h"
#import "Render.h"

#import "GameManager.h"
#import "Level.h"

@implementation LevelLayer

-(void) onEnter
{
    CCRenderTexture *sprite = [[GameManager sharedGameManager].level drawWithSize: 10];
    sprite.position = ccp(160, 298);
    [self addChild: sprite];
}

@end
