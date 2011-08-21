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

#define CLAMP(x, a, b) (((x)<(a))?(a):((x)>(b))?(b):(x))
//#define DARKEN(c) CLAMP(5*((int)(c))/4-128, 0, 255)
#define DARKEN(c) (((c)<=15)?0:((c)-15))

void drawBox(int x, int y, int width, int height, GLubyte r, GLubyte g, GLubyte b, GLubyte a)
{
    if (a == 255)
    {
        glColor4ub(255, 255, 255, 255);
        glDrawRect(x, y, width, height);
        glColor4ub(DARKEN(r), DARKEN(g), DARKEN(b), 255);
        glDrawRect(x, y+1, width-1, height-1);
        glColor4ub(r, g, b, 255);
        glDrawRect(x+1, y+1, width-2, height-2);
    }
    else
    {
        glColor4ub(255, 255, 255, a);
        glDrawRect(x + width - 1, y, 1, height);
        glDrawRect(x, y, width - 1, 1);
        glColor4ub(DARKEN(r), DARKEN(g), DARKEN(b), a);
        glDrawRect(x, y + height - 1, width-1, 1);
        glDrawRect(x, y+1, 1, height-2);
        glColor4ub(r, g, b, a);
        glDrawRect(x+1, y+1, width-2, height-2);
    }
}

void drawSnake(int x, int y, BOOL ctop, BOOL cleft, BOOL cbottom, BOOL cright) {
    static CCRenderTexture* cache[16] = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil };

    const int width = 10, height = 10;
    int xx = x * width + 10, yy = y * height + 148;

    int entry = (ctop ? 1 : 0) | (cleft ? 2 : 0) | (cbottom ? 4 : 0) | (cright ? 8 : 0);
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
    CCSprite* sprite = [cache[entry] sprite];
    sprite.position = CGPointMake(xx + width/2, yy + height/2);
    [sprite visit];
}
