//
//  Render.m
//  Nom
//
//  Created on 11-08-01.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "Render.h"
#import "Constants.h"

void glDrawRect(GLfloat x, GLfloat y, GLfloat width, GLfloat height)
{
    if (haveRetina)
    {
        x *= 2; y *= 2; width *= 2; height *= 2;
    }
    GLfloat vertices[8] = {
        x, y,
        x + width, y,
        x + width, y + height,
        x, y + height
    };
    glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

void drawBox(int x, int y, int width, int height, ccColor3B main, ccColor3B shadow)
{
    glColor4ub(255, 255, 255, 255);
    glDrawRect(x, y, width, height);
    glColor4ub(shadow.r, shadow.g, shadow.b, 255);
    glDrawRect(x, y+1, width-1, height-1);
    glColor4ub(main.r, main.g, main.b, 255);
    glDrawRect(x+1, y+1, width-2, height-2);
}

CCRenderTexture *getTexture(int entry)
{
    static CCRenderTexture* cache[16] = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil };
    
    const int width = 10, height = 10;
    BOOL ctop = entry & 1,
         cleft = entry & 2,
         cbottom = entry & 4,
         cright = entry & 8;
    if (cache[entry] == nil)
    {
        cache[entry] = [[CCRenderTexture alloc] initWithWidth: 10 height: 10 pixelFormat: kCCTexture2DPixelFormat_RGBA8888];
        [cache[entry] begin];
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glDisableClientState(GL_COLOR_ARRAY);
        
        glColor4ub(255, 255, 255, 255);
        glDrawRect(0, 0, width, height);
        glColor4ub(DARKEN(60), DARKEN(60), DARKEN(60), 255);
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
        glColor4ub(60, 60, 60, 255);
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
        
        glEnableClientState(GL_COLOR_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnable(GL_TEXTURE_2D);
        [cache[entry] end];
    }
    return cache[entry];
}

void drawSnake(int x, int y, BOOL ctop, BOOL cleft, BOOL cbottom, BOOL cright)
{
    const int width = 10, height = 10;
    int xx = x * width + 10, yy = y * height + 148;

    int entry = (ctop ? 1 : 0) | (cleft ? 2 : 0) | (cbottom ? 4 : 0) | (cright ? 8 : 0);
    CCSprite* sprite = [getTexture(entry) sprite];
    sprite.position = CGPointMake(xx + width/2, yy + height/2);
    [sprite visit];
}

CCSprite *createButton(NSString *string, CGSize size, CGFloat fontsize, BOOL selected, ccColor3B color)
{
    CCRenderTexture *texture = [[CCRenderTexture alloc]
                                initWithWidth: size.width
                                height: size.height
                                pixelFormat: kTexture2DPixelFormat_RGBA8888];
    if (selected)
    {
        [texture beginWithClear:0.64f g:1.f b:0.63f a:0.7f];
    }
    else
    {
        [texture beginWithClear:1.f g:1.f b:1.f a:0.f];
    }
    CCLabelTTF *label = [[CCLabelTTF alloc] initWithString: string
                                                dimensions: size
                                                 alignment: CCTextAlignmentLeft
                                                  fontName: @"Varela Round"
                                                  fontSize: fontsize];
    label.anchorPoint = CGPointMake(0.0f, 0.0f);
    label.position = CGPointMake(20 + (selected ? 2.0f : 0.0f),
                                 (selected ? -2.0f : 0.0f));
    label.color = color;
    [label visit];
    [label release];
    [texture end];
    CCSprite *ret = [[texture.sprite retain] autorelease];
    ret.scaleY = 1;
    ret.flipY = YES;
    [texture release];
    return ret;
}
