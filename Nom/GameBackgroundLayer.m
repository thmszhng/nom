//
//  BackgroundLayer.m
//  Snake
//
//  Created on 11-07-24.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "GameBackgroundLayer.h"
#import "Render.h"

@implementation GameBackgroundLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCRenderTexture *texture = [CCRenderTexture renderTextureWithWidth: 300 height: 300];
        [texture setPosition: CGPointMake (screenSize.width/2, 298)];
        [self addChild: texture z: 0];
        [texture beginWithClear: 1.f g: 1.f b: 1.f a: 1.f];
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisableClientState(GL_COLOR_ARRAY);
        
        for (int x = 0; x < 30; ++x) {
            for (int y = 0; y < 30; ++y) {
                int xx = x*10, yy = y*10;
                drawBox(xx, yy, 10, 10, 240, 240, 240, 255);
            }
        }
        
        glEnableClientState(GL_COLOR_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnable(GL_TEXTURE_2D);
        [texture end];
        
        CCSprite *control;
        control = [CCSprite spriteWithFile: @"Control.png"];
        [control setPosition: CGPointMake (screenSize.width/2, 74)];
        [self addChild: control z: 1];
        
        CCSprite *bg;
        bg = [CCSprite spriteWithFile: @"GameBackground.png"];
        [bg setPosition: CGPointMake (screenSize.width/2, screenSize.height/2)];
        [self addChild: bg z: -1];
    }
    
    return self;
}
@end
