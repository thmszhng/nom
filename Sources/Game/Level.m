//
//  Level.m
//  Nom
//
//  Created by Thomas Zhang on 11-09-02.
//  Copyright 2011 Cisco. All rights reserved.
//

#import "Level.h"

#import "cocos2d.h"
#import "Render.h"

@implementation Level
-(id) init
{
    self = [super init];
    if (self != nil)
    {
/*        for (int i = 0; i < 30; i++)
        {
            for (int j = 0; j < 30; j++)
            {
                levelInfo[i][j] = LevelNothing;
            }
        }*/
    }
    
    return self;
}

+(id) level
{
    return [[[self alloc] init] autorelease];
}

-(enum LevelSpot) getValue: (int) i: (int) j
{
    return levelInfo[i][j];
}

-(void) setValue: (int) i: (int) j: (enum LevelSpot) value
{
    levelInfo[i][j] = value;
}

-(CCSprite *) drawWithSize: (int) size
{
    CCRenderTexture *texture = [CCRenderTexture renderTextureWithWidth: size*30 height: size*30];
    [texture beginWithClear: 1.f g: 1.f b: 1.f a: 1.f];
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    const int width = size, height = size;
    const float scale = [[CCDirector sharedDirector] winSizeInPixels].width / 320.f;
    
    for (int y = 0; y < 30; ++y) for (int x = 0; x < 30; ++x)
    {
        if (levelInfo[x][y] != LevelWall)
        {
            drawBox(x * size, y * size, size, size, ccc3(249, 249, 249), ccc3(240, 240, 240));
            continue;
        }
        const int light = 60,
                   dark = DARKEN(light);
        glPushMatrix();
        glTranslatef(x * size * scale, y * size * scale, 0);
        
        BOOL
        ctop = (y < 29 && levelInfo[x][y+1] == LevelWall),
        cright = (x < 29 && levelInfo[x+1][y] == LevelWall),
        cbottom = (y > 0 && levelInfo[x][y-1] == LevelWall),
        cleft = (x > 0 && levelInfo[x-1][y] == LevelWall),
        ctopright = ctop && cright && levelInfo[x+1][y+1] == LevelWall,
        cbottomright = cbottom && cright && levelInfo[x+1][y-1] == LevelWall,
        cbottomleft = cbottom && cleft && levelInfo[x-1][y-1] == LevelWall,
        ctopleft = ctop && cleft && levelInfo[x-1][y+1] == LevelWall;

        glColor4ub(dark, dark, dark, 255);
        if (cright && !ctop)
        {
            glDrawRect(0, 1, width, height-1);
        }
        else
        {
            glDrawRect(0, 1, width-1, height-1);
        }
        if (cbottom && !cleft)
        {
            glDrawRect(0, 0, 1, 1);
        }
        
        glColor4ub(light, light, light, 255);
        glDrawRect(1, 1, width-2, height-2);
        if (ctop)
        {
            glDrawRect(1, height-1, width-2, 1);
        }
        if (cright)
        {
            if (ctop)
            {
                glDrawRect(width-1, 1, 1, height-1);
            }
            else
            {
                glDrawRect(width-1, 1, 1, height-2);
            }
        }
        if (cbottom)
        {
            glDrawRect(1, 0, width-2, 1);
        }
        if (cleft)
        {
            if (cbottom)
            {
                glDrawRect(0, 0, 1, height-1);
            }
            else
            {
                glDrawRect(0, 1, 1, height-2);
            }
        }
        if (ctopright)
        {
            glDrawRect(width-1, height-1, 1, 1);
        }
        if (cbottomright)
        {
            glDrawRect(width-1, 0, 1, 1);
        }
        if (cbottomleft)
        {
            glDrawRect(0, 0, 1, 1);
        }
        if (ctopleft)
        {
            glDrawRect(0, height-1, 1, 1);
        }
        
        glPopMatrix();
    }
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    [texture end];
    CCSprite *ret = [[texture.sprite retain] autorelease];
    ret.flipY = YES;
    ret.scaleY = 1;
    return ret;
}

@end
