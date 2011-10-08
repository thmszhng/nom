//
//  Render.h
//  Nom
//
//  Created on 11-08-01.
//  Copyright Thomas Zhang, Geoffry Song, Eddy Gao. All rights reserved.
//

#import "cocos2d.h"

// takes points
void glDrawRect(GLfloat x, GLfloat y, GLfloat width, GLfloat height);
void drawBox(int x, int y, int width, int height, ccColor3B main, ccColor3B shadow);

CCRenderTexture *getTexture(int entry);
// grid coordinates
void drawSnake(int x, int y, BOOL ctop, BOOL cleft, BOOL cbottom, BOOL cright);

// returns a retain'd sprite
CCSprite *createButton(NSString *string, CGSize size, CGFloat fontsize, BOOL selected, ccColor3B color);

#define CLAMP(x, a, b) (((x)<(a))?(a):((x)>(b))?(b):(x))
//#define DARKEN(c) CLAMP(5*((int)(c))/4-128, 0, 255)
#define DARKEN(c) (((c)<=15)?0:((c)-15))