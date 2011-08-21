//
//  LevelEditorLayer.m
//  Nom
//
//  Created by Eddy Gao on 11-08-20.
//  Copyright 2011 Eddy Gao, Geoffry Song, Thomas Zhang. All rights reserved.
//



#import "LevelEditorLayer.h"
@implementation LevelEditorLayer
-(id) init
{
    self = [super init];
    if (self != nil)
    {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCRenderTexture *texture = [CCRenderTexture renderTextureWithWidth: screenSize.width height: screenSize.height];
        [texture setPosition: CGPointMake (screenSize.width/2, screenSize.height/2)];
        [self addChild: texture z: 0];
        [texture beginWithClear: 1.f g: 1.f b: 1.f a: 1.f];
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisableClientState(GL_COLOR_ARRAY);
        
        for (int x = 0; x < 30; ++x) {
            for (int y = 0; y < 30; ++y) {
                int xx = 10 + x*10, yy = 170 + y*10;
                drawBox(xx, yy, 10, 10, 240, 240, 240, 255);
            }
        }
        
        glEnableClientState(GL_COLOR_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnable(GL_TEXTURE_2D);
        [texture end];

        
    }
    
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
@end


