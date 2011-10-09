//
//  SpriteLoader.m
//  Nom
//
//  Created on 11-10-08.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "SpriteLoader.h"

#import "cocos2d.h"
#import "Constants.h"

CCSprite *loadSprite(NSString *name)
{
    static BOOL loaded = NO;
    if (!loaded)
    {
        // Cache sprites
        if (haveRetina)
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"spritesheet-1.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"spritesheet-2.plist"];
        }
        else
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"spritesheet.plist"];
        }
        loaded = YES;
    }
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName: name];
    return sprite;
/*    if (haveRetina) return sprite;
    CCRenderTexture *texture = [[CCRenderTexture alloc]
                                initWithWidth: sprite.contentSize.width / 2
                                height: sprite.contentSize.height / 2
                                pixelFormat: kCCTexture2DPixelFormat_RGBA8888];
    [texture begin];
    glScalef(0.5f, 0.5f, 1.0f);
    sprite.position = CGPointZero;
    sprite.anchorPoint = CGPointZero;
    [sprite visit];
    [texture end];
    sprite = [[texture.sprite retain] autorelease];
    sprite.scaleY = 1;
    sprite.flipY = YES;
    [texture release];
    return sprite;*/
}
